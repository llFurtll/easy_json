// ignore_for_file: experimental_member_use
part of '../strategies.dart';

class MapStrategy implements TypeStrategy {
  @override
  String fromJson(FieldContext c) {
    final kv = asMapKV(c.type);
    final K = kv.key!;
    final V = kv.value!;
    final kT = displayNonNull(K);
    final vT = displayWithNull(V);

    // 1) Conversor de CAMPO tem precedência
    if (c.convertFromJson != null) {
      return "${c.convertFromJson!}(Map<dynamic,dynamic>.from(${c.jsonAccessor} as Map))";
    }

    // 2) Coerção robusta da chave
    final wantsIntKey = (c.mapKeyCoercion == EasyMapKeyType.int) || kT == 'int';

    final String keyFast = wantsIntKey
        // aceita int direto, num (toInt), ou string numérica
        ? "(entry.key is int ? (entry.key as int) : (entry.key is num ? (entry.key as num).toInt() : int.parse(entry.key as String)))"
        // para String: se não for String, faz toString()
        : "(entry.key is String ? (entry.key as String) : entry.key.toString())";

    // 3) Parser de valor (rápido)
    final valParse = _fastValueParse(V, c);

    // 4) Template
    final code = kMapFastTpl
        .replaceAll('{VALUE}', c.jsonAccessor)
        .replaceAll('{K_T}', kT)
        .replaceAll('{V_T}', vT)
        .replaceAll('{KEY_PARSE_FAST}', keyFast)
        .replaceAll('{VAL_PARSE}', valParse);

    return code;
  }

  @override
  String fromJsonSafe(FieldContext c) {
    final kv = asMapKV(c.type);
    final K = kv.key!;
    final V = kv.value!;
    final kT = displayNonNull(K);
    final vT = displayWithNull(V);

    final typedEmpty = 'const <$kT, $vT>{}';
    final fb = c.isNullable ? 'null' : typedEmpty;

    // Conversor de CAMPO no modo safe
    if (c.convertFromJson != null) {
      return "((){ final _v=${c.jsonAccessor}; if(_v is! Map) return ${c.isNullable ? 'null' : typedEmpty}; final _m=Map<dynamic,dynamic>.from(_v as Map); try{ return ${c.convertFromJson!}(_m);} catch(_){ return ${c.isNullable ? 'null' : typedEmpty}; } })()";
    }

    final keySafe = _coerceMapKeySafe(
      'entry.key',
      c.mapKeyCoercion ?? EasyMapKeyType.string,
    );
    final valParse = _safeValueParse(V, c, keyPath: true);

    final onIssue =
        "onIssue?.call(EasyIssue(path: ${c.pathExpr} + '.' + entry.key.toString(), code: 'key_type_mismatch', message: 'Incompatible key type for map.'))";

    final code = kMapSafeTpl
        .replaceAll('{VALUE}', c.jsonAccessor)
        .replaceAll('{FALLBACK}', fb)
        .replaceAll('{K_T}', kT)
        .replaceAll('{V_T}', vT)
        .replaceAll('{KEY_PARSE}', keySafe)
        .replaceAll('{VAL_PARSE}', valParse)
        .replaceAll('{ON_ISSUE_KEY}', onIssue);
    return code;
  }

