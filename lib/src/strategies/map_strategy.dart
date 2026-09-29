part of '../strategies.dart';

class MapStrategy implements TypeStrategy {
  /// Como coagir a chave: a anotação @EasyMapKey manda; sem ela, `Map<int, V>`
  /// ainda precisa de chaves int (o fromJson já fazia isso; safe/validate não).
  EasyMapKeyType _keyType(FieldContext c) =>
      c.mapKeyCoercion ??
      (displayNonNull(asMapKV(c.type).key!) == 'int'
          ? EasyMapKeyType.int
          : EasyMapKeyType.string);

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

    return c.isNullable ? '${c.jsonAccessor} == null ? null : $code' : code;
  }

  @override
  String fromJsonSafe(FieldContext c) {
    final kv = asMapKV(c.type);
    final K = kv.key!;
    final V = kv.value!;
    final kT = displayNonNull(K);
    final vT = displayWithNull(V);

    final typedEmpty = '${_constFor(V)}<$kT, $vT>{}';
    final fb = c.isNullable ? 'null' : typedEmpty;

    // Conversor de CAMPO no modo safe
    if (c.convertFromJson != null) {
      return "((){ final _v=${c.jsonAccessor}; if(_v is! Map) return ${c.isNullable ? 'null' : typedEmpty}; final _m=Map<dynamic,dynamic>.from(_v as Map); try{ return ${c.convertFromJson!}(_m);} catch(_){ return ${c.isNullable ? 'null' : typedEmpty}; } })()";
    }

    final keySafe = _coerceMapKeySafe('entry.key', _keyType(c));
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
    final mk = _keyType(c);

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
      if (_viaCodec(V)) {
        sb.writeln(
          "for (final e in v.entries) { ${_cValidate(V, 'e.value', "${c.pathExpr} + '.' + e.key.toString()")} }",
        );
      } else if (isEasyJsonClass(V)) {
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
      } else if (_richScalar(V) != null) {
        final path = "${c.pathExpr} + '.' + e.key.toString()";
        final nullCheck = displayWithNull(V).endsWith('?')
            ? ''
            : "if (val == null) { issues.add(EasyIssue(path: $path, code: 'null_not_allowed', message: 'Null value not allowed.')); } else ";
        sb.writeln("""
          for (final e in v.entries) {
            final val = e.value;
            $nullCheck if (val != null) { ${_validateRich(_richScalar(V)!, 'val', path)} }
          }
        """);
      } else {
        final vBase = displayNonNull(V);
        sb.writeln("""
          for (final e in v.entries) {
            final val = e.value;
            if (val == null) {
              ${displayWithNull(V).endsWith('?') ? '' : "issues.add(EasyIssue(path: ${c.pathExpr} + '.' + e.key.toString(), code: 'null_not_allowed', message: 'Null value not allowed.'));"}
            } else if (val is! ${vBase == 'double' ? 'num' : vBase}) {
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

    // Objetos JSON só têm chaves String: chaves int (Map<int, V>, com ou
    // sem @EasyMapKey) precisam virar String, senão o jsonEncode lança.
    final stringKeys = displayNonNull(kv.key!) == 'String';
    final k = stringKeys ? 'k' : 'k.toString()';
    final q = c.isNullable ? '?' : '';

    if (c.valueToJson == null && _viaCodec(V)) {
      final enc = _cEncode(V, 'v');
      return stringKeys && enc == 'v'
          ? c.instanceAccess
          : "${c.instanceAccess}$q.map((k,v)=>MapEntry($k, $enc))";
    }

    if (isEasyJsonClass(V)) {
      final vConv = c.valueToJson != null
          ? "(k,v)=>MapEntry($k, ${c.valueToJson!}(v.toJson()))"
          : "(k,v)=>MapEntry($k, v.toJson())";
      return "${c.instanceAccess}$q.map($vConv)";
    }

    if (isEnumType(V)) {
      return "${c.instanceAccess}$q.map((k,v)=>MapEntry($k, v${displayWithNull(V).endsWith('?') ? '?' : ''}.name))";
    }

    if (c.valueToJson != null) {
      return "${c.instanceAccess}$q.map((k,v)=>MapEntry($k, ${c.valueToJson!}(v)))";
    }

    final rs = _richScalar(V);
    if (rs != null) {
      final enc = displayWithNull(V).endsWith('?')
          ? "v == null ? null : ${rs.encode('v')}"
          : rs.encode('v');
      return "${c.instanceAccess}$q.map((k,v)=>MapEntry($k, $enc))";
    }

    if (!stringKeys) {
      return "${c.instanceAccess}$q.map((k,v)=>MapEntry($k, v))";
    }

    return c.instanceAccess;
  }
}

// ====== Parsers auxiliares (itens/valores) ======
String _fastItemParse(DartType item) {
  if (_viaCodec(item)) return _cFast(item, 'e');
  final rs = _richScalar(item);
  if (rs != null) return _fastRich(rs, item, 'e');
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

  // ===== T, coleções aninhadas, classes genéricas =====
  if (_viaCodec(item)) return _cSafe(item, 'entry.value', pathPrefix);

  final rs = _richScalar(item);
  if (rs != null) {
    return _safeRich(rs, item, 'entry.value', pathPrefix,
        customFallback: c.itemFallback == null ? null : _customValueExpr(c.itemFallback!, item, c, 'itemFallback'));
  }

  // ===== Objetos @EasyJson =====
  if (isEasyJsonClass(item)) {
    final cn = displayNonNull(item);
    final vn = _lcFirst(cn);
    final isNullableItem = displayWithNull(item).endsWith('?');

    // Se for Map -> chama Safe normalmente.
    // Se NÃO for Map -> emite issue e:
    //   - item nullable: devolve null
    //   - item non-nullable: instancia com {} pra não quebrar
    final emptyObj = '''${vn}FromJsonSafe(
            const <String,dynamic>{},
            onIssue:(i)=>onIssue?.call(EasyIssue(
              path: $pathPrefix + '.' + i.path,
              code: i.code,
              message: i.message
            )),
            runValidate:false
          )''';
    final onNull = isNullableItem
        ? 'return null;'
        : "onIssue?.call(EasyIssue(path: $pathPrefix, code: 'null_not_allowed', message: 'Null value not allowed.')); return $emptyObj;";
    return """
(() {
  final _v = entry.value;
  if (_v == null) { $onNull }
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
    c: c,
    param: 'itemFallback',
  );

  // Em todos os casos abaixo:
  // - item null: nullable -> null; senão null_not_allowed (igual ao validate)
  // - tipo errado: issue type_mismatch no pathPrefix + fallback coerente
  final onNull = displayWithNull(item).endsWith('?')
      ? 'return null;'
      : "onIssue?.call(EasyIssue(path: $pathPrefix, code: 'null_not_allowed', message: 'Null value not allowed.')); return $itemFb;";
  String prim(String accept, String message) =>
      "((){ final v=entry.value; if (v == null) { $onNull } $accept onIssue?.call(EasyIssue(path: $pathPrefix, code: 'type_mismatch', message: '$message')); return $itemFb; })()";
  switch (base) {
    case 'int':
      return prim('if (v is int) return v;', 'Expected int.');
    case 'double':
      return prim('if (v is num) return v.toDouble();', 'Expected number (int/double).');
    case 'bool':
      return prim('if (v is bool) return v;', 'Expected bool.');
    case 'String':
      return prim('if (v is String) return v;', 'Expected String.');
    default:
      return prim('if (v is $base) return v;', 'Expected $base.');
  }
}

String _fastValueParse(DartType V, FieldContext c) {
  if (c.valueFromJson == null && _viaCodec(V)) return _cFast(V, 'entry.value');
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
  final rs = _richScalar(V);
  if (rs != null) return _fastRich(rs, V, 'entry.value');
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
  if (c.valueFromJson == null && _viaCodec(V)) {
    return _cSafe(V, 'entry.value', pathPrefix);
  }
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
    c: c,
    param: 'itemFallback',
    );
    return "((){ try { return ${c.valueFromJson!}(entry.value); } catch(_){ return $fb; } })()";
  }
  final rs = _richScalar(V);
  if (rs != null) {
    return _safeRich(rs, V, 'entry.value', pathPrefix,
        customFallback: c.itemFallback == null ? null : _customValueExpr(c.itemFallback!, V, c, 'itemFallback'));
  }
  final base = displayNonNull(V);
  final itemFb = _fallbackFor(
    V,
    nullable: displayWithNull(V).endsWith('?'),
    custom: c.itemFallback,
    c: c,
    param: 'itemFallback',
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
  if (_viaCodec(item)) {
    return _cSafe(item, 'entry.value', "${c.pathExpr} + '[' + entry.key.toString() + ']'");
  }
  // Item null num Set de tipo não-nullable: null_not_allowed (o mesmo código
  // que o validate usa), em vez do type_mismatch que cada ramo daria.
  final body = _safeItemParseForSetBody(item, c);
  if (displayWithNull(item).endsWith('?')) return body;
  final pathWithIdx = "${c.pathExpr} + '[' + entry.key.toString() + ']'";
  return body.replaceFirst(
    'final vv = entry.value;',
    "final vv = entry.value; if (vv == null) { onIssue?.call(EasyIssue(path: $pathWithIdx, code: 'null_not_allowed', message: 'Null value not allowed.')); return null; }",
  );
}

String _safeItemParseForSetBody(DartType item, FieldContext c) {
  final pathWithIdx = "${c.pathExpr} + '[' + entry.key.toString() + ']'";

  // Tipos ricos: inválido -> issue e descarta (null é filtrado do Set).
  final rs = _richScalar(item);
  if (rs != null) {
    return """
      (() {
        final vv = entry.value;
        if (vv == null) return null;
        final r = ${rs.decoder}(vv);
        if (r != null) return r;
        onIssue?.call(${rs.issue('vv', pathWithIdx)});
        return null;
      })()
    """;
  }

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
