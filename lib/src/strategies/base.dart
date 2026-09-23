part of '../strategies.dart';

abstract class TypeStrategy {
  String fromJson(FieldContext c);
  String fromJsonSafe(FieldContext c);
  void validate(FieldContext c, StringBuffer out);
  String toJson(FieldContext c);
}

/// Helper para gerar a estrutura de validação (check de required + extração de valor).
void _validateField(FieldContext c, StringBuffer out, String checkBody) {
  final hasCtorDefault =
      c.enclosingClass.unnamedConstructor?.formalParameters
          .firstWhereOrNull((p) => p.name == c.name)
          ?.defaultValueCode !=
      null;

  if (c.easyPath != null) {
    // Com EasyPath, não usamos containsKey na raiz. Verificamos se o valor extraído é nulo.
    out.writeln("{");
    out.writeln("final v = ${c.jsonAccessor};");
    if (!c.isNullable && !hasCtorDefault) {
      out.writeln(
        "if (v == null) { issues.add(EasyIssue(path: ${c.pathExpr}, code: 'missing_required', message: 'Missing required field.')); }",
      );
    }
    out.writeln(checkBody);
    out.writeln("}");
  } else {
    // Padrão: verifica containsKey para ser preciso sobre "missing field".
    if (!c.isNullable && !hasCtorDefault) {
      out.writeln(
        "if (!json.containsKey('${c.jsonKey}')) { issues.add(EasyIssue(path: ${c.pathExpr}, code: 'missing_required', message: 'Missing required field.')); }",
      );
      // A chave presente com `null` num campo não-nullable também é um
      // problema (antes passava em silêncio e o safe usava o fallback).
      // Campos `T` ficam de fora: `T` pode ser instanciado como nullable.
      if (!c.isTypeParameter) {
        out.writeln(
          "if (json.containsKey('${c.jsonKey}') && json['${c.jsonKey}'] == null) { issues.add(EasyIssue(path: ${c.pathExpr}, code: 'null_not_allowed', message: 'Null value not allowed.')); }",
        );
      }
    }
    out.writeln(
      "if (json.containsKey('${c.jsonKey}')) { final v = ${c.jsonAccessor}; $checkBody }",
    );
  }
}

void _generateValidationChecks(FieldContext c, StringBuffer out) {
  final validator = c.validator;
  if (validator == null) return;

  final type = c.type;
  final isString = displayNonNull(type) == 'String';
  final isNum =
      type.isDartCoreNum || type.isDartCoreInt || type.isDartCoreDouble;
  final isCollection = c.isList || c.isSet || c.isMap;

  // minLength
  final minLength = validator.peek('minLength')?.intValue;
  if (minLength != null && (isString || isCollection)) {
    final accessor = 'v.length'; // .length works for String, List, Set, Map
    out.writeln(
      "if ($accessor < $minLength) { issues.add(EasyIssue(path: ${c.pathExpr}, code: 'min_length', message: 'Must have at least $minLength ${isString ? 'characters' : 'elements'}.')); }",
    );
  }

  // maxLength
  final maxLength = validator.peek('maxLength')?.intValue;
  if (maxLength != null && (isString || isCollection)) {
    final accessor = 'v.length';
    out.writeln(
      "if ($accessor > $maxLength) { issues.add(EasyIssue(path: ${c.pathExpr}, code: 'max_length', message: 'Must have at most $maxLength ${isString ? 'characters' : 'elements'}.')); }",
    );
  }

  // regex
  final regex = validator.peek('regex')?.stringValue;
  if (regex != null && isString) {
    out.writeln(
      "if (!RegExp(${_dartStringLiteral(regex)}).hasMatch(v as String)) { issues.add(EasyIssue(path: ${c.pathExpr}, code: 'regex_mismatch', message: 'Invalid format.')); }",
    );
  }

  // format
  final formatReader = validator.peek('format');
  if (formatReader != null && !formatReader.isNull && isString) {
    final formatName = formatReader.revive().accessor.split('.').last;
    String? regex;
    String code = 'format_mismatch';
    String message = 'Invalid format.';

    switch (formatName) {
      case 'email':
        regex =
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
        code = 'invalid_email';
        message = 'Invalid email.';
        break;
      case 'url':
        regex =
            r'^(https|http)://[-a-zA-Z0-9@:%._+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_+.~#?&//=]*)$';
        code = 'invalid_url';
        message = 'Invalid URL.';
        break;
      case 'uuid':
        regex =
            r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$';
        code = 'invalid_uuid';
        message = 'Invalid UUID.';
        break;
    }
    if (regex != null) {
      out.writeln(
        "if (!RegExp(${_dartStringLiteral(regex)}).hasMatch(v as String)) { issues.add(EasyIssue(path: ${c.pathExpr}, code: '$code', message: '$message')); }",
      );
    }
  }

  // min
  final minReader = validator.peek('min');
  if (minReader != null && isNum) {
    final min = minReader.literalValue as num;
    out.writeln(
      "if ((v as num) < $min) { issues.add(EasyIssue(path: ${c.pathExpr}, code: 'min_value', message: 'The minimum value is $min.')); }",
    );
  }

  // max
  final maxReader = validator.peek('max');
  if (maxReader != null && isNum) {
    final max = maxReader.literalValue as num;
    out.writeln(
      "if ((v as num) > $max) { issues.add(EasyIssue(path: ${c.pathExpr}, code: 'max_value', message: 'The maximum value is $max.')); }",
    );
  }

  // custom
  if (c.customValidatorFn != null) {
    final fieldType = displayNonNull(c.type);
    out.writeln(
      "if (!(${c.customValidatorFn!}(v as $fieldType))) { issues.add(EasyIssue(path: ${c.pathExpr}, code: 'custom_validation_failed', message: 'Custom validation failed.')); }",
    );
  }
}

