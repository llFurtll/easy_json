import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';

import 'annotations.dart';
import 'field_context.dart';
import 'templates.dart';

abstract class TypeStrategy {
  String fromJson(FieldContext c);
  String fromJsonSafe(FieldContext c);
  void validate(FieldContext c, StringBuffer out);
  String toJson(FieldContext c);
}

// ===== Helpers comuns =====
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

// ===== Primitive =====
class PrimitiveStrategy implements TypeStrategy {
  @override
  String fromJson(FieldContext c) {
    // 1) conversor de campo tem precedência
    if (c.convertFromJson != null) {
      return "${c.convertFromJson!}(${c.jsonAccessor})";
    }

    // 2) fallback padrão
    final t = displayNonNull(c.type);
    final isN = c.isNullable;

    if (isExactlyDateTime(c.type)) {
      // aceita String ISO, int/num (epoch), já com fallback para não-nulo
      return isN
          ? "ej.parseDateTimeOrNull(${c.jsonAccessor})"
          : "ej.parseDateTime(${c.jsonAccessor})";
    }

    if (t == 'double') {
      var expr = "(${c.jsonAccessor} as num?)?.toDouble()";
      if (!isN) expr += " ?? 0.0";
      return expr;
    }

    if (!isN) {
      String expr = "(${c.jsonAccessor} as $t?)";
      switch (t) {
        case 'int':
          expr += " ?? 0";
          break;
        case 'String':
          expr += " ?? ''";
          break;
        case 'bool':
          expr += " ?? false";
          break;
        default:
          return "${c.jsonAccessor} as ${displayWithNull(c.type)}";
      }
      return expr;
    } else {
      return "${c.jsonAccessor} as ${displayWithNull(c.type)}";
    }
  }

  @override
  String fromJsonSafe(FieldContext c) {
    final t = displayNonNull(c.type);
    final fb = _fallbackFor(
      c.type,
      nullable: c.isNullable,
      custom: c.fieldFallback,
    );
    if (isExactlyDateTime(c.type)) {
      final nfb = c.isNullable
          ? 'null'
          : 'DateTime.fromMillisecondsSinceEpoch(0)';
      // aceita String ISO, int/num epoch (ms), DateTime direto; em qualquer falha, emite issue
      return """
        (() {
          final v = ${c.jsonAccessor};
          if (v == null) return $nfb;
          if (v is DateTime) return v;
          if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
          if (v is num) return DateTime.fromMillisecondsSinceEpoch(v.toInt());
          if (v is String) {
            try { return DateTime.parse(v); } catch (_) {
              onIssue?.call(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Formato inválido de DateTime.'));
              return $nfb;
            }
          }
          onIssue?.call(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Esperado String/epoch/DateTime.'));
          return $nfb;
        })()
      """;
    }
    switch (t) {
      case 'int':
        return "((){ final v=${c.jsonAccessor}; return (v is int)?v:$fb; })()";
      case 'double':
        return "((){ final v=${c.jsonAccessor}; return (v is num)?v.toDouble():$fb; })()";
      case 'bool':
        return "((){ final v=${c.jsonAccessor}; return (v is bool)?v:$fb; })()";
      case 'String':
        return c.isNullable
            ? "((){ final v=${c.jsonAccessor}; return (v is String) ? v : null; })()"
            : "((){ final v=${c.jsonAccessor}; return (v is String) ? v : ''; })()";
      default:
        return "${c.jsonAccessor} as ${displayWithNull(c.type)}";
    }
  }

