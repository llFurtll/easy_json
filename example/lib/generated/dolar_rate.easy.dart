// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// EasyJsonGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// EasyJsonGenerator
// **************************************************************************

// ignore_for_file: type=lint, unused_import, unnecessary_cast, unused_local_variable, duplicate_import
import 'package:example/dolar_rate.dart';
import 'package:dart_easy_json/runtime.dart';
import 'package:example/dolar_rate.dart';

import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_easy_json/runtime.dart' as ej;

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
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('moneda') && json['moneda'] == null) {
    issues.add(
      EasyIssue(
        path: 'moneda',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
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
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  if (!json.containsKey('casa')) {
    issues.add(
      EasyIssue(
        path: 'casa',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('casa') && json['casa'] == null) {
    issues.add(
      EasyIssue(
        path: 'casa',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
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
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  if (!json.containsKey('nombre')) {
    issues.add(
      EasyIssue(
        path: 'nombre',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('nombre') && json['nombre'] == null) {
    issues.add(
      EasyIssue(
        path: 'nombre',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
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
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  if (!json.containsKey('compra')) {
    issues.add(
      EasyIssue(
        path: 'compra',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('compra') && json['compra'] == null) {
    issues.add(
      EasyIssue(
        path: 'compra',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('compra')) {
    final v = json['compra'];
    if (v != null) {
      final _n = v is num
          ? v.toDouble()
          : (v is String ? double.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'compra',
            code: 'type_mismatch',
            message: 'Expected number.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  if (!json.containsKey('venta')) {
    issues.add(
      EasyIssue(
        path: 'venta',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('venta') && json['venta'] == null) {
    issues.add(
      EasyIssue(
        path: 'venta',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('venta')) {
    final v = json['venta'];
    if (v != null) {
      final _n = v is num
          ? v.toDouble()
          : (v is String ? double.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'venta',
            code: 'type_mismatch',
            message: 'Expected number.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  if (!json.containsKey('fechaActualizacion')) {
    issues.add(
      EasyIssue(
        path: 'fechaActualizacion',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('fechaActualizacion') &&
      json['fechaActualizacion'] == null) {
    issues.add(
      EasyIssue(
        path: 'fechaActualizacion',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('fechaActualizacion')) {
    final v = json['fechaActualizacion'];
    if (v != null && v is! String && v is! num && v is! DateTime) {
      issues.add(
        EasyIssue(
          path: 'fechaActualizacion',
          code: 'type_mismatch',
          message: 'Expected String (ISO), num or DateTime.',
        ),
      );
    } else if (v is String) {
      if (DateTime.tryParse(v) == null) {
        issues.add(
          EasyIssue(
            path: 'fechaActualizacion',
            code: 'type_mismatch',
            message: 'Invalid ISO format.',
          ),
        );
      } else {
        final dt = DateTime.parse(v);
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
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in dollarRateValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => DollarRate(
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
      if (v is num) return v.toDouble();
      if (v is String) {
        final p = double.tryParse(v);
        if (p != null) return p;
      }
      return 0.0;
    })(),
    sell: (() {
      final v = json['venta'];
      if (v is num) return v.toDouble();
      if (v is String) {
        final p = double.tryParse(v);
        if (p != null) return p;
      }
      return 0.0;
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
              message: 'Invalid DateTime format.',
            ),
          );
          return DateTime.fromMillisecondsSinceEpoch(0);
        }
      }
      onIssue?.call(
        EasyIssue(
          path: 'fechaActualizacion',
          code: 'type_mismatch',
          message: 'Expected String/epoch/DateTime.',
        ),
      );
      return DateTime.fromMillisecondsSinceEpoch(0);
    })(),
  ))(_report);
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

List<DollarRate> dollarRateFromJsonList(List<dynamic> json) =>
    json.map((e) => dollarRateFromJson(e as Map<String, dynamic>)).toList();

List<DollarRate> dollarRateFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => dollarRateFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> dollarRateToJsonList(List<DollarRate> items) =>
    items.map((e) => dollarRateToJson(e)).toList();
