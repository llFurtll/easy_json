part of '../strategies.dart';

/// Campos tipados com um parâmetro de tipo da classe (`T` / `T?`).
///
/// O gerador não sabe converter `T`, então as funções geradas recebem um
/// conversor por parâmetro de tipo (`fromJsonT` / `toJsonT`), no mesmo
/// padrão do `json_serializable` (generic argument factories).
class GenericStrategy implements TypeStrategy {
  @override
  String fromJson(FieldContext c) {
    if (c.convertFromJson != null) {
      return "${c.convertFromJson!}(${c.jsonAccessor})";
    }
    final t = displayNonNull(c.type);
    return c.isNullable
        ? "${c.jsonAccessor} == null ? null : fromJson$t(${c.jsonAccessor})"
        : "fromJson$t(${c.jsonAccessor})";
  }

  @override
  String fromJsonSafe(FieldContext c) {
    if (c.convertFromJson != null) {
      return "${c.convertFromJson!}(${c.jsonAccessor})";
    }
    final t = displayNonNull(c.type);

    // Campo não-nulo: não existe fallback possível para um `T` desconhecido,
    // então a segurança aqui depende do conversor recebido.
    if (!c.isNullable) return "fromJson$t(${c.jsonAccessor})";

    return """
      (() {
        final v = ${c.jsonAccessor};
        if (v == null) return null;
        try {
          return fromJson$t(v);
        } catch (_) {
          onIssue?.call(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Could not convert value to $t.'));
          return null;
        }
      })()
    """;
  }

  @override
  void validate(FieldContext c, StringBuffer out) {
    // O tipo real de `T` só é conhecido pelo conversor; aqui só dá pra
    // checar presença (missing_required), feita pelo _validateField.
    _validateField(c, out, '');
  }

  @override
  String toJson(FieldContext c) {
    if (c.convertToJson != null) {
      final call = "${c.convertToJson!}(${c.instanceAccess})";
      return c.isNullable
          ? "(${c.instanceAccess} == null ? null : $call)"
          : call;
    }
    final t = displayNonNull(c.type);
    return c.isNullable
        ? "(${c.instanceAccess} == null ? null : toJson$t(${c.instanceAccess} as $t))"
        : "toJson$t(${c.instanceAccess})";
  }
}