  @override
  void validate(FieldContext c, StringBuffer out) {
    final t = displayNonNull(c.type);
    final hasCtorDefault =
        c.enclosingClass.unnamedConstructor?.parameters
            .firstWhereOrNull((p) => p.name == c.name)
            ?.defaultValueCode !=
        null;

    if (!c.isNullable && !hasCtorDefault) {
      out.writeln(
        "if (!json.containsKey('${c.jsonKey}')) "
        "{ issues.add(EasyIssue(path: '${c.jsonKey}', code: 'missing_required', message: 'Campo obrigatório ausente.')); }",
      );
    }

    // Se há conversor custom, não impomos formato da entrada
    if (c.convertFromJson != null) return;

    String check;
    if (isExactlyDateTime(c.type)) {
      check =
          "if (v != null && v is! String) { "
          "  issues.add(EasyIssue(path: '${c.jsonKey}', code: 'type_mismatch', message: 'Esperado String (ISO-8601) para DateTime.')); "
          "} else if (v != null) { "
          "  try { DateTime.parse(v as String); } catch(_) { "
          "    issues.add(EasyIssue(path: '${c.jsonKey}', code: 'type_mismatch', message: 'Formato inválido de DateTime.')); "
          "  } "
          "}";
    } else if (t == 'double') {
      check =
          "if (v != null && v is! num) { "
          "  issues.add(EasyIssue(path: '${c.jsonKey}', code: 'type_mismatch', message: 'Esperado número (int/double).')); "
          "}";
    } else {
      check =
          "if (v != null && v is! $t) { "
          "  issues.add(EasyIssue(path: '${c.jsonKey}', code: 'type_mismatch', message: 'Esperado $t.')); "
          "}";
    }
    out.writeln(
      "if (json.containsKey('${c.jsonKey}')) { final v=${c.jsonAccessor}; $check }",
    );
  }

  @override
  String toJson(FieldContext c) {
    // 1) conversor de campo tem precedência
    if (c.convertToJson != null) {
      final call = "${c.convertToJson!}(${c.instanceAccess})";
      return c.isNullable
          ? "(${c.instanceAccess} == null ? null : $call)"
          : call;
    }

    // 2) DateTime -> ISO-8601 string
    if (isExactlyDateTime(c.type)) {
      return c.isNullable
          ? "${c.instanceAccess}?.toIso8601String()"
          : "${c.instanceAccess}.toIso8601String()";
    }

    // 3) demais tipos: já está ok
    return c.instanceAccess;
  }
}

// ===== Enum =====
class EnumStrategy implements TypeStrategy {
  @override
  String fromJson(FieldContext c) {
    final en = (c.type.element as EnumElement).name;
    // Fast: assume String válida (byName)
    return c.isNullable
        ? "(${c.jsonAccessor} == null ? null : $en.values.byName(${c.jsonAccessor} as String))"
        : "$en.values.byName(${c.jsonAccessor} as String)";
  }

  @override
  String fromJsonSafe(FieldContext c) {
    final en = (c.type.element as EnumElement).name;
    final isN = c.isNullable;
    final fb = _enumFallbackExpr(en, c.enumFallbackName); // ex: TmRole.guest

    return """
      (() {
        final v = ${c.jsonAccessor};
        if (v == null) return ${isN ? 'null' : fb};

        // String pelo .name (tolerante a espaços/case)
        if (v is String) {
          final s = v.trim();
          for (final e in $en.values) {
            if (e.name == s || e.name.toLowerCase() == s.toLowerCase()) return e;
          }
          onIssue?.call(EasyIssue(
            path: ${c.pathExpr},
            code: 'invalid_enum',
            message: "Valor '\$v' não corresponde a $en."
          ));
          return $fb;
        }

        // Índice numérico
        if (v is int) {
          if (v >= 0 && v < $en.values.length) return $en.values[v];
          onIssue?.call(EasyIssue(
            path: ${c.pathExpr},
            code: 'invalid_enum_index',
            message: 'Índice de enum fora do intervalo.'
          ));
          return $fb;
        }

        onIssue?.call(EasyIssue(
          path: ${c.pathExpr},
          code: 'type_mismatch',
          message: 'Esperado String com nome do enum ou índice int.'
        ));
        return ${isN ? 'null' : fb};
      })()
    """;
  }

