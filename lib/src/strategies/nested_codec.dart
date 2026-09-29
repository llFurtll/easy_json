part of '../strategies.dart';

// Conversão recursiva para tipos que têm outro tipo dentro: coleções dentro
// de coleções (`List<List<int>>`, `Map<String, List<int>>`), parâmetros de
// tipo em qualquer coleção (`Set<T>`, `Map<String, T>`) e classes @EasyJson
// genéricas (`Page<User>`). As estratégias de campo continuam cuidando das
// anotações (conversores, fallbacks, @EasyPath) e delegam para cá o tipo do
// item/valor — ou o campo inteiro, no caso de uma classe genérica.
//
// `d` é a profundidade: nomeia as variáveis de cada nível (`x0`, `i1`, ...)
// para que um nível não esconda as variáveis do nível de fora.

/// O tipo precisa do codec (em vez dos parsers de item de um nível só)?
bool _viaCodec(DartType t) =>
    t is TypeParameterType ||
    _collectionKind(t) != null ||
    (t is InterfaceType && t.typeArguments.isNotEmpty && isEasyJsonClass(t));

String? _collectionKind(DartType t) =>
    t is InterfaceType && const {'List', 'Set', 'Map'}.contains(t.element.name)
    ? t.element.name
    : null;

/// `const ` para literais vazios, exceto quando o tipo usa um parâmetro de
/// tipo (`const <T>[]` é inválido).
String _constFor(DartType t) => containsTypeParameter(t) ? '' : 'const ';

bool _isNullable(DartType t) => displayWithNull(t).endsWith('?');

/// `dynamic` / `Object`: o valor passa como veio.
bool _isAny(DartType t) => t is DynamicType || t.isDartCoreObject;

List<DartType> _args(DartType t) =>
    t is InterfaceType ? t.typeArguments : const [];

String _typeArgs(List<DartType> args) => args.map(displayWithNull).join(', ');

/// `userFromJson` -> prefixo `user`, sem os argumentos de tipo.
String _fnPrefix(DartType t) =>
    _lcFirst((t as InterfaceType).element.displayName);

/// `<User>` para chamar as funções geradas de uma classe genérica, ou ''.
String _callTypeArgs(DartType t) =>
    _args(t).isEmpty ? '' : '<${_typeArgs(_args(t))}>';

bool _isIntKey(DartType k) {
  final name = displayNonNull(k);
  if (name == 'int') return true;
  if (name == 'String') return false;
  throw InvalidGenerationSourceError(
    'Map keys inside nested collections and generic classes must be String '
    'or int (found `${k.getDisplayString()}`).',
  );
}

Never _unsupported(DartType t) => throw InvalidGenerationSourceError(
  '`${t.getDisplayString()}` is not supported inside a nested collection or '
  'a generic class.',
);

String _issue(String path, String code, String message) =>
    "onIssue?.call(EasyIssue(path: $path, code: '$code', message: '$message'));";

// ===== fromJson =====

/// Expressão que converte [v] para [t] (lança se o valor for inválido).
String _cFast(DartType t, String v, [int d = 0]) {
  if (_isAny(t)) return v;
  final nn = t is TypeParameterType
      ? 'fromJson${displayNonNull(t)}($v)'
      : _cFastNonNull(t, v, d);
  return _isNullable(t) ? '($v == null ? null : $nn)' : nn;
}

String _cFastNonNull(DartType t, String v, int d) {
  final args = _args(t);
  final e = 'e$d';
  switch (_collectionKind(t)) {
    case 'List':
      return '<${displayWithNull(args[0])}>[for (final $e in ($v as List)) ${_cFast(args[0], e, d + 1)}]';
    case 'Set':
      return '<${displayWithNull(args[0])}>{for (final $e in ($v as List)) ${_cFast(args[0], e, d + 1)}}';
    case 'Map':
      final m = 'm$d';
      final key = _isIntKey(args[0])
          ? '($m.key is num ? ($m.key as num).toInt() : int.parse($m.key as String))'
          : '$m.key.toString()';
      return '<${_typeArgs(args)}>{for (final $m in ($v as Map).entries) $key: ${_cFast(args[1], '$m.value', d + 1)}}';
  }
  if (isEasyJsonClass(t)) {
    final convs = args.map((a) => ', (Object? $e) => ${_cFast(a, e, d + 1)}').join();
    return '${_fnPrefix(t)}FromJson${_callTypeArgs(t)}(Map<String, dynamic>.from($v as Map)$convs)';
  }
  if (isEnumType(t)) return '${displayNonNull(t)}.values.byName($v as String)';
  final rs = _richScalar(t);
  if (rs != null) {
    return "(${rs.decoder}($v) ?? (throw FormatException('Invalid ${displayNonNull(t)} value.')))";
  }
  return switch (displayNonNull(t)) {
    'double' => '($v as num).toDouble()',
    'int' || 'bool' || 'String' => '($v as ${displayNonNull(t)})',
    _ => _unsupported(t),
  };
}

