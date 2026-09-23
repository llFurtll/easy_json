part of '../strategies.dart';

/// Tipos escalares que não são nativos do JSON (ou que o JSON representa de
/// outro jeito) e precisam de conversão explícita quando aparecem como item
/// de `List`/`Set` ou valor de `Map`.
///
/// Antes disso, cada parser de coleção tinha sua própria cópia da lógica de
/// tipo e esses tipos caíam num `(e as T)` genérico — que não compilava ou
/// quebrava em execução (ex.: `List<DateTime>` vindo do JSON como strings).
/// A decodificação fica em funções do runtime (`ej.decodeX`), que devolvem
/// `null` quando o valor é inválido.
class _RichScalar {
  _RichScalar({
    required this.decoder,
    required this.encode,
    required this.fallback,
    required this.expected,
    this.formatCode,
    this.formatMessage,
  });

  /// Função do runtime que devolve `T?` (null = inválido). Ex.: `ej.decodeUri`.
  final String decoder;

  /// Expressão que converte um valor não-nulo [v] para JSON.
  final String Function(String v) encode;

  /// Valor não-nulo usado pelo modo safe quando o item é inválido.
  final String fallback;

  /// Mensagem de `type_mismatch`.
  final String expected;

  /// Código mais específico quando o valor é uma String, mas inválida
  /// (ex.: `invalid_uri`). Sem ele, tudo é `type_mismatch`.
  final String? formatCode;
  final String? formatMessage;

  /// Expressão `EasyIssue(...)` para um valor inválido [v] em [path].
  String issue(String v, String path) {
    final mismatch =
        "EasyIssue(path: $path, code: 'type_mismatch', message: '$expected')";
    if (formatCode == null) return mismatch;
    return "($v is String ? EasyIssue(path: $path, code: '$formatCode', message: '$formatMessage') : $mismatch)";
  }
}

_RichScalar? _richScalar(DartType t) {
  switch (displayNonNull(t)) {
    case 'num':
      return _RichScalar(
        decoder: 'ej.decodeNum',
        encode: (v) => v,
        fallback: '0',
        expected: 'Expected number.',
      );
    case 'DateTime':
      return _RichScalar(
        decoder: 'ej.decodeDateTime',
        encode: (v) => '$v.toIso8601String()',
        fallback: 'DateTime.fromMillisecondsSinceEpoch(0)',
        expected: 'Expected ISO-8601 String or epoch milliseconds.',
      );
    case 'Uri':
      return _RichScalar(
        decoder: 'ej.decodeUri',
        encode: (v) => '$v.toString()',
        fallback: 'Uri()',
        expected: 'Expected String (URI).',
        formatCode: 'invalid_uri',
        formatMessage: 'Invalid URI.',
      );
    case 'Duration':
      return _RichScalar(
        decoder: 'ej.decodeDuration',
        encode: (v) => '$v.inMicroseconds',
        fallback: 'Duration.zero',
        expected: 'Expected number of microseconds.',
      );
    case 'BigInt':
      return _RichScalar(
        decoder: 'ej.decodeBigInt',
        encode: (v) => '$v.toString()',
        fallback: 'BigInt.zero',
        expected: 'Expected String (integer) or int.',
        formatCode: 'invalid_bigint',
        formatMessage: 'Invalid integer string.',
      );
    case 'Uint8List':
      return _RichScalar(
        decoder: 'ej.decodeBytes',
        encode: (v) => 'base64Encode($v)',
        fallback: 'Uint8List(0)',
        expected: 'Expected String (Base64).',
        formatCode: 'invalid_base64',
        formatMessage: 'Invalid Base64 string.',
      );
  }
  return null;
}

/// Parse rápido (fromJson normal) de [src]: lança `FormatException` se inválido.
String _fastRich(_RichScalar rs, DartType type, String src) {
  final parse =
      "(${rs.decoder}($src) ?? (throw FormatException('Invalid ${displayNonNull(type)} value.')))";
  return displayWithNull(type).endsWith('?')
      ? "$src == null ? null : $parse"
      : parse;
}

/// Parse safe de [src] (nunca lança): inválido -> issue em [path] + fallback.
String _safeRich(
  _RichScalar rs,
  DartType type,
  String src,
  String path, {
  String? customFallback,
}) {
  final nullable = displayWithNull(type).endsWith('?');
  final fallback = customFallback ?? rs.fallback;
  final onNull = nullable
      ? 'return null;'
      : "onIssue?.call(EasyIssue(path: $path, code: 'null_not_allowed', message: 'Null value not allowed.')); return $fallback;";
  return """
    (() {
      final v = $src;
      if (v == null) { $onNull }
      final r = ${rs.decoder}(v);
      if (r != null) return r;
      onIssue?.call(${rs.issue('v', path)});
      return ${customFallback ?? (nullable ? 'null' : rs.fallback)};
    })()
  """;
}

/// Checagem de validate para um item/valor não-nulo [v] de tipo rico.
String _validateRich(_RichScalar rs, String v, String path) =>
    "if (${rs.decoder}($v) == null) { issues.add(${rs.issue(v, path)}); }";

/// `e.map(...)` de toJson para itens que são tipos ricos, ou null se não for.
String? _richEncodeItem(DartType item) {
  final rs = _richScalar(item);
  if (rs == null) return null;
  return displayWithNull(item).endsWith('?')
      ? "e == null ? null : ${rs.encode('e')}"
      : rs.encode('e');
}