/// Literal de string Dart (aspas simples, não-raw) que representa `s`
/// exatamente. Uma raw string (`r'...'`) não serve: nela `\'` não escapa a
/// aspa, então qualquer regex contendo `'` (ex.: a de email) quebrava o
/// código gerado.
String _dartStringLiteral(String s) {
  final escaped = s
      .replaceAll(r'\', r'\\')
      .replaceAll("'", r"\'")
      .replaceAll(r'$', r'\$')
      .replaceAll('\n', r'\n')
      .replaceAll('\r', r'\r');
  return "'$escaped'";
}

String _enumFallbackExpr(String enumName, String? fallbackName) =>
    (fallbackName == null || fallbackName.isEmpty)
    ? "$enumName.values.first"
    : "$enumName.values.firstWhere((e)=>e.name=='$fallbackName', orElse: ()=>$enumName.values.first)";

/// Expressão Dart para o valor de `@EasyKey(fallback / itemFallback)` no
/// tipo [t]. Se o valor não servir para o tipo (ou o tipo não suportar
/// fallback), lança um erro de build claro — antes o valor ia "cru" para o
/// código gerado, que às vezes não compilava e às vezes o ignorava.
String _customValueExpr(Object value, DartType t, FieldContext c, String param) {
  final shown = value is String ? "'$value'" : '$value';
  Never bad(String why) => throw InvalidGenerationSourceError(
    '@EasyKey($param: $shown) on `${c.enclosingClass.displayName}.${c.name}` '
    '(`${t.getDisplayString()}`): $why',
    element: c.element,
  );

  switch (displayNonNull(t)) {
    case 'int':
      if (value is int) return '$value';
      bad('expected an int.');
    case 'double':
      if (value is num) return '${value.toDouble()}';
      bad('expected a number.');
    case 'num':
      if (value is num) return '$value';
      bad('expected a number.');
    case 'bool':
      if (value is bool) return '$value';
      bad('expected a bool.');
    case 'String':
      if (value is String) return _dartStringLiteral(value);
      bad('expected a String.');
    case 'DateTime':
      if (value is int) return 'DateTime.fromMillisecondsSinceEpoch($value)';
      if (value is String && DateTime.tryParse(value) != null) {
        return 'DateTime.parse(${_dartStringLiteral(value)})';
      }
      bad('expected an ISO-8601 String or epoch milliseconds (int).');
    case 'Uri':
      if (value is String && Uri.tryParse(value) != null) {
        return 'Uri.parse(${_dartStringLiteral(value)})';
      }
      bad('expected a valid URI String.');
    case 'Duration':
      if (value is int) return 'Duration(microseconds: $value)';
      bad('expected a number of microseconds (int).');
    case 'BigInt':
      if (value is int) return 'BigInt.from($value)';
      if (value is String && BigInt.tryParse(value) != null) {
        return 'BigInt.parse(${_dartStringLiteral(value)})';
      }
      bad('expected an int or an integer String.');
    case 'Uint8List':
      if (value is String) {
        try {
          base64Decode(value);
          return 'base64Decode(${_dartStringLiteral(value)})';
        } on FormatException {
          // cai no erro abaixo
        }
      }
      bad('expected a Base64 String.');
  }
  if (isEnumType(t)) bad('use `enumFallback` for enums.');
  bad('fallbacks are supported for int, double, num, bool, String, DateTime, '
      'Uri, Duration, BigInt and Uint8List values.');
}

/// Fallback de campo (`@EasyKey(fallback:)`) já convertido, ou null.
String? _fieldFallbackExpr(FieldContext c) => c.fieldFallback == null
    ? null
    : _customValueExpr(c.fieldFallback!, c.type, c, 'fallback');

/// Tipo do item/valor de uma coleção (List, Set ou Map), ou null.
DartType? _collectionItemType(FieldContext c) =>
    c.listItemType ?? c.setItemType ?? c.mapValueType;

/// Checa, no build, todos os valores de `@EasyKey` de [c] — inclusive nos
/// tipos em que o fallback não chega a ser usado, para que um valor inválido
/// nunca passe em silêncio.
void checkEasyKeyValues(FieldContext c) {
  _fieldFallbackExpr(c);

  if (c.itemFallback != null) {
    final item = c.isSet ? null : _collectionItemType(c);
    if (item == null) {
      throw InvalidGenerationSourceError(
        '@EasyKey(itemFallback:) on `${c.enclosingClass.displayName}.${c.name}`: '
        'itemFallback is only supported on List and Map fields.',
        element: c.element,
      );
    }
    _customValueExpr(c.itemFallback!, item, c, 'itemFallback');
  }

  final name = c.enumFallbackName;
  if (name != null) {
    final enumType = isEnumType(c.type) ? c.type : _collectionItemType(c);
    final el = enumType?.element;
    if (el is! EnumElement) {
      throw InvalidGenerationSourceError(
        "@EasyKey(enumFallback: '$name') on `${c.enclosingClass.displayName}.${c.name}`: "
        'the field is not an enum (or a List/Set/Map of an enum).',
        element: c.element,
      );
    }
    final names = [
      for (final f in el.fields)
        if (f.isEnumConstant) f.displayName,
    ];
    if (!names.contains(name)) {
      throw InvalidGenerationSourceError(
        "@EasyKey(enumFallback: '$name') on `${c.enclosingClass.displayName}.${c.name}`: "
        '`${el.displayName}` has no value named `$name` (values: ${names.join(', ')}).',
        element: c.element,
      );
    }
  }
}

String _fallbackFor(
  DartType t, {
  required bool nullable,
  Object? custom,
  FieldContext? c,
  String param = 'fallback',
}) {
  if (custom != null) return _customValueExpr(custom, t, c!, param);
  // Sem fallback customizado, um tipo nullable volta para `null` — e não para
  // o "zero" do tipo (antes, um `int?` ausente virava 0 no fromJsonSafe).
  if (nullable) return 'null';
  final base = displayNonNull(t);
  if (base == 'DateTime') {
    return nullable ? 'null' : 'DateTime.fromMillisecondsSinceEpoch(0)';
  }
  switch (base) {
    case 'int':
    case 'num':
      return '0';
    case 'double':
      return '0.0';
    case 'bool':
      return 'false';
    case 'String':
      return "''";
  }
  final setT = asSetItem(t);
  if (setT != null) return 'const <${displayWithNull(setT)}>{}';
  final kv = asMapKV(t);
  if (kv.key != null && kv.value != null) {
    final kStr = displayNonNull(kv.key!);
    final vStr = displayWithNull(kv.value!);
    return 'const <$kStr, $vStr>{}';
  }
  if (t is InterfaceType && (t.element.name == 'List')) {
    final item = t.typeArguments.first;
    return 'const <${displayWithNull(item)}>[]';
  }
  return nullable ? 'null' : 'null';
}

String _coerceMapKeySafe(String rawKeyExpr, EasyMapKeyType type) {
  switch (type) {
    case EasyMapKeyType.int:
      return """
      ((){
        final _k = $rawKeyExpr;
        if (_k is int) return _k;
        if (_k is num) return _k.toInt();
        if (_k is String) { final n = num.tryParse(_k); if (n!=null) return n.toInt(); }
        return null;
      })()
      """;
    case EasyMapKeyType.string:
      return "($rawKeyExpr is String) ? $rawKeyExpr : ($rawKeyExpr?.toString())";
  }
}