// ===== fromJsonSafe =====

/// Expressão que converte [v] para [t] sem lançar: valor inválido vira issue
/// em [path] (via `onIssue`) e o fallback do tipo.
String _cSafe(DartType t, String v, String path, [int d = 0]) {
  if (_isAny(t)) return v;
  final x = 'x$d';
  if (t is TypeParameterType) {
    final name = displayNonNull(t);
    // `T` não-nulo não tem fallback possível: depende do conversor.
    if (!_isNullable(t)) return 'fromJson$name($v)';
    return '(() { final $x = $v; if ($x == null) return null; '
        'try { return fromJson$name($x); } catch (_) { '
        "${_issue(path, 'type_mismatch', 'Could not convert value to $name.')} return null; } })()";
  }
  final nullable = _isNullable(t);
  final fb = nullable ? 'null' : _cFallback(t, path, d);
  final onNull = nullable
      ? 'return null;'
      : "${_issue(path, 'null_not_allowed', 'Null value not allowed.')} return $fb;";
  return '(() { final $x = $v; if ($x == null) { $onNull } ${_cSafeBody(t, x, path, fb, d)} })()';
}

/// Comandos que devolvem [x] (não-nulo) convertido para [t], ou [fb].
String _cSafeBody(DartType t, String x, String path, String fb, int d) {
  final args = _args(t);
  String mismatch(String message) =>
      "${_issue(path, 'type_mismatch', message)} return $fb;";

  final kind = _collectionKind(t);
  if (kind == 'List' || kind == 'Set') {
    final i = 'i$d';
    final (open, close) = kind == 'Set' ? ('{', '}') : ('[', ']');
    final item = _cSafe(args[0], '$x[$i]', "$path + '[' + $i.toString() + ']'", d + 1);
    return 'if ($x is! List) { ${mismatch(kind == 'Set' ? 'Expected List for Set.' : 'Expected List.')} } '
        'return <${displayWithNull(args[0])}>$open'
        'for (var $i = 0; $i < $x.length; $i++) $item$close;';
  }
  if (kind == 'Map') {
    final m = 'm$d', k = 'k$d', o = 'o$d';
    final entryPath = "$path + '.' + $m.key.toString()";
    final key = _coerceMapKeySafe(
      '$m.key',
      _isIntKey(args[0]) ? EasyMapKeyType.int : EasyMapKeyType.string,
    );
    return "if ($x is! Map) { ${mismatch('Expected Map.')} } "
        'final $o = <${_typeArgs(args)}>{}; '
        'for (final $m in $x.entries) { '
        'final $k = $key; '
        "if ($k == null) { ${_issue(entryPath, 'key_type_mismatch', 'Incompatible key type for map.')} continue; } "
        '$o[$k] = ${_cSafe(args[1], '$m.value', entryPath, d + 1)}; } '
        'return $o;';
  }
  if (isEasyJsonClass(t)) {
    final cn = (t as InterfaceType).element.displayName;
    return "if ($x is! Map) { ${mismatch('Expected Map for $cn.')} } "
        'return ${_cClassSafe(t, 'Map<String, dynamic>.from($x)', path, d)};';
  }
  if (isEnumType(t)) {
    final en = displayNonNull(t);
    final z = 'z$d';
    return 'if ($x is String) { '
        'for (final $z in $en.values) { if ($z.name == $x) return $z; } '
        "onIssue?.call(EasyIssue(path: $path, code: 'invalid_enum', message: \"Value '\$$x' does not match $en.\")); "
        'return $fb; } '
        '${mismatch('Expected String with enum name.')}';
  }
  final rs = _richScalar(t);
  if (rs != null) {
    final r = 'r$d';
    return 'final $r = ${rs.decoder}($x); if ($r != null) return $r; '
        'onIssue?.call(${rs.issue(x, path)}); return $fb;';
  }
  return switch (displayNonNull(t)) {
    'double' => 'if ($x is num) return $x.toDouble(); ${mismatch('Expected number (int/double).')}',
    final base && ('int' || 'bool' || 'String') =>
      'if ($x is $base) return $x; ${mismatch('Expected $base.')}',
    _ => _unsupported(t),
  };
}

