part of '../strategies.dart';

/// JSON representation: microseconds as a number (matches [Duration.inMicroseconds]
/// and [Duration.new] named `microseconds` parameter, so no precision is lost).
class DurationStrategy implements TypeStrategy {
  @override
  String fromJson(FieldContext c) {
    if (c.convertFromJson != null) {
      return "${c.convertFromJson!}(${c.jsonAccessor})";
    }
    final isN = c.isNullable;

    if (isN) {
      return "(${c.jsonAccessor} as num?) != null ? Duration(microseconds: (${c.jsonAccessor} as num).toInt()) : null";
    }
    return "Duration(microseconds: (${c.jsonAccessor} as num).toInt())";
  }

  @override
  String fromJsonSafe(FieldContext c) {
    // null num campo nullable continua null; valor inválido usa o
    // @EasyKey(fallback:) se houver.
    final custom = _fieldFallbackExpr(c);
    final onNull = c.isNullable ? 'null' : (custom ?? 'Duration.zero');
    final nfb = custom ?? (c.isNullable ? 'null' : 'Duration.zero');
    final code =
        """
      (() {
        final v = ${c.jsonAccessor};
        if (v == null) return $onNull;
        if (v is num) return Duration(microseconds: v.toInt());
        if (v is String) {
          final p = int.tryParse(v);
          if (p != null) return Duration(microseconds: p);
        }
        onIssue?.call(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Expected number of microseconds.'));
        return $nfb;
      })()
    """;
    return code;
  }

  @override
  void validate(FieldContext c, StringBuffer out) {
    _validateField(c, out, """
      if (v is! num && !(v is String && int.tryParse(v) != null)) {
        issues.add(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Expected number of microseconds.'));
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
      return "${c.instanceAccess}?.inMicroseconds";
    }
    return "${c.instanceAccess}.inMicroseconds";
  }
}