  @override
  void validate(FieldContext c, StringBuffer out) {
    final kv = asMapKV(c.type);
    final V = kv.value!;
    final mk = c.mapKeyCoercion;

    final sb = StringBuffer("""
        if (v != null && v is! Map) {
          issues.add(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Expected Map.'));
        } else if (v is Map) {
    """);
    _generateValidationChecks(c, sb);

    // Key check (quando EasyMapKeyType.int)
    if (mk == EasyMapKeyType.int) {
      sb.writeln("""
          for (final e in v.entries) {
            final k = e.key;
            final ok = (k is int) || (k is num) || (k is String && num.tryParse(k) != null);
            if (!ok) {
              issues.add(EasyIssue(path: ${c.pathExpr} + '.' + k.toString(), code: 'key_type_mismatch', message: 'Incompatible key type for map.'));
            }
          }
      """);
    }

    // Se há conversor de valor, não validamos tipo de valor (terceirizamos).
    if (c.valueFromJson == null) {
      if (isEasyJsonClass(V)) {
        final cn = displayNonNull(V);
        final vn = _lcFirst(cn);
        sb.writeln("""
          for (final e in v.entries) {
            final val = e.value;
            if (val != null && val is! Map) {
              issues.add(EasyIssue(path: ${c.pathExpr} + '.' + e.key.toString(), code: 'type_mismatch', message: 'Expected Map for $cn.'));
            } else if (val is Map) {
              final child = ${vn}Validate(Map<String,dynamic>.from(val as Map));
              for (final ci in child) {
                issues.add(EasyIssue(path: ${c.pathExpr} + '.' + e.key.toString() + '.' + ci.path, code: ci.code, message: ci.message));
              }
            }
          }
        """);
      } else if (isEnumType(V)) {
        final en = displayNonNull(V);
        sb.writeln("""
          for (final e in v.entries) {
            final val = e.value;
            if (val != null && val is! String) {
              issues.add(EasyIssue(path: ${c.pathExpr} + '.' + e.key.toString(), code: 'type_mismatch', message: 'Expected String with enum name.'));
            } else if (val != null) {
              final ok = $en.values.any((x) => x.name == val);
              if (!ok) {
                issues.add(EasyIssue(path: ${c.pathExpr} + '.' + e.key.toString(), code: 'invalid_enum', message: "Value '\$val' does not match $en."));
              }
            }
          }
        """);
      } else {
        final vBase = displayNonNull(V);
        sb.writeln("""
          for (final e in v.entries) {
            final val = e.value;
            if (val != null && val is! $vBase) {
              issues.add(EasyIssue(path: ${c.pathExpr} + '.' + e.key.toString(), code: 'type_mismatch', message: 'Expected $vBase.'));
            }
          }
        """);
      }
    }

    sb.writeln("""
        }
    """);
    _validateField(c, out, sb.toString());
  }

  @override
  String toJson(FieldContext c) {
    final kv = asMapKV(c.type);
    final V = kv.value!;

    // Conversor de CAMPO
    if (c.convertToJson != null) {
      return "${c.instanceAccess} == null ? null : ${c.convertToJson!}(${c.instanceAccess})";
    }

    if (isEasyJsonClass(V)) {
      final vConv = c.valueToJson != null
          ? "(k,v)=>MapEntry(k, ${c.valueToJson!}(v.toJson()))"
          : "(k,v)=>MapEntry(k, v.toJson())";
      return "${c.instanceAccess}${c.isNullable ? '?' : ''}.map($vConv)";
    }

    if (isEnumType(V)) {
      return "${c.instanceAccess}${c.isNullable ? '?' : ''}.map((k,v)=>MapEntry(k, v${displayWithNull(V).endsWith('?') ? '?' : ''}.name))";
    }

    if (c.valueToJson != null) {
      return "${c.instanceAccess}${c.isNullable ? '?' : ''}.map((k,v)=>MapEntry(k, ${c.valueToJson!}(v)))";
    }

    return c.instanceAccess;
  }
}

// ====== Parsers auxiliares (itens/valores) ======
String _fastItemParse(DartType item) {
  if (isEasyJsonClass(item)) {
    final cn = displayNonNull(item);
    final vn = _lcFirst(cn);
    return "${vn}FromJson(Map<String,dynamic>.from(e as Map))";
  }
  if (isEnumType(item)) {
    final en = displayNonNull(item);
    final nullable = displayWithNull(item).endsWith('?');
    return nullable
        ? "(e as String?) == null ? null : $en.values.byName(e as String)"
        : "$en.values.byName(e as String)";
  }
  final base = displayNonNull(item);
  final nullable = displayWithNull(item).endsWith('?');
  if (nullable) {
    return base == 'double' ? "(e as num?)?.toDouble()" : "(e as $base?)";
  }
  switch (base) {
    case 'int':
      return "(e as int?) ?? 0";
    case 'double':
      return "(e as num?)?.toDouble() ?? 0.0";
    case 'bool':
      return "(e as bool?) ?? false";
    case 'String':
      return "(e as String?) ?? ''";
    default:
      return "(e as $base)";
  }
}

