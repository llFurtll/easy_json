// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// EasyJsonGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// EasyJsonGenerator
// **************************************************************************

// ignore_for_file: type=lint
import 'package:dart_easy_json/src/easy_issue.dart';
import 'package:example/dolar_rate.dart';
import 'package:dart_easy_json/src/runtime.dart' as ej;
import 'package:dart_easy_json/src/messages.dart';

DollarRate dollarRateFromJson(Map<String, dynamic> json) {
  return DollarRate(
    currency: (json['moneda'] as String?) ?? '',
    house: (json['casa'] as String?) ?? '',
    name: (json['nombre'] as String?) ?? '',
    buy: (json['compra'] as num?)?.toDouble() ?? 0.0,
    sell: (json['venta'] as num?)?.toDouble() ?? 0.0,
    updatedAt: ej.parseDateTime(json['fechaActualizacion']),
  );
}

Map<String, dynamic> dollarRateToJson(DollarRate instance) {
  return <String, dynamic>{
    'moneda': instance.currency,
    'casa': instance.house,
    'nombre': instance.name,
    'compra': instance.buy,
    'venta': instance.sell,
    'fechaActualizacion': instance.updatedAt.toIso8601String(),
  };
}

mixin DollarRateSerializer {
  Map<String, dynamic> toJson() {
    return dollarRateToJson(this as DollarRate);
  }
}

List<EasyIssue> dollarRateValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('moneda')) {
    issues.add(
      EasyIssue(
        path: 'moneda',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.',
      ),
    );
  }
  if (json.containsKey('moneda')) {
    final v = json['moneda'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'moneda',
          code: 'type_mismatch',
          message: 'Esperado String.',
        ),
      );
    }
  }
  if (!json.containsKey('casa')) {
    issues.add(
      EasyIssue(
        path: 'casa',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.',
      ),
    );
  }
  if (json.containsKey('casa')) {
    final v = json['casa'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'casa',
          code: 'type_mismatch',
          message: 'Esperado String.',
        ),
      );
    }
  }
  if (!json.containsKey('nombre')) {
    issues.add(
      EasyIssue(
        path: 'nombre',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.',
      ),
    );
  }
  if (json.containsKey('nombre')) {
    final v = json['nombre'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'nombre',
          code: 'type_mismatch',
          message: 'Esperado String.',
        ),
      );
    }
  }
  if (!json.containsKey('compra')) {
    issues.add(
      EasyIssue(
        path: 'compra',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.',
      ),
    );
  }
  if (json.containsKey('compra')) {
    final v = json['compra'];
    if (v != null && v is! num) {
      issues.add(
        EasyIssue(
          path: 'compra',
          code: 'type_mismatch',
          message: 'Esperado número (int/double).',
        ),
      );
    }
  }
  if (!json.containsKey('venta')) {
    issues.add(
      EasyIssue(
        path: 'venta',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.',
      ),
    );
  }
  if (json.containsKey('venta')) {
    final v = json['venta'];
    if (v != null && v is! num) {
      issues.add(
        EasyIssue(
          path: 'venta',
          code: 'type_mismatch',
          message: 'Esperado número (int/double).',
        ),
      );
    }
  }
  if (!json.containsKey('fechaActualizacion')) {
    issues.add(
      EasyIssue(
        path: 'fechaActualizacion',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.',
      ),
    );
  }
  if (json.containsKey('fechaActualizacion')) {
    final v = json['fechaActualizacion'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'fechaActualizacion',
          code: 'type_mismatch',
          message: 'Esperado String (ISO-8601) para DateTime.',
        ),
      );
    } else if (v != null) {
      try {
        DateTime.parse(v as String);
      } catch (_) {
        issues.add(
          EasyIssue(
            path: 'fechaActualizacion',
            code: 'type_mismatch',
            message: 'Formato inválido de DateTime.',
          ),
        );
      }
    }
  }
  return issues;
}

DollarRate dollarRateFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  if (runValidate) {
    final _issues = dollarRateValidate(json);
    if (onIssue != null) {
      for (final i in _issues) onIssue(i);
    }
  }
  return DollarRate(
    currency: (() {
      final v = json['moneda'];
      return (v is String) ? v : '';
    })(),
    house: (() {
      final v = json['casa'];
      return (v is String) ? v : '';
    })(),
    name: (() {
      final v = json['nombre'];
      return (v is String) ? v : '';
    })(),
    buy: (() {
      final v = json['compra'];
      return (v is num) ? v.toDouble() : 0.0;
    })(),
    sell: (() {
      final v = json['venta'];
      return (v is num) ? v.toDouble() : 0.0;
    })(),
    updatedAt: (() {
      final v = json['fechaActualizacion'];
      if (v == null) return DateTime.fromMillisecondsSinceEpoch(0);
      if (v is DateTime) return v;
      if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
      if (v is num) return DateTime.fromMillisecondsSinceEpoch(v.toInt());
      if (v is String) {
        try {
          return DateTime.parse(v);
        } catch (_) {
          onIssue?.call(
            EasyIssue(
              path: 'fechaActualizacion',
              code: 'type_mismatch',
              message: 'Formato inválido de DateTime.',
            ),
          );
          return DateTime.fromMillisecondsSinceEpoch(0);
        }
      }
      onIssue?.call(
        EasyIssue(
          path: 'fechaActualizacion',
          code: 'type_mismatch',
          message: 'Esperado String/epoch/DateTime.',
        ),
      );
      return DateTime.fromMillisecondsSinceEpoch(0);
    })(),
  );
}

class DollarRateJson {
  const DollarRateJson();

  static DollarRate fromJson(Map<String, dynamic> json) {
    return dollarRateFromJson(json);
  }

  static DollarRate fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return dollarRateFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return dollarRateValidate(json);
  }
}
