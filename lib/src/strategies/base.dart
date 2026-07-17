// ignore_for_file: experimental_member_use
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
    // Escapa a string para ser usada dentro de uma string literal em Dart
    final escapedRegex = regex.replaceAll("'", r"\'");
    out.writeln(
      "if (!RegExp(r'$escapedRegex').hasMatch(v as String)) { issues.add(EasyIssue(path: ${c.pathExpr}, code: 'regex_mismatch', message: 'Invalid format.')); }",
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
      final escapedRegex = regex.replaceAll("'", r"\'");
      out.writeln(
        "if (!RegExp(r'$escapedRegex').hasMatch(v as String)) { issues.add(EasyIssue(path: ${c.pathExpr}, code: '$code', message: '$message')); }",
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

String _enumFallbackExpr(String enumName, String? fallbackName) =>
    (fallbackName == null || fallbackName.isEmpty)
    ? "$enumName.values.first"
    : "$enumName.values.firstWhere((e)=>e.name=='$fallbackName', orElse: ()=>$enumName.values.first)";

String _fallbackFor(DartType t, {required bool nullable, Object? custom}) {
  if (custom != null) {
    if (custom is String) return "'${custom.replaceAll("'", r"\'")}'";
    return custom.toString();
  }
  final base = displayNonNull(t);
  if (base == 'DateTime') {
    return nullable ? 'null' : 'DateTime.fromMillisecondsSinceEpoch(0)';
  }
  switch (base) {
    case 'int':
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

