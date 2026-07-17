part of '../strategies.dart';

class EnumStrategy implements TypeStrategy {
  @override
  String fromJson(FieldContext c) {
    final en = displayNonNull(c.type);
    // Fast: assume String válida (byName)
    return c.isNullable
        ? "(${c.jsonAccessor} == null ? null : $en.values.byName(${c.jsonAccessor} as String))"
        : "$en.values.byName(${c.jsonAccessor} as String)";
  }

  @override
  String fromJsonSafe(FieldContext c) {
    final en = displayNonNull(c.type);
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
            message: "Value '\$v' does not match $en."
          ));
          return $fb;
        }

        // Índice numérico
        if (v is int) {
          if (v >= 0 && v < $en.values.length) return $en.values[v];
          onIssue?.call(EasyIssue(
            path: ${c.pathExpr},
            code: 'invalid_enum_index',
            message: 'Enum index out of range.'
          ));
          return $fb;
        }

        onIssue?.call(EasyIssue(
          path: ${c.pathExpr},
          code: 'type_mismatch',
          message: 'Expected String with enum name or int index.'
        ));
        return ${isN ? 'null' : fb};
      })()
    """;
  }

  @override
  void validate(FieldContext c, StringBuffer out) {
    final en = displayNonNull(c.type);

    final check =
      """
        if (v != null && v is! String) {
          issues.add(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Expected String with the enum name.'));
        } else if (v != null) {
          final ok = $en.values.any((e) => e.name == v);
          if (!ok) {
            issues.add(EasyIssue(path: ${c.pathExpr}, code: 'invalid_enum', message: "Value '\$v' does not match $en."));
          }
        }
    """;
    _validateField(c, out, check);
  }

  @override
  String toJson(FieldContext c) {
    final acc = c.instanceAccess;
    return c.isNullable ? "($acc?.name)" : "$acc.name";
  }
}

