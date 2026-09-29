part of '../strategies.dart';

class ListStrategy implements TypeStrategy {
  /// Lista vazia de fallback. `const <T>[]` é inválido quando o item usa um
  /// parâmetro de tipo, então nesse caso a lista não pode ser const.
  String _emptyList(DartType item) =>
      '${_constFor(item)}<${displayWithNull(item)}>[]';

  @override
  String fromJson(FieldContext c) {
    final item = c.listItemType!;
    final itemT = displayWithNull(item);
    final itemParse = _fastItemParse(item);

    final expr = kListFastTpl
      .replaceAll('{VALUE}', c.jsonAccessor)
      .replaceAll('{ITEM_T}', itemT)
      .replaceAll('{ITEM_PARSE}', itemParse);

    // quando o campo é não-nulo, garanta retorno não-nulo
    return c.isNullable ? expr : '($expr) ?? ${_emptyList(item)}';
  }

  @override
  String fromJsonSafe(FieldContext c) {
    final item = c.listItemType!;
    final itemT = displayWithNull(item);
    final itemParse = _safeItemParse(item, c, indexPath: true);
    final fb = c.isNullable ? 'null' : _emptyList(item);
    return kListSafeTpl
      .replaceAll('{VALUE}', c.jsonAccessor)
      .replaceAll('{FALLBACK}', fb)
      .replaceAll('{ITEM_T}', itemT)
      .replaceAll('{ITEM_PARSE}', itemParse);
  }

  @override
  void validate(FieldContext c, StringBuffer out) {
    final item = c.listItemType!;
    final itemBase = displayNonNull(item);
    final itemIsNullable = displayWithNull(item).endsWith('?');

    final sb = StringBuffer("""
      if (v != null && v is! List) {
        issues.add(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Expected List.'));
      } else if (v is List) {
""");
    _generateValidationChecks(c, sb);
    sb.writeln("""
        for (var i = 0; i < v.length; i++) {
          final e = v[i];
          if (e == null) {
            ${itemIsNullable ? '' : "issues.add(EasyIssue(path: ${c.pathExpr} + '[' + i.toString() + ']', code: 'null_not_allowed', message: 'Null value not allowed.'));"} 
          } else {
  """);

    final rs = _richScalar(item);
    if (_viaCodec(item)) {
      sb.writeln(_cValidateNonNull(item, 'e', "${c.pathExpr} + '[' + i.toString() + ']'"));
    } else if (rs != null) {
      sb.writeln(_validateRich(rs, 'e', "${c.pathExpr} + '[' + i.toString() + ']'"));
    } else if (isEasyJsonClass(item)) {
      final cn = displayNonNull(item);
      final vn = _lcFirst(cn);
      sb.writeln("""
            if (e is! Map) {
              issues.add(EasyIssue(path: ${c.pathExpr} + '[' + i.toString() + ']', code: 'type_mismatch', message: 'Expected Map for $cn.'));
            } else {
              final child = ${vn}Validate(Map<String,dynamic>.from(e as Map));
              for (final ci in child) {
                issues.add(EasyIssue(path: ${c.pathExpr} + '[' + i.toString() + '].' + ci.path, code: ci.code, message: ci.message));
              }
            }
    """);
    } else if (isEnumType(item)) {
      final en = displayNonNull(item);
      sb.writeln("""
            if (e is! String) {
              issues.add(EasyIssue(path: ${c.pathExpr} + '[' + i.toString() + ']', code: 'type_mismatch', message: 'Expected String with enum name.'));
            } else {
              final ok = $en.values.any((x) => x.name == e);
              if (!ok) {
                issues.add(EasyIssue(path: ${c.pathExpr} + '[' + i.toString() + ']', code: 'invalid_enum', message: "Value '\$e' does not match $en."));
              }
            }
    """);
    } else {
      sb.writeln("""
            if (e is! ${itemBase == 'double' ? 'num' : itemBase}) {
              issues.add(EasyIssue(path: ${c.pathExpr} + '[' + i.toString() + ']', code: 'type_mismatch', message: 'Expected $itemBase.'));
            }
    """);
    }

    sb.writeln("""
          }
        }
      }
  """);
    _validateField(c, out, sb.toString());
  }

  @override
  String toJson(FieldContext c) {
    final item = c.listItemType!;
    if (_viaCodec(item)) {
      final enc = _cEncode(item, 'e');
      return enc == 'e'
          ? c.instanceAccess
          : "${c.instanceAccess}${c.isNullable ? '?' : ''}.map((e)=>$enc).toList()";
    }
    final rich = _richEncodeItem(item);
    if (rich != null) {
      return "${c.instanceAccess}${c.isNullable ? '?' : ''}.map((e)=>$rich).toList()";
    }
    if (isEasyJsonClass(item)) {
      return "${c.instanceAccess}${c.isNullable ? '?' : ''}.map((e)=>e.toJson()).toList()";
    }
    if (isEnumType(item)) {
      return "${c.instanceAccess}${c.isNullable ? '?' : ''}.map((e)=>e.name).toList()";
    }
    return c.instanceAccess;
  }
}