  @override
  void validate(FieldContext c, StringBuffer out) {
    final en = (c.type.element as EnumElement).name;
    final hasCtorDefault =
        c.enclosingClass.unnamedConstructor?.parameters
            .firstWhereOrNull((p) => p.name == c.name)
            ?.defaultValueCode !=
        null;

    if (!c.isNullable && !hasCtorDefault) {
      out.writeln(
        "if (!json.containsKey('${c.jsonKey}')) "
        "{ issues.add(EasyIssue(path: '${c.jsonKey}', code: 'missing_required', message: 'Campo obrigatório ausente.')); }",
      );
    }

    out.writeln("""
      if (json.containsKey('${c.jsonKey}')) {
        final v = ${c.jsonAccessor};
        if (v != null && v is! String) {
          issues.add(EasyIssue(path: '${c.jsonKey}', code: 'type_mismatch', message: 'Esperado String com o nome do enum.'));
        } else if (v != null) {
          final ok = $en.values.any((e) => e.name == v);
          if (!ok) {
            issues.add(EasyIssue(path: '${c.jsonKey}', code: 'invalid_enum', message: "Valor '\$v' não corresponde a $en."));
          }
        }
      }
    """);
  }

  @override
  String toJson(FieldContext c) {
    final acc = c.instanceAccess;
    return c.isNullable ? "($acc?.name)" : "$acc.name";
  }
}

// ===== Objeto @EasyJson =====
class ObjectStrategy implements TypeStrategy {
  @override
  String fromJson(FieldContext c) {
    final cn = (c.type.element as ClassElement).name;
    final vn = _lcFirst(cn);
    final cast = "${c.jsonAccessor} as Map<String, dynamic>";
    return c.isNullable
        ? "${c.jsonAccessor} == null ? null : ${vn}FromJson($cast)"
        : "${vn}FromJson($cast)";
  }

  @override
  String fromJsonSafe(FieldContext c) {
    final cn = (c.type.element as ClassElement).name; // ex.: Address
    final vn = _lcFirst(cn);
    final cb =
        "onIssue: (i)=>onIssue?.call(EasyIssue(path: ${c.pathExpr} + '.' + i.path, code: i.code, message: i.message)), runValidate:false";

    // chama filho com mapa vazio quando não-nullable
    final callEmpty =
        "$vn"
        "FromJsonSafe(const <String, dynamic>{}, $cb)";

    // se o campo é nullable e o valor não é Map -> null
    final fallbackNotMap = c.isNullable ? 'null' : callEmpty;

    return """
      (() {
        final _v = ${c.jsonAccessor};
        if (_v == null) return ${c.isNullable ? 'null' : callEmpty};
        if (_v is Map) {
          return ${vn}FromJsonSafe(
            Map<String, dynamic>.from(_v as Map),
            $cb
          );
        }
        return $fallbackNotMap;
      })()
    """;
  }

  @override
  void validate(FieldContext c, StringBuffer out) {
    final cn = (c.type.element as ClassElement).name;
    final vn = _lcFirst(cn);

    final hasCtorDefault =
        c.enclosingClass.unnamedConstructor?.parameters
            .firstWhereOrNull((p) => p.name == c.name)
            ?.defaultValueCode !=
        null;
    if (!c.isNullable && !hasCtorDefault) {
      out.writeln(
        "if (!json.containsKey('${c.jsonKey}')) "
        "{ issues.add(EasyIssue(path: '${c.jsonKey}', code: 'missing_required', message: 'Campo obrigatório ausente.')); }",
      );
    }

    out.writeln("""
      if (json.containsKey('${c.jsonKey}')) {
        final v = ${c.jsonAccessor};
        if (v != null && v is! Map) {
          issues.add(EasyIssue(path: '${c.jsonKey}', code: 'type_mismatch', message: 'Esperado Map para $cn.'));
        } else if (v is Map) {
          final child = ${vn}Validate(Map<String,dynamic>.from(v));
          for (final ci in child) {
            issues.add(EasyIssue(path: '${c.jsonKey}.' + ci.path, code: ci.code, message: ci.message));
          }
        }
      }
    """);
  }

  @override
  String toJson(FieldContext c) => c.isNullable
      ? "${c.instanceAccess}?.toJson()"
      : "${c.instanceAccess}.toJson()";
}

