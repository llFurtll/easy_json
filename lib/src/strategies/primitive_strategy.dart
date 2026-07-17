part of '../strategies.dart';

class PrimitiveStrategy implements TypeStrategy {
  @override
  String fromJson(FieldContext c) {
    // 1) Conversor de campo tem precedência no fromJson simples (sem try/catch extra)
    if (c.convertFromJson != null) {
      return "${c.convertFromJson!}(${c.jsonAccessor})";
    }

    // 2) Lógica padrão
    final t = displayNonNull(c.type);
    final isN = c.isNullable;

    if (isExactlyDateTime(c.type)) {
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
    // 1. Prepara o Fallback (valor padrão caso tudo falhe)
    final fb = _fallbackFor(
      c.type,
      nullable: c.isNullable,
      custom: c.fieldFallback,
    );

    // 2. Constrói a Lógica NATIVA Robusta (Standard Logic)
    //    Esta lógica sabe converter String->DateTime, int->DateTime, etc.
    //    Vamos guardá-la numa string para usar em dois lugares.
    String standardLogic;

    if (isExactlyDateTime(c.type)) {
      final nfb = c.isNullable
          ? 'null'
          : 'DateTime.fromMillisecondsSinceEpoch(0)';
      // Lógica nativa poderosa para DateTime
      standardLogic =
          """
        (() {
          final v = ${c.jsonAccessor};
          if (v == null) return $nfb;
          if (v is DateTime) return v;
          if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
          if (v is num) return DateTime.fromMillisecondsSinceEpoch(v.toInt());
          if (v is String) {
            try { return DateTime.parse(v); } catch (_) {
              onIssue?.call(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Invalid DateTime format.'));
              return $nfb; 
            }
          }
          onIssue?.call(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Expected String/epoch/DateTime.'));
          return $nfb;
        })()
      """;
    } else {
      // Lógica nativa para primitivos
      final t = displayNonNull(c.type);
      switch (t) {
        case 'int':
          standardLogic =
              "((){ final v=${c.jsonAccessor}; if (v is int) return v; if (v is num) return v.toInt(); if (v is String) { final p = int.tryParse(v); if(p!=null) return p;} return $fb; })()";
          break;
        case 'double':
          standardLogic =
              "((){ final v=${c.jsonAccessor}; if (v is num) return v.toDouble(); if (v is String) { final p = double.tryParse(v); if(p!=null) return p;} return $fb; })()";
          break;
        case 'bool':
          standardLogic =
              "((){ final v=${c.jsonAccessor}; return (v is bool)?v:$fb; })()";
          break;
        case 'String':
          standardLogic = c.isNullable
              ? "((){ final v=${c.jsonAccessor}; return (v is String) ? v : null; })()"
              : "((){ final v=${c.jsonAccessor}; return (v is String) ? v : ''; })()";
          break;
        default:
          standardLogic = "${c.jsonAccessor} as ${displayWithNull(c.type)}";
      }
    }

    // 3. Verifica se existe Conversor Customizado
    if (c.convertFromJson != null) {
      // AQUI ESTÁ A MÁGICA:
      // Tenta o Custom -> Catch -> Tenta o Nativo (standardLogic) -> Fallback
      return """
        (() {
          try {
            // Tenta usar o conversor TmDateMs
            return ${c.convertFromJson!}(${c.jsonAccessor});
          } catch (e) {
            // TmDateMs falhou (ex: veio String mas ele queria int).
            // Em vez de falhar, tenta a lógica nativa robusta!
            return $standardLogic;
          }
        })()
      """;
    }

    // 4. Se não tem conversor, usa direto a lógica nativa
    return standardLogic;
  }

  @override
  void validate(FieldContext c, StringBuffer out) {
    // Validação padrão
    final t = displayNonNull(c.type);

    // Se tem conversor, pulamos validação de tipo de entrada (o converter cuida)
    if (c.convertFromJson != null) return;

    String check;
    if (isExactlyDateTime(c.type)) {
      check =
          """
        if (v != null && v is! String && v is! num && v is! DateTime) {
          issues.add(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Expected String (ISO), num or DateTime.'));
        } else if (v is String) {
          if (DateTime.tryParse(v) == null) {
             issues.add(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Invalid ISO format.'));
          } else {
             final dt = DateTime.parse(v);
             ${_generateDateTimeValidationChecks(c, 'dt')}
          }
        }
      """;
    } else if (t == 'double') {
      check =
          "if (v != null && v is! num && v is! String) { "
          "  issues.add(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Expected number.')); "
          "}";
    } else {
      final sb = StringBuffer(
        "if (v != null && v is! $t) { "
        "  issues.add(EasyIssue(path: ${c.pathExpr}, code: 'type_mismatch', message: 'Expected $t.')); "
        "} else if (v != null) {",
      );
      _generateValidationChecks(c, sb);
      sb.write('}');
      check = sb.toString();
    }
    _validateField(c, out, check);
  }

  @override
  String toJson(FieldContext c) {
    if (c.convertToJson != null) {
      final call = "${c.convertToJson!}(${c.instanceAccess})";
      return c.isNullable
          ? "(${c.instanceAccess} == null ? null : $call)"
          : call;
    }

    if (isExactlyDateTime(c.type)) {
      return c.isNullable
          ? "${c.instanceAccess}?.toIso8601String()"
          : "${c.instanceAccess}.toIso8601String()";
    }

    return c.instanceAccess;
  }
}

