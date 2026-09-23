part of '../strategies.dart';

class UriStrategy implements TypeStrategy {
  @override
  String fromJson(FieldContext c) {
    if (c.convertFromJson != null) {
      return "${c.convertFromJson!}(${c.jsonAccessor})";
    }
    final isN = c.isNullable;

    // O fromJson normal lança exceção se estiver quebrado (exceto se for nullable e não vier)
    if (isN) {
      return "(${c.jsonAccessor} as String?) != null ? Uri.parse(${c.jsonAccessor} as String) : null";
    }
    return "Uri.parse(${c.jsonAccessor} as String)";
  }

  @override
  String fromJsonSafe(FieldContext c) {
    // null num campo nullable continua null; valor inválido usa o
    // @EasyKey(fallback:) se houver.
    final custom = _fieldFallbackExpr(c);
    final onNull = c.isNullable ? 'null' : (custom ?? 'Uri()');
    final nfb = custom ?? (c.isNullable ? 'null' : 'Uri()');
    final code =
        """
      (() {
        final v = ${c.jsonAccessor};
        if (v == null) return $onNull;
        if (v is String) {
          final u = Uri.tryParse(v);
          if (u != null) return u;
          onIssue?.call(EasyIssue(path: ${c.pathExpr}, code: 'invalid_uri', message: 'Invalid URI.'));
          return $nfb;
        }
        onIssue?.call(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Expected String (URI).'));
        return $nfb;
      })()
    """;
    return code;
  }

  @override
  void validate(FieldContext c, StringBuffer out) {
    _validateField(c, out, """
      if (v is! String) {
        issues.add(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Expected String (URI).'));
      } else if (Uri.tryParse(v) == null) {
        issues.add(EasyIssue(path: ${c.pathExpr}, code: 'invalid_uri', message: 'Invalid URI.'));
      }
    """);
    _generateValidationChecks(c, out);
  }

  @override
  String toJson(FieldContext c) {
    if (c.convertToJson != null) {
      return "${c.convertToJson!}(${c.instanceAccess})";
    }
    if (c.isNullable) {
      return "${c.instanceAccess}?.toString()";
    }
    return "${c.instanceAccess}.toString()";
  }
}