String _safeItemParse(DartType item, FieldContext c, {bool indexPath = false}) {
  // path do item na coleção: "<path>[<idx>]"
  // entry.key é o índice no asMap().entries
  final pathPrefix = indexPath
      ? "${c.pathExpr} + '[' + entry.key.toString() + ']'"
      : c.pathExpr;

  // ===== Objetos @EasyJson =====
  if (isEasyJsonClass(item)) {
    final cn = displayNonNull(item);
    final vn = _lcFirst(cn);
    final isNullableItem = displayWithNull(item).endsWith('?');

    // Se for Map -> chama Safe normalmente.
    // Se NÃO for Map -> emite issue e:
    //   - item nullable: devolve null
    //   - item non-nullable: instancia com {} pra não quebrar
    return """
(() {
  final _v = entry.value;
  if (_v is Map) {
    return ${vn}FromJsonSafe(
      Map<String,dynamic>.from(_v as Map),
      onIssue:(i)=>onIssue?.call(EasyIssue(
        path: $pathPrefix + '.' + i.path,
        code: i.code,
        message: i.message
      )),
      runValidate:false
    );
  }
  onIssue?.call(EasyIssue(
    path: $pathPrefix,
    code: 'type_mismatch',
    message: 'Expected Map for $cn.'
  ));
  ${isNullableItem ? 'return null;' : '''return ${vn}FromJsonSafe(
            const <String,dynamic>{},
            onIssue:(i)=>onIssue?.call(EasyIssue(
              path: "$pathPrefix." + i.path,
              code: i.code,
              message: i.message
            )),
            runValidate:false
          );'''}
})()
""";
  }

  // ===== Enum =====
  if (isEnumType(item)) {
    final en = displayNonNull(item);
    final nullable = displayWithNull(item).endsWith('?');
    final fb = _enumFallbackExpr(en, c.enumFallbackName);

    // Aceita String (por name) e reporta invalid_enum se não achar.
    // Para tipo inválido, reporta type_mismatch.
    // Se nullable e valor null -> null (sem issue).
    // Se non-nullable e inválido -> fallback + issue.
    return """
      (() {
        final v = entry.value;
        if (v == null) return ${nullable ? 'null' : fb};
        if (v is String) {
          for (final e in $en.values) {
            if (e.name == v) return e;
          }
          onIssue?.call(EasyIssue(
            path: $pathPrefix,
            code: 'invalid_enum',
            message: "Value '\$v' does not match $en."
          ));
          return $fb;
        }
        onIssue?.call(EasyIssue(
          path: $pathPrefix,
          code: 'type_mismatch',
          message: 'Expected String with enum name.'
        ));
        return ${nullable ? 'null' : fb};
      })()
    """;
  }

  // ===== Primitivos / outros =====
  final base = displayNonNull(item);
  final itemFb = _fallbackFor(
    item,
    nullable: displayWithNull(item).endsWith('?'),
    custom: c.itemFallback,
  );

  // Em todos os casos abaixo, quando não bate o tipo:
  // - emite issue type_mismatch no pathPrefix
  // - retorna fallback coerente
  switch (base) {
    case 'int':
      return "((){ final v=entry.value; if (v is int) return v; onIssue?.call(EasyIssue(path: $pathPrefix, code: 'type_mismatch', message: 'Expected int.')); return $itemFb; })()";
    case 'double':
      return "((){ final v=entry.value; if (v is num) return v.toDouble(); onIssue?.call(EasyIssue(path: $pathPrefix, code: 'type_mismatch', message: 'Expected number (int/double).')); return $itemFb; })()";
    case 'bool':
      return "((){ final v=entry.value; if (v is bool) return v; onIssue?.call(EasyIssue(path: $pathPrefix, code: 'type_mismatch', message: 'Expected bool.')); return $itemFb; })()";
    case 'String':
      return "((){ final v=entry.value; if (v is String) return v; onIssue?.call(EasyIssue(path: $pathPrefix, code: 'type_mismatch', message: 'Expected String.')); return $itemFb; })()";
    default:
      return "((){ final v=entry.value; if (v is $base) return v; onIssue?.call(EasyIssue(path: $pathPrefix, code: 'type_mismatch', message: 'Expected $base.')); return $itemFb; })()";
  }
}

