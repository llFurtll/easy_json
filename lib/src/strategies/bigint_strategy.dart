part of '../strategies.dart';

/// JSON representation: a decimal [String] (e.g. `"12345678901234567890"`).
/// JSON numbers cannot safely carry arbitrary precision (a JS/web runtime
/// only keeps exact integers up to 2^53), so large integers must travel as
/// strings. The SAFE variant also accepts a plain `int`/`num` for APIs that
/// send small values as a JSON number.
class BigIntStrategy implements TypeStrategy {
  @override
  String fromJson(FieldContext c) {
    if (c.convertFromJson != null) {
      return "${c.convertFromJson!}(${c.jsonAccessor})";
    }
    final isN = c.isNullable;

    if (isN) {
      return "(${c.jsonAccessor} as String?) != null ? BigInt.parse(${c.jsonAccessor} as String) : null";
    }
    return "BigInt.parse(${c.jsonAccessor} as String)";
  }

  @override
  String fromJsonSafe(FieldContext c) {
    final nfb = c.isNullable ? 'null' : 'BigInt.zero';
    final code =
        """
      (() {
        final v = ${c.jsonAccessor};
        if (v == null) return $nfb;
        if (v is String) {
          final b = BigInt.tryParse(v);
          if (b != null) return b;
          onIssue?.call(EasyIssue(path: ${c.pathExpr}, code: 'invalid_bigint', message: 'Invalid integer string.'));
          return $nfb;
        }
        if (v is int) return BigInt.from(v);
        if (v is num) return BigInt.from(v.toInt());
        onIssue?.call(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Expected String (integer) or int.'));
        return $nfb;
      })()
    """;
    return code;
  }

  @override
  void validate(FieldContext c, StringBuffer out) {
    _validateField(c, out, """
      if (v is String) {
        if (BigInt.tryParse(v) == null) {
          issues.add(EasyIssue(path: ${c.pathExpr}, code: 'invalid_bigint', message: 'Invalid integer string.'));
        }
      } else if (v is! num) {
        issues.add(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Expected String (integer) or int.'));
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