/// `xFromJsonSafe(...)` de uma classe @EasyJson, com as issues do filho
/// prefixadas por [path].
String _cClassSafe(DartType t, String json, String path, int d) {
  final e = 'e$d', n = 'n$d';
  // Os conversores de `T` ficam mudos (onIssue = null): o conteúdo de `T` é
  // reportado pelo validate, com o path exato — o conversor só recebe o
  // valor, sem saber onde ele está.
  final convs = _args(t)
      .map((a) => ', (Object? $e) => ((void Function(EasyIssue)? onIssue) => ${_cSafe(a, e, path, d + 1)})(null)')
      .join();
  return '${_fnPrefix(t)}FromJsonSafe${_callTypeArgs(t)}($json$convs, '
      'onIssue: ($n) => onIssue?.call(EasyIssue(path: $path + \'.\' + $n.path, code: $n.code, message: $n.message)), '
      'runValidate: false)';
}

/// Valor de [t] (não-nulo) usado quando o JSON é inválido.
String _cFallback(DartType t, String path, int d) {
  final args = _args(t);
  switch (_collectionKind(t)) {
    case 'List':
      return '<${displayWithNull(args[0])}>[]';
    case 'Set':
      return '<${displayWithNull(args[0])}>{}';
    case 'Map':
      return '<${_typeArgs(args)}>{}';
  }
  if (isEasyJsonClass(t)) {
    return _cClassSafe(t, 'const <String, dynamic>{}', path, d);
  }
  if (isEnumType(t)) return '${displayNonNull(t)}.values.first';
  final rs = _richScalar(t);
  if (rs != null) return rs.fallback;
  return switch (displayNonNull(t)) {
    'int' => '0',
    'double' => '0.0',
    'bool' => 'false',
    'String' => "''",
    _ => _unsupported(t),
  };
}

// ===== validate =====

/// Checagens de validate para [v] (pode ser null).
String _cValidate(DartType t, String v, String path, [int d = 0]) {
  if (_isAny(t)) return '';
  final x = 'x$d';
  if (t is TypeParameterType) {
    return '{ final $x = $v; if ($x != null) { ${_cValidateNonNull(t, x, path, d)} } }';
  }
  final onNull = _isNullable(t)
      ? ''
      : "issues.add(EasyIssue(path: $path, code: 'null_not_allowed', message: 'Null value not allowed.'));";
  return '{ final $x = $v; if ($x == null) { $onNull } else { ${_cValidateNonNull(t, x, path, d)} } }';
}

