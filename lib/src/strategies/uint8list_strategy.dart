part of '../strategies.dart';

class Uint8ListStrategy implements TypeStrategy {
  @override
  String fromJson(FieldContext c) {
    if (c.convertFromJson != null) {
      return "${c.convertFromJson!}(${c.jsonAccessor})";
    }
    final isN = c.isNullable;

    // O fromJson normal lança exceção se estiver quebrado (exceto se for nullable e não vier)
    if (isN) {
      return "(${c.jsonAccessor} as String?) != null ? base64Decode(${c.jsonAccessor} as String) : null";
    }
    return "base64Decode(${c.jsonAccessor} as String)";
  }

  @override
  String fromJsonSafe(FieldContext c) {
    final nfb = c.isNullable ? 'null' : 'Uint8List(0)';
    final code =
        """
      (() {
        final v = ${c.jsonAccessor};
        if (v == null) return $nfb;
        if (v is String) {
          try {
            return base64Decode(v);
          } catch (_) {
            onIssue?.call(EasyIssue(path: ${c.pathExpr}, code: 'invalid_base64', message: 'Invalid Base64 string.'));
            return $nfb;
          }
        }
        onIssue?.call(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Expected String (Base64).'));
        return $nfb;
      })()
    """;
    return code;
  }

  @override
  void validate(FieldContext c, StringBuffer out) {
    _validateField(c, out, """
      if (v is! String) {
        issues.add(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Expected String (Base64).'));
      } else {
        try {
          base64Decode(v);
        } catch (_) {
          issues.add(EasyIssue(path: ${c.pathExpr}, code: 'invalid_base64', message: 'Invalid Base64 string.'));
        }
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
      return "(${c.instanceAccess} != null ? base64Encode(${c.instanceAccess}!) : null)";
    }
    return "base64Encode(${c.instanceAccess})";
  }
}