// ===== Lista =====
class ListStrategy implements TypeStrategy {
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
    return c.isNullable ? expr : '($expr) ?? const <$itemT>[]';
  }

  @override
  String fromJsonSafe(FieldContext c) {
    final item = c.listItemType!;
    final itemT = displayWithNull(item);
    final itemParse = _safeItemParse(item, c, indexPath: true);
    final fb = c.isNullable ? 'null' : 'const <$itemT>[]';
    return kListSafeTpl
        .replaceAll('{VALUE}', c.jsonAccessor)
        .replaceAll('{FALLBACK}', fb)
        .replaceAll('{ITEM_T}', itemT)
        .replaceAll('{ITEM_PARSE}', itemParse);
  }

  @override
  void validate(FieldContext c, StringBuffer out) {
    final hasCtorDefault =
        c.enclosingClass.unnamedConstructor?.parameters
            .firstWhereOrNull((p) => p.name == c.name)
            ?.defaultValueCode !=
        null;
    if (!c.isNullable && !hasCtorDefault) {
      out.writeln(
        "if (!json.containsKey('${c.jsonKey}')) "
        "{ issues.add(EasyIssue(path: '${c.jsonKey}', code: 'missing_required', message: 'Campo obrigatório ausente.')); }",
      );
    }

    final item = c.listItemType!;
    final itemBase = displayNonNull(item);
    final itemIsNullable = displayWithNull(item).endsWith('?');

    out.writeln("""
    if (json.containsKey('${c.jsonKey}')) {
      final v = ${c.jsonAccessor};
      if (v != null && v is! List) {
        issues.add(EasyIssue(path: '${c.jsonKey}', code: 'type_mismatch', message: 'Esperado List.'));
      } else if (v is List) {
        for (var i = 0; i < v.length; i++) {
          final e = v[i];
          if (e == null) {
            ${itemIsNullable ? '' : "issues.add(EasyIssue(path: '${c.jsonKey}[' + i.toString() + ']', code: 'null_not_allowed', message: 'Valor nulo não permitido.'));"} 
          } else {
  """);

    if (isEasyJsonClass(item)) {
      final cn = (item.element as ClassElement).name;
      final vn = _lcFirst(cn);
      out.writeln("""
            if (e is! Map) {
              issues.add(EasyIssue(path: '${c.jsonKey}[' + i.toString() + ']', code: 'type_mismatch', message: 'Esperado Map para $cn.'));
            } else {
              final child = ${vn}Validate(Map<String,dynamic>.from(e as Map));
              for (final ci in child) {
                issues.add(EasyIssue(path: '${c.jsonKey}[' + i.toString() + '].' + ci.path, code: ci.code, message: ci.message));
              }
            }
    """);
    } else if (isEnumType(item)) {
      final en = (item.element as EnumElement).name;
      out.writeln("""
            if (e is! String) {
              issues.add(EasyIssue(path: '${c.jsonKey}[' + i.toString() + ']', code: 'type_mismatch', message: 'Esperado String com nome do enum.'));
            } else {
              final ok = $en.values.any((x) => x.name == e);
              if (!ok) {
                issues.add(EasyIssue(path: '${c.jsonKey}[' + i.toString() + ']', code: 'invalid_enum', message: "Valor '\$e' não corresponde a $en."));
              }
            }
    """);
    } else {
      out.writeln("""
            if (e is! $itemBase) {
              issues.add(EasyIssue(path: '${c.jsonKey}[' + i.toString() + ']', code: 'type_mismatch', message: 'Esperado $itemBase.'));
            }
    """);
    }

    out.writeln("""
          }
        }
      }
    }
  """);
  }

  @override
  String toJson(FieldContext c) {
    final item = c.listItemType!;
    if (isEasyJsonClass(item)) {
      return "${c.instanceAccess}${c.isNullable ? '?' : ''}.map((e)=>e.toJson()).toList()";
    }
    if (isEnumType(item)) {
      return "${c.instanceAccess}${c.isNullable ? '?' : ''}.map((e)=>e.name).toList()";
    }
    return c.instanceAccess;
  }
}

