part of '../strategies.dart';

/// Campo cujo tipo é uma classe @EasyJson. Classes genéricas (`Page<User>`)
/// precisam passar conversores para cada argumento de tipo, então vão pelo
/// codec.
class ObjectStrategy implements TypeStrategy {
  bool _generic(FieldContext c) => _args(c.type).isNotEmpty;

  @override
  String fromJson(FieldContext c) {
    if (_generic(c)) return _cFast(c.type, c.jsonAccessor);
    final cn = displayNonNull(c.type);
    final vn = _lcFirst(cn);
    final cast = "${c.jsonAccessor} as Map<String, dynamic>";
    return c.isNullable
        ? "${c.jsonAccessor} == null ? null : ${vn}FromJson($cast)"
        : "${vn}FromJson($cast)";
  }

  @override
  String fromJsonSafe(FieldContext c) {
    if (_generic(c)) {
      // Ausente/null no topo já é reportado pelo validate (missing_required).
      final fb = c.isNullable ? 'null' : _cFallback(c.type, c.pathExpr, 0);
      return '(() { final x0 = ${c.jsonAccessor}; if (x0 == null) return $fb; '
          '${_cSafeBody(c.type, 'x0', c.pathExpr, fb, 0)} })()';
    }
    final cn = displayNonNull(c.type); // ex.: Address
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
    if (_generic(c)) {
      return _validateField(c, out, 'if (v != null) { ${_cValidateNonNull(c.type, 'v', c.pathExpr)} }');
    }
    final cn = displayNonNull(c.type);
    final vn = _lcFirst(cn);

    final check =
        """
        if (v != null && v is! Map) {
          issues.add(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Expected Map for $cn.'));
        } else if (v is Map) {
          final child = ${vn}Validate(Map<String,dynamic>.from(v));
          for (final ci in child) {
            issues.add(EasyIssue(path: ${c.pathExpr} + '.' + ci.path, code: ci.code, message: ci.message));
          }
        }
    """;
    _validateField(c, out, check);
  }

  @override
  String toJson(FieldContext c) => _generic(c)
      ? _cEncode(c.type, c.instanceAccess)
      : c.isNullable
      ? "${c.instanceAccess}?.toJson()"
      : "${c.instanceAccess}.toJson()";
}