String _fastValueParse(DartType V, FieldContext c) {
  if (isEasyJsonClass(V)) {
    final cn = displayNonNull(V);
    final vn = _lcFirst(cn);
    return "${vn}FromJson(Map<String,dynamic>.from(entry.value as Map))";
  }
  if (isEnumType(V)) {
    final en = (V.element as EnumElement).name;
    final nullable = displayWithNull(V).endsWith('?');
    return nullable
        ? "(entry.value as String?) == null ? null : $en.values.byName(entry.value as String)"
        : "$en.values.byName(entry.value as String)";
  }
  if (c.valueFromJson != null) {
    return "${c.valueFromJson!}(entry.value)";
  }
  final base = displayNonNull(V);
  final nullable = displayWithNull(V).endsWith('?');
  if (nullable) {
    return base == 'double'
        ? "(entry.value as num?)?.toDouble()"
        : "(entry.value as $base?)";
  }
  switch (base) {
    case 'int':
      return "(entry.value as int?) ?? 0";
    case 'double':
      return "(entry.value as num?)?.toDouble() ?? 0.0";
    case 'bool':
      return "(entry.value as bool?) ?? false";
    case 'String':
      return "(entry.value as String?) ?? ''";
    default:
      return "(entry.value as $base)";
  }
}

String _safeValueParse(DartType V, FieldContext c, {bool keyPath = false}) {
  final pathPrefix = keyPath
      ? "${c.pathExpr} + '.' + k.toString()"
      : c.pathExpr;
  if (isEasyJsonClass(V)) {
    final cn = displayNonNull(V);
    final vn = _lcFirst(cn);
    final isNullableValue = displayWithNull(V).endsWith('?');

    // pathPrefix já vem como "'chave'" ou "'chave' + '.' + k.toString()" dependendo do caso
    final issuePath = "$pathPrefix + '.' + i.path";
    final childOnIssue =
        "onIssue:(i)=>onIssue?.call(EasyIssue(path: $issuePath, code: i.code, message: i.message))";

    final callOk =
        "$vn"
        "FromJsonSafe(Map<String,dynamic>.from(_v as Map), $childOnIssue, runValidate:false)";
    final callEmpty =
        "$vn"
        "FromJsonSafe(const <String,dynamic>{}, $childOnIssue, runValidate:false)";

    return """
      (() {
        final _v = entry.value;
        if (_v is Map) {
          return $callOk;
        }
        return ${isNullableValue ? 'null' : callEmpty};
      })()
    """;
  }
  if (isEnumType(V)) {
    final en = displayNonNull(V);
    final nullable = displayWithNull(V).endsWith('?');
    final fb = _enumFallbackExpr(en, c.enumFallbackName);
    return nullable
        ? "(entry.value == null) ? null : (entry.value is String ? $en.values.firstWhere((x)=>x.name==entry.value, orElse: ()=>$fb) : null)"
        : "(entry.value is String ? $en.values.firstWhere((x)=>x.name==entry.value, orElse: ()=>$fb) : $fb)";
  }
  if (c.valueFromJson != null) {
    final fb = _fallbackFor(
      V,
      nullable: displayWithNull(V).endsWith('?'),
      custom: c.itemFallback,
    );
    return "((){ try { return ${c.valueFromJson!}(entry.value); } catch(_){ return $fb; } })()";
  }
  final base = displayNonNull(V);
  final itemFb = _fallbackFor(
    V,
    nullable: displayWithNull(V).endsWith('?'),
    custom: c.itemFallback,
  );
  switch (base) {
    case 'int':
      return "((){ final v=entry.value; return (v is int)?v:$itemFb; })()";
    case 'double':
      return "((){ final v=entry.value; return (v is num)?v.toDouble():$itemFb; })()";
    case 'bool':
      return "((){ final v=entry.value; return (v is bool)?v:$itemFb; })()";
    case 'String':
      return "((){ final v=entry.value; return (v is String)?v:$itemFb; })()";
    default:
      return "((){ final v=entry.value; return (v is $base)?v:$itemFb; })()";
  }
}