// ===== Set =====
class SetStrategy implements TypeStrategy {
  @override
  String fromJson(FieldContext c) {
    final item = c.setItemType!;
    final itemT = displayWithNull(item);
    final itemParse = _fastItemParse(item);

    final expr = kSetFastTpl
        .replaceAll('{VALUE}', c.jsonAccessor)
        .replaceAll('{ITEM_T}', itemT)
        .replaceAll('{ITEM_PARSE}', itemParse);

    // quando o campo é não-nulo, garanta retorno não-nulo
    return c.isNullable ? expr : '($expr) ?? const <$itemT>{}';
  }

  @override
  String fromJsonSafe(FieldContext c) {
    final item = c.setItemType!;
    final itemT = displayWithNull(item); // ex.: String ou String?
    final itemNN = displayNonNull(item); // ex.: String (sempre non-null)
    final fb = c.isNullable ? 'null' : 'const <$itemT>{}';

    // Parser específico para Set: retorna NULL quando inválido (e registra issue)
    final parse = _safeItemParseForSet(item, c);

    return """
      (() {
        final _v = ${c.jsonAccessor};
        if (_v is! List) return $fb;
        final _list = _v;
        return _list
          .asMap()
          .entries
          .map<$itemNN?>((entry) {
            return $parse;
          })
          .where((x) => x != null)
          .cast<$itemT>()
          .toSet();
      })()
    """;
  }

  @override
  void validate(FieldContext c, StringBuffer out) {
    final hasCtorDefault =
        c.enclosingClass.unnamedConstructor?.parameters
            .firstWhereOrNull((p) => p.name == c.name)
            ?.defaultValueCode !=
        null;
    if (!c.isNullable && !hasCtorDefault) {
      out.writeln(
        "if (!json.containsKey('${c.jsonKey}')) "
        "{ issues.add(EasyIssue(path: '${c.jsonKey}', code: 'missing_required', message: 'Campo obrigatório ausente.')); }",
      );
    }

    final item = c.setItemType!;
    final itemBase = displayNonNull(item);
    final itemIsNullable = displayWithNull(item).endsWith('?');

    out.writeln("""
    if (json.containsKey('${c.jsonKey}')) {
      final v = ${c.jsonAccessor};
      if (v != null && v is! List) {
        issues.add(EasyIssue(path: '${c.jsonKey}', code: 'type_mismatch', message: 'Esperado List para Set.'));
      } else if (v is List) {
        for (var i = 0; i < v.length; i++) {
          final e = v[i];
          if (e == null) {
            ${itemIsNullable ? '' : "issues.add(EasyIssue(path: '${c.jsonKey}[' + i.toString() + ']', code: 'null_not_allowed', message: 'Valor nulo não permitido.'));"} 
          } else {
  """);

    if (isEasyJsonClass(item)) {
      final cn = (item.element as ClassElement).name;
      final vn = _lcFirst(cn);
      out.writeln("""
            if (e is! Map) {
              issues.add(EasyIssue(path: '${c.jsonKey}[' + i.toString() + ']', code: 'type_mismatch', message: 'Esperado Map para $cn.'));
            } else {
              final child = ${vn}Validate(Map<String,dynamic>.from(e as Map));
              for (final ci in child) {
                issues.add(EasyIssue(path: '${c.jsonKey}[' + i.toString() + '].' + ci.path, code: ci.code, message: ci.message));
              }
            }
    """);
    } else if (isEnumType(item)) {
      final en = (item.element as EnumElement).name;
      out.writeln("""
            if (e is! String) {
              issues.add(EasyIssue(path: '${c.jsonKey}[' + i.toString() + ']', code: 'type_mismatch', message: 'Esperado String com nome do enum.'));
            } else {
              final ok = $en.values.any((x) => x.name == e);
              if (!ok) {
                issues.add(EasyIssue(path: '${c.jsonKey}[' + i.toString() + ']', code: 'invalid_enum', message: "Valor '\$e' não corresponde a $en."));
              }
            }
    """);
    } else {
      out.writeln("""
            if (e is! $itemBase) {
              issues.add(EasyIssue(path: '${c.jsonKey}[' + i.toString() + ']', code: 'type_mismatch', message: 'Esperado $itemBase.'));
            }
    """);
    }

    out.writeln("""
          }
        }
      }
    }
  """);
  }