/// Checagens de validate para [x], já sabido não-nulo.
String _cValidateNonNull(DartType t, String x, String path, [int d = 0]) {
  if (_isAny(t)) return '';
  final n = 'n$d';
  String prefixed(String issuesExpr, String sep) =>
      'for (final $n in $issuesExpr) { '
      'issues.add(EasyIssue(path: $path$sep$n.path, code: $n.code, message: $n.message)); }';
  if (t is TypeParameterType) {
    // Só o validador recebido (`validateT`) sabe o que `T` é.
    final v = 'validate${displayNonNull(t)}';
    return 'if ($v != null) { ${prefixed('$v($x)', ' + ')} }';
  }
  final args = _args(t);
  String mismatch(String message) =>
      "issues.add(EasyIssue(path: $path, code: 'type_mismatch', message: '$message'));";

  final kind = _collectionKind(t);
  if (kind == 'List' || kind == 'Set') {
    final i = 'i$d';
    return 'if ($x is! List) { ${mismatch(kind == 'Set' ? 'Expected List for Set.' : 'Expected List.')} } else { '
        'for (var $i = 0; $i < $x.length; $i++) { '
        "${_cValidate(args[0], '$x[$i]', "$path + '[' + $i.toString() + ']'", d + 1)} } }";
  }
  if (kind == 'Map') {
    final m = 'm$d';
    final entryPath = "$path + '.' + $m.key.toString()";
    final keyCheck = _isIntKey(args[0])
        ? "if (!($m.key is num || ($m.key is String && num.tryParse($m.key as String) != null))) { "
              "issues.add(EasyIssue(path: $entryPath, code: 'key_type_mismatch', message: 'Incompatible key type for map.')); } "
        : '';
    return "if ($x is! Map) { ${mismatch('Expected Map.')} } else { "
        'for (final $m in $x.entries) { $keyCheck'
        '${_cValidate(args[1], '$m.value', entryPath, d + 1)} } }';
  }
  if (isEasyJsonClass(t)) {
    final el = (t as InterfaceType).element;
    final e = 'e$d';
    // Com os argumentos de tipo conhecidos, valida também o conteúdo de `T`.
    final validators = [
      for (final (i, a) in args.indexed)
        ', validate${el.typeParameters[i].displayName}: ${a is TypeParameterType ? 'validate${displayNonNull(a)}' : '(Object? $e) { final issues = <EasyIssue>[]; ${_cValidate(a, e, "''", d + 1)} return issues; }'}',
    ].join();
    return "if ($x is! Map) { ${mismatch('Expected Map for ${el.displayName}.')} } else { "
        "${prefixed('${_fnPrefix(t)}Validate${_callTypeArgs(t)}(Map<String, dynamic>.from($x)$validators)', " + '.' + ")} }";
  }
  if (isEnumType(t)) {
    final en = displayNonNull(t);
    return "if ($x is! String) { ${mismatch('Expected String with enum name.')} } "
        'else if (!$en.values.any((z) => z.name == $x)) { '
        "issues.add(EasyIssue(path: $path, code: 'invalid_enum', message: \"Value '\$$x' does not match $en.\")); }";
  }
  final rs = _richScalar(t);
  if (rs != null) return _validateRich(rs, x, path);
  final base = displayNonNull(t);
  return switch (base) {
    'double' => 'if ($x is! num) { ${mismatch('Expected double.')} }',
    'int' || 'bool' || 'String' => 'if ($x is! $base) { ${mismatch('Expected $base.')} }',
    _ => _unsupported(t),
  };
}

// ===== toJson =====

/// Expressão que converte [v] (do tipo [t]) para JSON. Para [t] nullable,
/// [v] tem de ser uma variável local (promovida no `v == null ? ...`).
String _cEncode(DartType t, String v, [int d = 0]) {
  if (_isAny(t)) return v;
  final nullable = _isNullable(t);
  final q = nullable ? '?' : '';
  final e = 'e$d';
  if (t is TypeParameterType) {
    final name = displayNonNull(t);
    return nullable
        ? '($v == null ? null : toJson$name($v as $name))'
        : 'toJson$name($v)';
  }
  final args = _args(t);
  switch (_collectionKind(t)) {
    case 'List':
      final item = _cEncode(args[0], e, d + 1);
      return item == e ? v : '$v$q.map(($e) => $item).toList()';
    case 'Set':
      return '$v$q.map(($e) => ${_cEncode(args[0], e, d + 1)}).toList()';
    case 'Map':
      final k = 'k$d';
      // Objetos JSON só têm chaves String.
      final key = _isIntKey(args[0]) ? '$k.toString()' : k;
      final value = _cEncode(args[1], e, d + 1);
      return key == k && value == e
          ? v
          : '$v$q.map(($k, $e) => MapEntry($key, $value))';
  }
  if (isEasyJsonClass(t)) {
    final convs = args.map((a) => '($e) => ${_cEncode(a, e, d + 1)}').join(', ');
    return '$v$q.toJson($convs)';
  }
  if (isEnumType(t)) return '$v$q.name';
  final rs = _richScalar(t);
  if (rs != null) {
    return nullable ? '($v == null ? null : ${rs.encode(v)})' : rs.encode(v);
  }
  return v;
}