String _generateDateTimeValidationChecks(FieldContext c, String varName) {
  final validator = c.validator;
  if (validator == null) return '';

  final out = StringBuffer();
  // past
  final isPast = validator.peek('past')?.boolValue;
  if (isPast == true) {
    out.writeln(
      "if ($varName.isAfter(DateTime.now())) { issues.add(EasyIssue(path: ${c.pathExpr}, code: 'must_be_past', message: 'The date must be in the past.')); }",
    );
  }

  // future
  final isFuture = validator.peek('future')?.boolValue;
  if (isFuture == true) {
    out.writeln(
      "if ($varName.isBefore(DateTime.now())) { issues.add(EasyIssue(path: ${c.pathExpr}, code: 'must_be_future', message: 'The date must be in the future.')); }",
    );
  }
  return out.toString();
}

String _lcFirst(String s) =>
    s.isEmpty ? s : (s[0].toLowerCase() + s.substring(1));

String _safeItemParseForSet(DartType item, FieldContext c) {
  final pathWithIdx = "${c.pathExpr} + '[' + entry.key.toString() + ']'";

  // EasyJson class
  if (isEasyJsonClass(item)) {
    final cn = displayNonNull(item);
    final vn = _lcFirst(cn);
    // Aceita apenas Map; se não for Map, emite issue e descarta (null)
    return """
      (() {
        final vv = entry.value;
        if (vv is Map) {
          return ${vn}FromJsonSafe(
            Map<String,dynamic>.from(vv as Map),
            onIssue: (i) => onIssue?.call(
              EasyIssue(path: $pathWithIdx + '.' + i.path, code: i.code, message: i.message)
            ),
            runValidate: false
          );
        }
        onIssue?.call(EasyIssue(
          path: $pathWithIdx,
          code: 'type_mismatch',
          message: 'Expected Map for $cn.'
        ));
        return null;
      })()
    """;
  }

  // Enum
  if (isEnumType(item)) {
    final en = displayNonNull(item);
    return """
      (() {
        final vv = entry.value;
        if (vv is String) {
          final match = $en.values.where((x) => x.name == vv);
          if (match.isNotEmpty) return match.first;
          onIssue?.call(EasyIssue(
            path: $pathWithIdx,
            code: 'invalid_enum',
            message: "Value '\$vv' does not match $en."
          ));
          return null;
        }
        if (vv is int) {
          if (vv >= 0 && vv < $en.values.length) return $en.values[vv];
          onIssue?.call(EasyIssue(
            path: $pathWithIdx,
            code: 'invalid_enum_index',
            message: 'Enum index out of range.'
          ));
          return null;
        }
        onIssue?.call(EasyIssue(
          path: $pathWithIdx,
          code: 'type_mismatch',
          message: 'Expected String with the enum name.'
        ));
        return null;
      })()
    """;
  }

  // Primitivos / outros
  final base = displayNonNull(item);
  String mismatchMsg(String expected) => "Expected $expected.";

  switch (base) {
    case 'int':
      return """
        (() {
          final vv = entry.value;
          if (vv is int) return vv;
          onIssue?.call(EasyIssue(path: $pathWithIdx, code: 'type_mismatch', message: '${mismatchMsg('int')}'));
          return null;
        })()
      """;
    case 'double':
      return """
        (() {
          final vv = entry.value;
          if (vv is num) return vv.toDouble();
          onIssue?.call(EasyIssue(path: $pathWithIdx, code: 'type_mismatch', message: '${mismatchMsg('number')}'));
          return null;
        })()
      """;
    case 'bool':
      return """
        (() {
          final vv = entry.value;
          if (vv is bool) return vv;
          onIssue?.call(EasyIssue(path: $pathWithIdx, code: 'type_mismatch', message: '${mismatchMsg('bool')}'));
          return null;
        })()
      """;
    case 'String':
      return """
        (() {
          final vv = entry.value;
          if (vv is String) return vv;
          onIssue?.call(EasyIssue(path: $pathWithIdx, code: 'type_mismatch', message: '${mismatchMsg('String')}'));
          return null;
        })()
      """;
    default:
      return """
        (() {
          final vv = entry.value;
          if (vv is $base) return vv;
          onIssue?.call(EasyIssue(path: $pathWithIdx, code: 'type_mismatch', message: '${mismatchMsg(base)}'));
          return null;
        })()
      """;
  }
}