  @override
  String toJson(FieldContext c) {
    final item = c.setItemType!;
    if (isEasyJsonClass(item)) {
      return "${c.instanceAccess}${c.isNullable ? '?' : ''}.map((e)=>e.toJson()).toList()";
    }
    if (isEnumType(item)) {
      return "${c.instanceAccess}${c.isNullable ? '?' : ''}.map((e)=>e.name).toList()";
    }
    return "${c.instanceAccess}${c.isNullable ? '?' : ''}.toList()";
  }
}

// ===== Map =====
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
        "onIssue?.call(EasyIssue(path: ${c.pathExpr} + '.' + entry.key.toString(), code: 'key_type_mismatch', message: 'Chave incompatível com o tipo do mapa.'))";

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
    final hasCtorDefault =
        c.enclosingClass.unnamedConstructor?.parameters
            .firstWhereOrNull((p) => p.name == c.name)
            ?.defaultValueCode !=
        null;
    if (!c.isNullable && !hasCtorDefault) {
      out.writeln(
        "if (!json.containsKey('${c.jsonKey}')) "
        "{ issues.add(EasyIssue(path: '${c.jsonKey}', code: 'missing_required', message: 'Campo obrigatório ausente.')); }",
      );
    }

    final kv = asMapKV(c.type);
    final V = kv.value!;
    final mk = c.mapKeyCoercion;

    out.writeln("""
      if (json.containsKey('${c.jsonKey}')) {
        final v = ${c.jsonAccessor};
        if (v != null && v is! Map) {
          issues.add(EasyIssue(path: '${c.jsonKey}', code: 'type_mismatch', message: 'Esperado Map.'));
        } else if (v is Map) {
    """);

    // Key check (quando EasyMapKeyType.int)
    if (mk == EasyMapKeyType.int) {
      out.writeln("""
          for (final e in v.entries) {
            final k = e.key;
            final ok = (k is int) || (k is num) || (k is String && num.tryParse(k) != null);
            if (!ok) {
              issues.add(EasyIssue(path: '${c.jsonKey}.' + k.toString(), code: 'key_type_mismatch', message: 'Chave incompatível com o tipo do mapa.'));
            }
          }
      """);
    }

    // Se há conversor de valor, não validamos tipo de valor (terceirizamos).
    if (c.valueFromJson == null) {
      if (isEasyJsonClass(V)) {
        final cn = (V.element as ClassElement).name;
        final vn = _lcFirst(cn);
        out.writeln("""
          for (final e in v.entries) {
            final val = e.value;
            if (val != null && val is! Map) {
              issues.add(EasyIssue(path: '${c.jsonKey}.' + e.key.toString(), code: 'type_mismatch', message: 'Esperado Map para $cn.'));
            } else if (val is Map) {
              final child = ${vn}Validate(Map<String,dynamic>.from(val as Map));
              for (final ci in child) {
                issues.add(EasyIssue(path: '${c.jsonKey}.' + e.key.toString() + '.' + ci.path, code: ci.code, message: ci.message));
              }
            }
          }
        """);
      } else if (isEnumType(V)) {
        final en = (V.element as EnumElement).name;
        out.writeln("""
          for (final e in v.entries) {
            final val = e.value;
            if (val != null && val is! String) {
              issues.add(EasyIssue(path: '${c.jsonKey}.' + e.key.toString(), code: 'type_mismatch', message: 'Esperado String com nome do enum.'));
            } else if (val != null) {
              final ok = $en.values.any((x) => x.name == val);
              if (!ok) {
                issues.add(EasyIssue(path: '${c.jsonKey}.' + e.key.toString(), code: 'invalid_enum', message: "Valor '\$val' não corresponde a $en."));
              }
            }
          }
        """);
      } else {
        final vBase = displayNonNull(V);
        out.writeln("""
          for (final e in v.entries) {
            final val = e.value;
            if (val != null && val is! $vBase) {
              issues.add(EasyIssue(path: '${c.jsonKey}.' + e.key.toString(), code: 'type_mismatch', message: 'Esperado $vBase.'));
            }
          }
        """);
      }
    }

    out.writeln("""
        }
      }
    """);
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
    final cn = (item.element as ClassElement).name;
    final vn = _lcFirst(cn);
    return "${vn}FromJson(Map<String,dynamic>.from(e as Map))";
  }
  if (isEnumType(item)) {
    final en = (item.element as EnumElement).name;
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
    final cn = (item.element as ClassElement).name;
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
    message: 'Esperado Map para $cn.'
  ));
  ${isNullableItem ? 'return null;' : '''return ${vn}FromJsonSafe(
            const <String,dynamic>{},
            onIssue:(i)=>onIssue?.call(EasyIssue(
              path: $pathPrefix + '.' + i.path,
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
    final en = (item.element as EnumElement).name;
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
            message: "Valor '\$v' não corresponde a $en."
          ));
          return $fb;
        }
        onIssue?.call(EasyIssue(
          path: $pathPrefix,
          code: 'type_mismatch',
          message: 'Esperado String com nome do enum.'
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
      return "((){ final v=entry.value; if (v is int) return v; onIssue?.call(EasyIssue(path: $pathPrefix, code: 'type_mismatch', message: 'Esperado int.')); return $itemFb; })()";
    case 'double':
      return "((){ final v=entry.value; if (v is num) return v.toDouble(); onIssue?.call(EasyIssue(path: $pathPrefix, code: 'type_mismatch', message: 'Esperado número (int/double).')); return $itemFb; })()";
    case 'bool':
      return "((){ final v=entry.value; if (v is bool) return v; onIssue?.call(EasyIssue(path: $pathPrefix, code: 'type_mismatch', message: 'Esperado bool.')); return $itemFb; })()";
    case 'String':
      return "((){ final v=entry.value; if (v is String) return v; onIssue?.call(EasyIssue(path: $pathPrefix, code: 'type_mismatch', message: 'Esperado String.')); return $itemFb; })()";
    default:
      return "((){ final v=entry.value; if (v is $base) return v; onIssue?.call(EasyIssue(path: $pathPrefix, code: 'type_mismatch', message: 'Esperado $base.')); return $itemFb; })()";
  }
}

String _fastValueParse(DartType V, FieldContext c) {
  if (isEasyJsonClass(V)) {
    final cn = (V.element as ClassElement).name;
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
    final cn = (V.element as ClassElement).name;
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
    final en = (V.element as EnumElement).name;
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

String _lcFirst(String s) =>
    s.isEmpty ? s : (s[0].toLowerCase() + s.substring(1));

String _safeItemParseForSet(DartType item, FieldContext c) {
  final pathWithIdx = "${c.pathExpr} + '[' + entry.key.toString() + ']'";

  // EasyJson class
  if (isEasyJsonClass(item)) {
    final cn = (item.element as ClassElement).name;
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
          message: 'Esperado Map para $cn.'
        ));
        return null;
      })()
    """;
  }

  // Enum
  if (isEnumType(item)) {
    final en = (item.element as EnumElement).name;
    return """
      (() {
        final vv = entry.value;
        if (vv is String) {
          final match = $en.values.where((x) => x.name == vv);
          if (match.isNotEmpty) return match.first;
          onIssue?.call(EasyIssue(
            path: $pathWithIdx,
            code: 'invalid_enum',
            message: "Valor '\$vv' não corresponde a $en."
          ));
          return null;
        }
        if (vv is int) {
          if (vv >= 0 && vv < $en.values.length) return $en.values[vv];
          onIssue?.call(EasyIssue(
            path: $pathWithIdx,
            code: 'invalid_enum_index',
            message: 'Índice de enum fora do intervalo.'
          ));
          return null;
        }
        onIssue?.call(EasyIssue(
          path: $pathWithIdx,
          code: 'type_mismatch',
          message: 'Esperado String com o nome do enum.'
        ));
        return null;
      })()
    """;
  }

  // Primitivos / outros
  final base = displayNonNull(item);
  String mismatchMsg(String expected) => "Esperado $expected.";

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
          onIssue?.call(EasyIssue(path: $pathWithIdx, code: 'type_mismatch', message: '${mismatchMsg('número')}'));
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
