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
import 'test_models.dart';

import 'package:dart_easy_json/runtime.dart';

import 'test_models.dart';
import 'test_models.easy.dart';
import 'types.dart';

import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_easy_json/runtime.dart' as ej;

Address addressFromJson(Map<String, dynamic> json) {
  return Address(
    street: (json['street'] as String?) ?? '',
    number: (json['number'] as int?) ?? 0,
  );
}

Map<String, dynamic> addressToJson(Address instance) {
  return <String, dynamic>{
    'street': instance.street,
    'number': instance.number,
  };
}

mixin AddressSerializer {
  Map<String, dynamic> toJson() {
    return addressToJson(this as Address);
  }
}

List<EasyIssue> addressValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (json.containsKey('street')) {
    final v = json['street'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'street',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  if (json.containsKey('number')) {
    final v = json['number'];
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'number',
            code: 'type_mismatch',
            message: 'Expected int.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  return issues;
}

Address addressFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in addressValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Address(
    street: (() {
      final v = json['street'];
      return (v is String) ? v : '';
    })(),
    number: (() {
      final v = json['number'];
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return p;
      }
      return 0;
    })(),
  ))(_report);
}

class AddressJson {
  const AddressJson();

  static Address fromJson(Map<String, dynamic> json) {
    return addressFromJson(json);
  }

  static Address fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return addressFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return addressValidate(json);
  }
}

List<Address> addressFromJsonList(List<dynamic> json) =>
    json.map((e) => addressFromJson(e as Map<String, dynamic>)).toList();

List<Address> addressFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => addressFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> addressToJsonList(List<Address> items) =>
    items.map((e) => addressToJson(e)).toList();

Product productFromJson(Map<String, dynamic> json) {
  return Product(
    id: (json['id'] as int?) ?? 0,
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    name: (json['name'] as String?) ?? '',
  );
}

Map<String, dynamic> productToJson(Product instance) {
  return <String, dynamic>{
    'id': instance.id,
    'price': instance.price,
    'name': instance.name,
  };
}

mixin ProductSerializer {
  Map<String, dynamic> toJson() {
    return productToJson(this as Product);
  }
}

List<EasyIssue> productValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('id')) {
    issues.add(
      EasyIssue(
        path: 'id',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('id') && json['id'] == null) {
    issues.add(
      EasyIssue(
        path: 'id',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('id')) {
    final v = json['id'];
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'id',
            code: 'type_mismatch',
            message: 'Expected int.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  if (!json.containsKey('price')) {
    issues.add(
      EasyIssue(
        path: 'price',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('price') && json['price'] == null) {
    issues.add(
      EasyIssue(
        path: 'price',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('price')) {
    final v = json['price'];
    if (v != null) {
      final _n = v is num
          ? v.toDouble()
          : (v is String ? double.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'price',
            code: 'type_mismatch',
            message: 'Expected number.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  if (!json.containsKey('name')) {
    issues.add(
      EasyIssue(
        path: 'name',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('name') && json['name'] == null) {
    issues.add(
      EasyIssue(
        path: 'name',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('name')) {
    final v = json['name'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'name',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  return issues;
}

Product productFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in productValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Product(
    id: (() {
      final v = json['id'];
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return p;
      }
      return 0;
    })(),
    price: (() {
      final v = json['price'];
      if (v is num) return v.toDouble();
      if (v is String) {
        final p = double.tryParse(v);
        if (p != null) return p;
      }
      return 0.0;
    })(),
    name: (() {
      final v = json['name'];
      return (v is String) ? v : '';
    })(),
  ))(_report);
}

class ProductJson {
  const ProductJson();

  static Product fromJson(Map<String, dynamic> json) {
    return productFromJson(json);
  }

  static Product fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return productFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return productValidate(json);
  }
}

List<Product> productFromJsonList(List<dynamic> json) =>
    json.map((e) => productFromJson(e as Map<String, dynamic>)).toList();

List<Product> productFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => productFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> productToJsonList(List<Product> items) =>
    items.map((e) => productToJson(e)).toList();

Order orderFromJson(Map<String, dynamic> json) {
  return Order(
    orderId: (json['orderId'] as String?) ?? '',
    createdAt: TmDateMs.fromJson(json['createdAt']),
    buyerRole: TmRole.values.byName(json['buyerRole'] as String),
    shipping: addressFromJson(json['shipping'] as Map<String, dynamic>),
    items: (Map<dynamic, dynamic>.from(json['items'] as Map)).entries
        .fold<Map<int, Product>>(<int, Product>{}, (acc, entry) {
          final k = (entry.key is int
              ? (entry.key as int)
              : (entry.key is num
                    ? (entry.key as num).toInt()
                    : int.parse(entry.key as String)));
          final v = productFromJson(
            Map<String, dynamic>.from(entry.value as Map),
          );
          acc[k] = v;
          return acc;
        }),
    quantities: (Map<dynamic, dynamic>.from(json['quantities'] as Map)).entries
        .fold<Map<String, int>>(<String, int>{}, (acc, entry) {
          final k = (entry.key is String
              ? (entry.key as String)
              : entry.key.toString());
          final v = (entry.value as int?) ?? 0;
          acc[k] = v;
          return acc;
        }),
    notes:
        ((json['notes'] as List?)?.asMap().entries.map<String>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (e as String?) ?? '';
        }).toList()) ??
        const <String>[],
    tags:
        ((json['tags'] as List?)?.asMap().entries.map<String>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (e as String?) ?? '';
        }).toSet()) ??
        const <String>{},
    statusHistory: (Map<dynamic, dynamic>.from(json['statusHistory'] as Map))
        .entries
        .fold<Map<String, TmStatus>>(<String, TmStatus>{}, (acc, entry) {
          final k = (entry.key is String
              ? (entry.key as String)
              : entry.key.toString());
          final v = TmStatus.values.byName(entry.value as String);
          acc[k] = v;
          return acc;
        }),
    scores: (Map<dynamic, dynamic>.from(json['scores'] as Map)).entries
        .fold<Map<String, int>>(<String, int>{}, (acc, entry) {
          final k = (entry.key is String
              ? (entry.key as String)
              : entry.key.toString());
          final v = TmIntAny.fromJson(entry.value);
          acc[k] = v;
          return acc;
        }),
  );
}

Map<String, dynamic> orderToJson(Order instance) {
  return <String, dynamic>{
    'orderId': instance.orderId,
    'createdAt': TmDateMs.toJson(instance.createdAt),
    'buyerRole': instance.buyerRole.name,
    'shipping': instance.shipping.toJson(),
    'items': instance.items.map((k, v) => MapEntry(k.toString(), v.toJson())),
    'quantities': instance.quantities,
    'notes': instance.notes,
    'tags': instance.tags.toList(),
    'statusHistory': instance.statusHistory.map((k, v) => MapEntry(k, v.name)),
    'scores': instance.scores.map((k, v) => MapEntry(k, TmIntAny.toJson(v))),
  };
}

mixin OrderSerializer {
  Map<String, dynamic> toJson() {
    return orderToJson(this as Order);
  }
}

List<EasyIssue> orderValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('orderId')) {
    issues.add(
      EasyIssue(
        path: 'orderId',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('orderId') && json['orderId'] == null) {
    issues.add(
      EasyIssue(
        path: 'orderId',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('orderId')) {
    final v = json['orderId'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'orderId',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  if (!json.containsKey('buyerRole')) {
    issues.add(
      EasyIssue(
        path: 'buyerRole',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('buyerRole') && json['buyerRole'] == null) {
    issues.add(
      EasyIssue(
        path: 'buyerRole',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('buyerRole')) {
    final v = json['buyerRole'];
    if (v is int) {
      if (v < 0 || v >= TmRole.values.length) {
        issues.add(
          EasyIssue(
            path: 'buyerRole',
            code: 'invalid_enum_index',
            message: 'Enum index out of range.',
          ),
        );
      }
    } else if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'buyerRole',
          code: 'type_mismatch',
          message: 'Expected String with the enum name.',
        ),
      );
    } else if (v != null) {
      final ok = TmRole.values.any((e) => e.name == v);
      if (!ok) {
        issues.add(
          EasyIssue(
            path: 'buyerRole',
            code: 'invalid_enum',
            message: "Value '$v' does not match TmRole.",
          ),
        );
      }
    }
  }
  if (!json.containsKey('shipping')) {
    issues.add(
      EasyIssue(
        path: 'shipping',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('shipping') && json['shipping'] == null) {
    issues.add(
      EasyIssue(
        path: 'shipping',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('shipping')) {
    final v = json['shipping'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(
          path: 'shipping',
          code: 'type_mismatch',
          message: 'Expected Map for Address.',
        ),
      );
    } else if (v is Map) {
      final child = addressValidate(Map<String, dynamic>.from(v));
      for (final ci in child) {
        issues.add(
          EasyIssue(
            path: 'shipping' + '.' + ci.path,
            code: ci.code,
            message: ci.message,
          ),
        );
      }
    }
  }
  if (!json.containsKey('items')) {
    issues.add(
      EasyIssue(
        path: 'items',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('items') && json['items'] == null) {
    issues.add(
      EasyIssue(
        path: 'items',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('items')) {
    final v = json['items'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(
          path: 'items',
          code: 'type_mismatch',
          message: 'Expected Map.',
        ),
      );
    } else if (v is Map) {
      for (final e in v.entries) {
        final k = e.key;
        final ok =
            (k is int) ||
            (k is num) ||
            (k is String && num.tryParse(k) != null);
        if (!ok) {
          issues.add(
            EasyIssue(
              path: 'items' + '.' + k.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
        }
      }

      for (final e in v.entries) {
        final val = e.value;
        if (val != null && val is! Map) {
          issues.add(
            EasyIssue(
              path: 'items' + '.' + e.key.toString(),
              code: 'type_mismatch',
              message: 'Expected Map for Product.',
            ),
          );
        } else if (val is Map) {
          final child = productValidate(Map<String, dynamic>.from(val as Map));
          for (final ci in child) {
            issues.add(
              EasyIssue(
                path: 'items' + '.' + e.key.toString() + '.' + ci.path,
                code: ci.code,
                message: ci.message,
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('quantities')) {
    issues.add(
      EasyIssue(
        path: 'quantities',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('quantities') && json['quantities'] == null) {
    issues.add(
      EasyIssue(
        path: 'quantities',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('quantities')) {
    final v = json['quantities'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(
          path: 'quantities',
          code: 'type_mismatch',
          message: 'Expected Map.',
        ),
      );
    } else if (v is Map) {
      for (final e in v.entries) {
        final val = e.value;
        if (val == null) {
          issues.add(
            EasyIssue(
              path: 'quantities' + '.' + e.key.toString(),
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else if (val is! int) {
          issues.add(
            EasyIssue(
              path: 'quantities' + '.' + e.key.toString(),
              code: 'type_mismatch',
              message: 'Expected int.',
            ),
          );
        }
      }
    }
  }
  if (!json.containsKey('notes')) {
    issues.add(
      EasyIssue(
        path: 'notes',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('notes') && json['notes'] == null) {
    issues.add(
      EasyIssue(
        path: 'notes',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('notes')) {
    final v = json['notes'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'notes',
          code: 'type_mismatch',
          message: 'Expected List.',
        ),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'notes' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! String) {
            issues.add(
              EasyIssue(
                path: 'notes' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected String.',
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('tags')) {
    issues.add(
      EasyIssue(
        path: 'tags',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('tags') && json['tags'] == null) {
    issues.add(
      EasyIssue(
        path: 'tags',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('tags')) {
    final v = json['tags'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'tags',
          code: 'type_mismatch',
          message: 'Expected List for Set.',
        ),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'tags' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! String) {
            issues.add(
              EasyIssue(
                path: 'tags' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected String.',
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('statusHistory')) {
    issues.add(
      EasyIssue(
        path: 'statusHistory',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('statusHistory') && json['statusHistory'] == null) {
    issues.add(
      EasyIssue(
        path: 'statusHistory',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('statusHistory')) {
    final v = json['statusHistory'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(
          path: 'statusHistory',
          code: 'type_mismatch',
          message: 'Expected Map.',
        ),
      );
    } else if (v is Map) {
      for (final e in v.entries) {
        final val = e.value;
        if (val != null && val is! String) {
          issues.add(
            EasyIssue(
              path: 'statusHistory' + '.' + e.key.toString(),
              code: 'type_mismatch',
              message: 'Expected String with enum name.',
            ),
          );
        } else if (val != null) {
          final ok = TmStatus.values.any((x) => x.name == val);
          if (!ok) {
            issues.add(
              EasyIssue(
                path: 'statusHistory' + '.' + e.key.toString(),
                code: 'invalid_enum',
                message: "Value '$val' does not match TmStatus.",
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('scores')) {
    issues.add(
      EasyIssue(
        path: 'scores',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('scores') && json['scores'] == null) {
    issues.add(
      EasyIssue(
        path: 'scores',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('scores')) {
    final v = json['scores'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(
          path: 'scores',
          code: 'type_mismatch',
          message: 'Expected Map.',
        ),
      );
    } else if (v is Map) {}
  }
  return issues;
}

Order orderFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in orderValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Order(
    orderId: (() {
      final v = json['orderId'];
      return (v is String) ? v : '';
    })(),
    createdAt: (() {
      try {
        // Tenta usar o conversor TmDateMs
        return TmDateMs.fromJson(json['createdAt']);
      } catch (e) {
        // TmDateMs falhou (ex: veio String mas ele queria int).
        // Em vez de falhar, tenta a lógica nativa robusta!
        return (() {
          final v = json['createdAt'];
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
                  path: 'createdAt',
                  code: 'type_mismatch',
                  message: 'Invalid DateTime format.',
                ),
              );
              return DateTime.fromMillisecondsSinceEpoch(0);
            }
          }
          onIssue?.call(
            EasyIssue(
              path: 'createdAt',
              code: 'type_mismatch',
              message: 'Expected String/epoch/DateTime.',
            ),
          );
          return DateTime.fromMillisecondsSinceEpoch(0);
        })();
      }
    })(),
    buyerRole: (() {
      final v = json['buyerRole'];
      if (v == null)
        return TmRole.values.firstWhere(
          (e) => e.name == 'guest',
          orElse: () => TmRole.values.first,
        );

      // String pelo .name (tolerante a espaços/case)
      if (v is String) {
        final s = v.trim();
        for (final e in TmRole.values) {
          if (e.name == s || e.name.toLowerCase() == s.toLowerCase()) return e;
        }
        onIssue?.call(
          EasyIssue(
            path: 'buyerRole',
            code: 'invalid_enum',
            message: "Value '$v' does not match TmRole.",
          ),
        );
        return TmRole.values.firstWhere(
          (e) => e.name == 'guest',
          orElse: () => TmRole.values.first,
        );
      }

      // Índice numérico
      if (v is int) {
        if (v >= 0 && v < TmRole.values.length) return TmRole.values[v];
        onIssue?.call(
          EasyIssue(
            path: 'buyerRole',
            code: 'invalid_enum_index',
            message: 'Enum index out of range.',
          ),
        );
        return TmRole.values.firstWhere(
          (e) => e.name == 'guest',
          orElse: () => TmRole.values.first,
        );
      }

      onIssue?.call(
        EasyIssue(
          path: 'buyerRole',
          code: 'type_mismatch',
          message: 'Expected String with enum name or int index.',
        ),
      );
      return TmRole.values.firstWhere(
        (e) => e.name == 'guest',
        orElse: () => TmRole.values.first,
      );
    })(),
    shipping: (() {
      final _v = json['shipping'];
      if (_v == null)
        return addressFromJsonSafe(
          const <String, dynamic>{},
          onIssue: (i) => onIssue?.call(
            EasyIssue(
              path: 'shipping' + '.' + i.path,
              code: i.code,
              message: i.message,
            ),
          ),
          runValidate: false,
        );
      if (_v is Map) {
        return addressFromJsonSafe(
          Map<String, dynamic>.from(_v as Map),
          onIssue: (i) => onIssue?.call(
            EasyIssue(
              path: 'shipping' + '.' + i.path,
              code: i.code,
              message: i.message,
            ),
          ),
          runValidate: false,
        );
      }
      return addressFromJsonSafe(
        const <String, dynamic>{},
        onIssue: (i) => onIssue?.call(
          EasyIssue(
            path: 'shipping' + '.' + i.path,
            code: i.code,
            message: i.message,
          ),
        ),
        runValidate: false,
      );
    })(),
    items: (() {
      final _v = json['items'];
      if (_v is! Map) return const <int, Product>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <int, Product>{};
      for (final entry in _mapRaw.entries) {
        final k = (() {
          final _k = entry.key;
          if (_k is int) return _k;
          if (_k is num) return _k.toInt();
          if (_k is String) {
            final n = num.tryParse(_k);
            if (n != null) return n.toInt();
          }
          return null;
        })();
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 'items' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = (() {
          final _v = entry.value;
          if (_v is Map) {
            return productFromJsonSafe(
              Map<String, dynamic>.from(_v as Map),
              onIssue: (i) => onIssue?.call(
                EasyIssue(
                  path: 'items' + '.' + k.toString() + '.' + i.path,
                  code: i.code,
                  message: i.message,
                ),
              ),
              runValidate: false,
            );
          }
          return productFromJsonSafe(
            const <String, dynamic>{},
            onIssue: (i) => onIssue?.call(
              EasyIssue(
                path: 'items' + '.' + k.toString() + '.' + i.path,
                code: i.code,
                message: i.message,
              ),
            ),
            runValidate: false,
          );
        })();
        _out[k] = v;
      }
      return _out;
    })(),
    quantities: (() {
      final _v = json['quantities'];
      if (_v is! Map) return const <String, int>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <String, int>{};
      for (final entry in _mapRaw.entries) {
        final k = (entry.key is String) ? entry.key : (entry.key?.toString());
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 'quantities' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = (() {
          final v = entry.value;
          return (v is int) ? v : 0;
        })();
        _out[k] = v;
      }
      return _out;
    })(),
    notes: (() {
      final _v = json['notes'];
      if (_v is! List) return const <String>[];
      final _list = _v;
      return _list.asMap().entries.map<String>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'notes' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return '';
          }
          if (v is String) return v;
          onIssue?.call(
            EasyIssue(
              path: 'notes' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Expected String.',
            ),
          );
          return '';
        })();
      }).toList();
    })(),
    tags: (() {
      final _v = json['tags'];
      if (_v is! List) return const <String>{};
      final _list = _v;
      return _list
          .asMap()
          .entries
          .map<String?>((entry) {
            return (() {
              final vv = entry.value;
              if (vv == null) {
                onIssue?.call(
                  EasyIssue(
                    path: 'tags' + '[' + entry.key.toString() + ']',
                    code: 'null_not_allowed',
                    message: 'Null value not allowed.',
                  ),
                );
                return null;
              }
              if (vv is String) return vv;
              onIssue?.call(
                EasyIssue(
                  path: 'tags' + '[' + entry.key.toString() + ']',
                  code: 'type_mismatch',
                  message: 'Expected String.',
                ),
              );
              return null;
            })();
          })
          .where((x) => x != null)
          .cast<String>()
          .toSet();
    })(),
    statusHistory: (() {
      final _v = json['statusHistory'];
      if (_v is! Map) return const <String, TmStatus>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <String, TmStatus>{};
      for (final entry in _mapRaw.entries) {
        final k = (entry.key is String) ? entry.key : (entry.key?.toString());
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 'statusHistory' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = (entry.value is String
            ? TmStatus.values.firstWhere(
                (x) => x.name == entry.value,
                orElse: () => TmStatus.values.first,
              )
            : TmStatus.values.first);
        _out[k] = v;
      }
      return _out;
    })(),
    scores: (() {
      final _v = json['scores'];
      if (_v is! Map) return const <String, int>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <String, int>{};
      for (final entry in _mapRaw.entries) {
        final k = (entry.key is String) ? entry.key : (entry.key?.toString());
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 'scores' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = (() {
          try {
            return TmIntAny.fromJson(entry.value);
          } catch (_) {
            return 0;
          }
        })();
        _out[k] = v;
      }
      return _out;
    })(),
  ))(_report);
}

class OrderJson {
  const OrderJson();

  static Order fromJson(Map<String, dynamic> json) {
    return orderFromJson(json);
  }

  static Order fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return orderFromJsonSafe(json, onIssue: onIssue, runValidate: runValidate);
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return orderValidate(json);
  }
}

List<Order> orderFromJsonList(List<dynamic> json) =>
    json.map((e) => orderFromJson(e as Map<String, dynamic>)).toList();

List<Order> orderFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => orderFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> orderToJsonList(List<Order> items) =>
    items.map((e) => orderToJson(e)).toList();

User userFromJson(Map<String, dynamic> json) {
  return User(
    userName: (json['user_name'] as String?) ?? '',
    createdAt: ej.parseDateTime(json['created_at']),
    email: json['e_mail'] as String?,
  );
}

Map<String, dynamic> userToJson(User instance) {
  return <String, dynamic>{
    'user_name': instance.userName,
    'created_at': instance.createdAt.toIso8601String(),
    if (instance.email != null) 'e_mail': instance.email,
  };
}

mixin UserSerializer {
  Map<String, dynamic> toJson() {
    return userToJson(this as User);
  }
}

List<EasyIssue> userValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('user_name')) {
    issues.add(
      EasyIssue(
        path: 'user_name',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('user_name') && json['user_name'] == null) {
    issues.add(
      EasyIssue(
        path: 'user_name',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('user_name')) {
    final v = json['user_name'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'user_name',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  if (!json.containsKey('created_at')) {
    issues.add(
      EasyIssue(
        path: 'created_at',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('created_at') && json['created_at'] == null) {
    issues.add(
      EasyIssue(
        path: 'created_at',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('created_at')) {
    final v = json['created_at'];
    if (v != null && v is! String && v is! num && v is! DateTime) {
      issues.add(
        EasyIssue(
          path: 'created_at',
          code: 'type_mismatch',
          message: 'Expected String (ISO), num or DateTime.',
        ),
      );
    } else if (v is String) {
      if (DateTime.tryParse(v) == null) {
        issues.add(
          EasyIssue(
            path: 'created_at',
            code: 'type_mismatch',
            message: 'Invalid ISO format.',
          ),
        );
      } else {
        final dt = DateTime.parse(v);
      }
    }
  }
  if (json.containsKey('e_mail')) {
    final v = json['e_mail'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'e_mail',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  return issues;
}

User userFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in userValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => User(
    userName: (() {
      final v = json['user_name'];
      return (v is String) ? v : '';
    })(),
    createdAt: (() {
      final v = json['created_at'];
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
              path: 'created_at',
              code: 'type_mismatch',
              message: 'Invalid DateTime format.',
            ),
          );
          return DateTime.fromMillisecondsSinceEpoch(0);
        }
      }
      onIssue?.call(
        EasyIssue(
          path: 'created_at',
          code: 'type_mismatch',
          message: 'Expected String/epoch/DateTime.',
        ),
      );
      return DateTime.fromMillisecondsSinceEpoch(0);
    })(),
    email: (() {
      final v = json['e_mail'];
      return (v is String) ? v : null;
    })(),
  ))(_report);
}

class UserJson {
  const UserJson();

  static User fromJson(Map<String, dynamic> json) {
    return userFromJson(json);
  }

  static User fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return userFromJsonSafe(json, onIssue: onIssue, runValidate: runValidate);
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return userValidate(json);
  }
}

List<User> userFromJsonList(List<dynamic> json) =>
    json.map((e) => userFromJson(e as Map<String, dynamic>)).toList();

List<User> userFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => userFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> userToJsonList(List<User> items) =>
    items.map((e) => userToJson(e)).toList();

ValidationModel validationModelFromJson(Map<String, dynamic> json) {
  return ValidationModel(
    username: (json['username'] as String?) ?? '',
    age: (json['age'] as int?) ?? 0,
    email: json['email'] as String?,
    tags:
        ((json['tags'] as List?)?.asMap().entries.map<String>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (e as String?) ?? '';
        }).toList()) ??
        const <String>[],
    websiteUrl: json['websiteUrl'] as String?,
    uniqueId: (json['uniqueId'] as String?) ?? '',
    dateOfBirth: ej.parseDateTime(json['dateOfBirth']),
    nextAppointment: ej.parseDateTimeOrNull(json['nextAppointment']),
  );
}

Map<String, dynamic> validationModelToJson(ValidationModel instance) {
  return <String, dynamic>{
    'username': instance.username,
    'age': instance.age,
    if (instance.email != null) 'email': instance.email,
    'tags': instance.tags,
    if (instance.websiteUrl != null) 'websiteUrl': instance.websiteUrl,
    'uniqueId': instance.uniqueId,
    'dateOfBirth': instance.dateOfBirth.toIso8601String(),
    if (instance.nextAppointment != null)
      'nextAppointment': instance.nextAppointment?.toIso8601String(),
  };
}

mixin ValidationModelSerializer {
  Map<String, dynamic> toJson() {
    return validationModelToJson(this as ValidationModel);
  }
}

List<EasyIssue> validationModelValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('username')) {
    issues.add(
      EasyIssue(
        path: 'username',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('username') && json['username'] == null) {
    issues.add(
      EasyIssue(
        path: 'username',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('username')) {
    final v = json['username'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'username',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {
      if (v.length < 3) {
        issues.add(
          EasyIssue(
            path: 'username',
            code: 'min_length',
            message: 'Must have at least 3 characters.',
          ),
        );
      }
      if (v.length > 10) {
        issues.add(
          EasyIssue(
            path: 'username',
            code: 'max_length',
            message: 'Must have at most 10 characters.',
          ),
        );
      }
    }
  }
  if (!json.containsKey('age')) {
    issues.add(
      EasyIssue(
        path: 'age',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('age') && json['age'] == null) {
    issues.add(
      EasyIssue(
        path: 'age',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('age')) {
    final v = json['age'];
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'age',
            code: 'type_mismatch',
            message: 'Expected int.',
          ),
        );
      } else {
        final v = _n;
        if ((v as num) < 18) {
          issues.add(
            EasyIssue(
              path: 'age',
              code: 'min_value',
              message: 'The minimum value is 18.',
            ),
          );
        }
        if ((v as num) > 99) {
          issues.add(
            EasyIssue(
              path: 'age',
              code: 'max_value',
              message: 'The maximum value is 99.',
            ),
          );
        }
        if (!(MyCustomValidators.isPositive(v as int))) {
          issues.add(
            EasyIssue(
              path: 'age',
              code: 'custom_validation_failed',
              message: 'Custom validation failed.',
            ),
          );
        }
      }
    }
  }
  if (json.containsKey('email')) {
    final v = json['email'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'email',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {
      if (!RegExp(
        '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}\$',
      ).hasMatch(v as String)) {
        issues.add(
          EasyIssue(
            path: 'email',
            code: 'regex_mismatch',
            message: 'Invalid format.',
          ),
        );
      }
    }
  }
  if (!json.containsKey('tags')) {
    issues.add(
      EasyIssue(
        path: 'tags',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('tags') && json['tags'] == null) {
    issues.add(
      EasyIssue(
        path: 'tags',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('tags')) {
    final v = json['tags'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'tags',
          code: 'type_mismatch',
          message: 'Expected List.',
        ),
      );
    } else if (v is List) {
      if (v.length < 1) {
        issues.add(
          EasyIssue(
            path: 'tags',
            code: 'min_length',
            message: 'Must have at least 1 elements.',
          ),
        );
      }
      if (v.length > 3) {
        issues.add(
          EasyIssue(
            path: 'tags',
            code: 'max_length',
            message: 'Must have at most 3 elements.',
          ),
        );
      }
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'tags' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! String) {
            issues.add(
              EasyIssue(
                path: 'tags' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected String.',
              ),
            );
          }
        }
      }
    }
  }
  if (json.containsKey('websiteUrl')) {
    final v = json['websiteUrl'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'websiteUrl',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {
      if (!RegExp(
        '^(https|http)://[-a-zA-Z0-9@:%._+~#=]{1,256}\\.[a-zA-Z0-9()]{1,6}\\b([-a-zA-Z0-9()@:%_+.~#?&//=]*)\$',
      ).hasMatch(v as String)) {
        issues.add(
          EasyIssue(
            path: 'websiteUrl',
            code: 'invalid_url',
            message: 'Invalid URL.',
          ),
        );
      }
    }
  }
  if (!json.containsKey('uniqueId')) {
    issues.add(
      EasyIssue(
        path: 'uniqueId',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('uniqueId') && json['uniqueId'] == null) {
    issues.add(
      EasyIssue(
        path: 'uniqueId',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('uniqueId')) {
    final v = json['uniqueId'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'uniqueId',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {
      if (!RegExp(
        '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\$',
      ).hasMatch(v as String)) {
        issues.add(
          EasyIssue(
            path: 'uniqueId',
            code: 'invalid_uuid',
            message: 'Invalid UUID.',
          ),
        );
      }
    }
  }
  if (!json.containsKey('dateOfBirth')) {
    issues.add(
      EasyIssue(
        path: 'dateOfBirth',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('dateOfBirth') && json['dateOfBirth'] == null) {
    issues.add(
      EasyIssue(
        path: 'dateOfBirth',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('dateOfBirth')) {
    final v = json['dateOfBirth'];
    if (v != null && v is! String && v is! num && v is! DateTime) {
      issues.add(
        EasyIssue(
          path: 'dateOfBirth',
          code: 'type_mismatch',
          message: 'Expected String (ISO), num or DateTime.',
        ),
      );
    } else if (v is String) {
      if (DateTime.tryParse(v) == null) {
        issues.add(
          EasyIssue(
            path: 'dateOfBirth',
            code: 'type_mismatch',
            message: 'Invalid ISO format.',
          ),
        );
      } else {
        final dt = DateTime.parse(v);
        if (dt.isAfter(DateTime.now())) {
          issues.add(
            EasyIssue(
              path: 'dateOfBirth',
              code: 'must_be_past',
              message: 'The date must be in the past.',
            ),
          );
        }
      }
    }
  }
  if (json.containsKey('nextAppointment')) {
    final v = json['nextAppointment'];
    if (v != null && v is! String && v is! num && v is! DateTime) {
      issues.add(
        EasyIssue(
          path: 'nextAppointment',
          code: 'type_mismatch',
          message: 'Expected String (ISO), num or DateTime.',
        ),
      );
    } else if (v is String) {
      if (DateTime.tryParse(v) == null) {
        issues.add(
          EasyIssue(
            path: 'nextAppointment',
            code: 'type_mismatch',
            message: 'Invalid ISO format.',
          ),
        );
      } else {
        final dt = DateTime.parse(v);
        if (dt.isBefore(DateTime.now())) {
          issues.add(
            EasyIssue(
              path: 'nextAppointment',
              code: 'must_be_future',
              message: 'The date must be in the future.',
            ),
          );
        }
      }
    }
  }
  return issues;
}

ValidationModel validationModelFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in validationModelValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => ValidationModel(
    username: (() {
      final v = json['username'];
      return (v is String) ? v : '';
    })(),
    age: (() {
      final v = json['age'];
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return p;
      }
      return 0;
    })(),
    email: (() {
      final v = json['email'];
      return (v is String) ? v : null;
    })(),
    tags: (() {
      final _v = json['tags'];
      if (_v is! List) return const <String>[];
      final _list = _v;
      return _list.asMap().entries.map<String>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'tags' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return '';
          }
          if (v is String) return v;
          onIssue?.call(
            EasyIssue(
              path: 'tags' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Expected String.',
            ),
          );
          return '';
        })();
      }).toList();
    })(),
    websiteUrl: (() {
      final v = json['websiteUrl'];
      return (v is String) ? v : null;
    })(),
    uniqueId: (() {
      final v = json['uniqueId'];
      return (v is String) ? v : '';
    })(),
    dateOfBirth: (() {
      final v = json['dateOfBirth'];
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
              path: 'dateOfBirth',
              code: 'type_mismatch',
              message: 'Invalid DateTime format.',
            ),
          );
          return DateTime.fromMillisecondsSinceEpoch(0);
        }
      }
      onIssue?.call(
        EasyIssue(
          path: 'dateOfBirth',
          code: 'type_mismatch',
          message: 'Expected String/epoch/DateTime.',
        ),
      );
      return DateTime.fromMillisecondsSinceEpoch(0);
    })(),
    nextAppointment: (() {
      final v = json['nextAppointment'];
      if (v == null) return null;
      if (v is DateTime) return v;
      if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
      if (v is num) return DateTime.fromMillisecondsSinceEpoch(v.toInt());
      if (v is String) {
        try {
          return DateTime.parse(v);
        } catch (_) {
          onIssue?.call(
            EasyIssue(
              path: 'nextAppointment',
              code: 'type_mismatch',
              message: 'Invalid DateTime format.',
            ),
          );
          return null;
        }
      }
      onIssue?.call(
        EasyIssue(
          path: 'nextAppointment',
          code: 'type_mismatch',
          message: 'Expected String/epoch/DateTime.',
        ),
      );
      return null;
    })(),
  ))(_report);
}

class ValidationModelJson {
  const ValidationModelJson();

  static ValidationModel fromJson(Map<String, dynamic> json) {
    return validationModelFromJson(json);
  }

  static ValidationModel fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return validationModelFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return validationModelValidate(json);
  }
}

List<ValidationModel> validationModelFromJsonList(List<dynamic> json) => json
    .map((e) => validationModelFromJson(e as Map<String, dynamic>))
    .toList();

List<ValidationModel> validationModelFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => validationModelFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> validationModelToJsonList(
  List<ValidationModel> items,
) => items.map((e) => validationModelToJson(e)).toList();

IgnoreModel ignoreModelFromJson(Map<String, dynamic> json) {
  return IgnoreModel(visible: (json['visible'] as String?) ?? '');
}

Map<String, dynamic> ignoreModelToJson(IgnoreModel instance) {
  return <String, dynamic>{'visible': instance.visible};
}

mixin IgnoreModelSerializer {
  Map<String, dynamic> toJson() {
    return ignoreModelToJson(this as IgnoreModel);
  }
}

List<EasyIssue> ignoreModelValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('visible')) {
    issues.add(
      EasyIssue(
        path: 'visible',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('visible') && json['visible'] == null) {
    issues.add(
      EasyIssue(
        path: 'visible',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('visible')) {
    final v = json['visible'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'visible',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  return issues;
}

IgnoreModel ignoreModelFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in ignoreModelValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => IgnoreModel(
    visible: (() {
      final v = json['visible'];
      return (v is String) ? v : '';
    })(),
  ))(_report);
}

class IgnoreModelJson {
  const IgnoreModelJson();

  static IgnoreModel fromJson(Map<String, dynamic> json) {
    return ignoreModelFromJson(json);
  }

  static IgnoreModel fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return ignoreModelFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return ignoreModelValidate(json);
  }
}

List<IgnoreModel> ignoreModelFromJsonList(List<dynamic> json) =>
    json.map((e) => ignoreModelFromJson(e as Map<String, dynamic>)).toList();

List<IgnoreModel> ignoreModelFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => ignoreModelFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> ignoreModelToJsonList(List<IgnoreModel> items) =>
    items.map((e) => ignoreModelToJson(e)).toList();

PathModel pathModelFromJson(Map<String, dynamic> json) {
  return PathModel(
    count: ((json['meta'] as Map?)?['count'] as int?) ?? 0,
    userName:
        (((json['meta'] as Map?)?['info'] as Map?)?['user_name'] as String?) ??
        '',
  );
}

Map<String, dynamic> pathModelToJson(PathModel instance) {
  final json = <String, dynamic>{};
  ej.writePath(json, const ['meta', 'count'], instance.count);
  ej.writePath(json, const ['meta', 'info', 'user_name'], instance.userName);
  return json;
}

mixin PathModelSerializer {
  Map<String, dynamic> toJson() {
    return pathModelToJson(this as PathModel);
  }
}

List<EasyIssue> pathModelValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  {
    final v = (json['meta'] as Map?)?['count'];
    if (v == null) {
      issues.add(
        EasyIssue(
          path: 'meta.count',
          code: 'missing_required',
          message: 'Missing required field.',
        ),
      );
    }
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'meta.count',
            code: 'type_mismatch',
            message: 'Expected int.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  {
    final v = ((json['meta'] as Map?)?['info'] as Map?)?['user_name'];
    if (v == null) {
      issues.add(
        EasyIssue(
          path: 'meta.info.user_name',
          code: 'missing_required',
          message: 'Missing required field.',
        ),
      );
    }
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'meta.info.user_name',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  return issues;
}

PathModel pathModelFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in pathModelValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => PathModel(
    count: (() {
      final v = (json['meta'] as Map?)?['count'];
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return p;
      }
      return 0;
    })(),
    userName: (() {
      final v = ((json['meta'] as Map?)?['info'] as Map?)?['user_name'];
      return (v is String) ? v : '';
    })(),
  ))(_report);
}

class PathModelJson {
  const PathModelJson();

  static PathModel fromJson(Map<String, dynamic> json) {
    return pathModelFromJson(json);
  }

  static PathModel fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return pathModelFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return pathModelValidate(json);
  }
}

List<PathModel> pathModelFromJsonList(List<dynamic> json) =>
    json.map((e) => pathModelFromJson(e as Map<String, dynamic>)).toList();

List<PathModel> pathModelFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => pathModelFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> pathModelToJsonList(List<PathModel> items) =>
    items.map((e) => pathModelToJson(e)).toList();

InheritedModel inheritedModelFromJson(Map<String, dynamic> json) {
  return InheritedModel(
    baseId: (json['base_id'] as String?) ?? '',
    baseName: (json['custom_base_name'] as String?) ?? '',
    childValue: (json['child_value'] as int?) ?? 0,
  );
}

Map<String, dynamic> inheritedModelToJson(InheritedModel instance) {
  return <String, dynamic>{
    'base_id': instance.baseId,
    'custom_base_name': instance.baseName,
    'child_value': instance.childValue,
  };
}

mixin InheritedModelSerializer {
  Map<String, dynamic> toJson() {
    return inheritedModelToJson(this as InheritedModel);
  }
}

List<EasyIssue> inheritedModelValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('base_id')) {
    issues.add(
      EasyIssue(
        path: 'base_id',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('base_id') && json['base_id'] == null) {
    issues.add(
      EasyIssue(
        path: 'base_id',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('base_id')) {
    final v = json['base_id'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'base_id',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  if (!json.containsKey('custom_base_name')) {
    issues.add(
      EasyIssue(
        path: 'custom_base_name',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('custom_base_name') &&
      json['custom_base_name'] == null) {
    issues.add(
      EasyIssue(
        path: 'custom_base_name',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('custom_base_name')) {
    final v = json['custom_base_name'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'custom_base_name',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  if (!json.containsKey('child_value')) {
    issues.add(
      EasyIssue(
        path: 'child_value',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('child_value') && json['child_value'] == null) {
    issues.add(
      EasyIssue(
        path: 'child_value',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('child_value')) {
    final v = json['child_value'];
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'child_value',
            code: 'type_mismatch',
            message: 'Expected int.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  return issues;
}

InheritedModel inheritedModelFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in inheritedModelValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => InheritedModel(
    baseId: (() {
      final v = json['base_id'];
      return (v is String) ? v : '';
    })(),
    baseName: (() {
      final v = json['custom_base_name'];
      return (v is String) ? v : '';
    })(),
    childValue: (() {
      final v = json['child_value'];
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return p;
      }
      return 0;
    })(),
  ))(_report);
}

class InheritedModelJson {
  const InheritedModelJson();

  static InheritedModel fromJson(Map<String, dynamic> json) {
    return inheritedModelFromJson(json);
  }

  static InheritedModel fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return inheritedModelFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return inheritedModelValidate(json);
  }
}

List<InheritedModel> inheritedModelFromJsonList(List<dynamic> json) =>
    json.map((e) => inheritedModelFromJson(e as Map<String, dynamic>)).toList();

List<InheritedModel> inheritedModelFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => inheritedModelFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> inheritedModelToJsonList(
  List<InheritedModel> items,
) => items.map((e) => inheritedModelToJson(e)).toList();

ReadOnlyModel readOnlyModelFromJson(Map<String, dynamic> json) {
  return ReadOnlyModel(
    id: (json['id'] as int?) ?? 0,
    name: (json['name'] as String?) ?? '',
  );
}

List<EasyIssue> readOnlyModelValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('id')) {
    issues.add(
      EasyIssue(
        path: 'id',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('id') && json['id'] == null) {
    issues.add(
      EasyIssue(
        path: 'id',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('id')) {
    final v = json['id'];
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'id',
            code: 'type_mismatch',
            message: 'Expected int.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  if (!json.containsKey('name')) {
    issues.add(
      EasyIssue(
        path: 'name',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('name') && json['name'] == null) {
    issues.add(
      EasyIssue(
        path: 'name',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('name')) {
    final v = json['name'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'name',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  return issues;
}

ReadOnlyModel readOnlyModelFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in readOnlyModelValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => ReadOnlyModel(
    id: (() {
      final v = json['id'];
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return p;
      }
      return 0;
    })(),
    name: (() {
      final v = json['name'];
      return (v is String) ? v : '';
    })(),
  ))(_report);
}

class ReadOnlyModelJson {
  const ReadOnlyModelJson();

  static ReadOnlyModel fromJson(Map<String, dynamic> json) {
    return readOnlyModelFromJson(json);
  }

  static ReadOnlyModel fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return readOnlyModelFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return readOnlyModelValidate(json);
  }
}

List<ReadOnlyModel> readOnlyModelFromJsonList(List<dynamic> json) =>
    json.map((e) => readOnlyModelFromJson(e as Map<String, dynamic>)).toList();

List<ReadOnlyModel> readOnlyModelFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => readOnlyModelFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

Map<String, dynamic> writeOnlyModelToJson(WriteOnlyModel instance) {
  return <String, dynamic>{'id': instance.id, 'name': instance.name};
}

mixin WriteOnlyModelSerializer {
  Map<String, dynamic> toJson() {
    return writeOnlyModelToJson(this as WriteOnlyModel);
  }
}

List<Map<String, dynamic>> writeOnlyModelToJsonList(
  List<WriteOnlyModel> items,
) => items.map((e) => writeOnlyModelToJson(e)).toList();

DocumentModel documentModelFromJson(Map<String, dynamic> json) {
  return DocumentModel(
    fileData: base64Decode(json['fileData'] as String),
    optionalData: (json['optionalData'] as String?) != null
        ? base64Decode(json['optionalData'] as String)
        : null,
  );
}

Map<String, dynamic> documentModelToJson(DocumentModel instance) {
  return <String, dynamic>{
    'fileData': base64Encode(instance.fileData),
    if (instance.optionalData != null)
      'optionalData': (instance.optionalData != null
          ? base64Encode(instance.optionalData!)
          : null),
  };
}

mixin DocumentModelSerializer {
  Map<String, dynamic> toJson() {
    return documentModelToJson(this as DocumentModel);
  }
}

List<EasyIssue> documentModelValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('fileData')) {
    issues.add(
      EasyIssue(
        path: 'fileData',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('fileData') && json['fileData'] == null) {
    issues.add(
      EasyIssue(
        path: 'fileData',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('fileData')) {
    final v = json['fileData'];
    if (v is! String) {
      issues.add(
        EasyIssue(
          path: 'fileData',
          code: 'type_mismatch',
          message: 'Expected String (Base64).',
        ),
      );
    } else {
      try {
        base64Decode(v);
      } catch (_) {
        issues.add(
          EasyIssue(
            path: 'fileData',
            code: 'invalid_base64',
            message: 'Invalid Base64 string.',
          ),
        );
      }
    }
  }
  if (json.containsKey('optionalData')) {
    final v = json['optionalData'];
    if (v is! String) {
      issues.add(
        EasyIssue(
          path: 'optionalData',
          code: 'type_mismatch',
          message: 'Expected String (Base64).',
        ),
      );
    } else {
      try {
        base64Decode(v);
      } catch (_) {
        issues.add(
          EasyIssue(
            path: 'optionalData',
            code: 'invalid_base64',
            message: 'Invalid Base64 string.',
          ),
        );
      }
    }
  }
  return issues;
}

DocumentModel documentModelFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in documentModelValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => DocumentModel(
    fileData: (() {
      final v = json['fileData'];
      if (v == null) return Uint8List(0);
      if (v is String) {
        try {
          return base64Decode(v);
        } catch (_) {
          onIssue?.call(
            EasyIssue(
              path: 'fileData',
              code: 'invalid_base64',
              message: 'Invalid Base64 string.',
            ),
          );
          return Uint8List(0);
        }
      }
      onIssue?.call(
        EasyIssue(
          path: 'fileData',
          code: 'type_mismatch',
          message: 'Expected String (Base64).',
        ),
      );
      return Uint8List(0);
    })(),
    optionalData: (() {
      final v = json['optionalData'];
      if (v == null) return null;
      if (v is String) {
        try {
          return base64Decode(v);
        } catch (_) {
          onIssue?.call(
            EasyIssue(
              path: 'optionalData',
              code: 'invalid_base64',
              message: 'Invalid Base64 string.',
            ),
          );
          return null;
        }
      }
      onIssue?.call(
        EasyIssue(
          path: 'optionalData',
          code: 'type_mismatch',
          message: 'Expected String (Base64).',
        ),
      );
      return null;
    })(),
  ))(_report);
}

class DocumentModelJson {
  const DocumentModelJson();

  static DocumentModel fromJson(Map<String, dynamic> json) {
    return documentModelFromJson(json);
  }

  static DocumentModel fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return documentModelFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return documentModelValidate(json);
  }
}

List<DocumentModel> documentModelFromJsonList(List<dynamic> json) =>
    json.map((e) => documentModelFromJson(e as Map<String, dynamic>)).toList();

List<DocumentModel> documentModelFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => documentModelFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> documentModelToJsonList(List<DocumentModel> items) =>
    items.map((e) => documentModelToJson(e)).toList();

NativeTypesModel nativeTypesModelFromJson(Map<String, dynamic> json) {
  return NativeTypesModel(
    homepage: Uri.parse(json['homepage'] as String),
    repository: (json['repository'] as String?) != null
        ? Uri.parse(json['repository'] as String)
        : null,
    timeout: Duration(microseconds: (json['timeout'] as num).toInt()),
    extra: (json['extra'] as num?) != null
        ? Duration(microseconds: (json['extra'] as num).toInt())
        : null,
    bigId: BigInt.parse(json['bigId'] as String),
    bigOptional: (json['bigOptional'] as String?) != null
        ? BigInt.parse(json['bigOptional'] as String)
        : null,
  );
}

Map<String, dynamic> nativeTypesModelToJson(NativeTypesModel instance) {
  return <String, dynamic>{
    'homepage': instance.homepage.toString(),
    if (instance.repository != null)
      'repository': instance.repository?.toString(),
    'timeout': instance.timeout.inMicroseconds,
    if (instance.extra != null) 'extra': instance.extra?.inMicroseconds,
    'bigId': instance.bigId.toString(),
    if (instance.bigOptional != null)
      'bigOptional': instance.bigOptional?.toString(),
  };
}

mixin NativeTypesModelSerializer {
  Map<String, dynamic> toJson() {
    return nativeTypesModelToJson(this as NativeTypesModel);
  }
}

List<EasyIssue> nativeTypesModelValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('homepage')) {
    issues.add(
      EasyIssue(
        path: 'homepage',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('homepage') && json['homepage'] == null) {
    issues.add(
      EasyIssue(
        path: 'homepage',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('homepage')) {
    final v = json['homepage'];
    if (v is! String) {
      issues.add(
        EasyIssue(
          path: 'homepage',
          code: 'type_mismatch',
          message: 'Expected String (URI).',
        ),
      );
    } else if (Uri.tryParse(v) == null) {
      issues.add(
        EasyIssue(
          path: 'homepage',
          code: 'invalid_uri',
          message: 'Invalid URI.',
        ),
      );
    }
  }
  if (json.containsKey('repository')) {
    final v = json['repository'];
    if (v is! String) {
      issues.add(
        EasyIssue(
          path: 'repository',
          code: 'type_mismatch',
          message: 'Expected String (URI).',
        ),
      );
    } else if (Uri.tryParse(v) == null) {
      issues.add(
        EasyIssue(
          path: 'repository',
          code: 'invalid_uri',
          message: 'Invalid URI.',
        ),
      );
    }
  }
  if (!json.containsKey('timeout')) {
    issues.add(
      EasyIssue(
        path: 'timeout',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('timeout') && json['timeout'] == null) {
    issues.add(
      EasyIssue(
        path: 'timeout',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('timeout')) {
    final v = json['timeout'];
    if (v is! num && !(v is String && int.tryParse(v) != null)) {
      issues.add(
        EasyIssue(
          path: 'timeout',
          code: 'type_mismatch',
          message: 'Expected number of microseconds.',
        ),
      );
    }
  }
  if (json.containsKey('extra')) {
    final v = json['extra'];
    if (v is! num && !(v is String && int.tryParse(v) != null)) {
      issues.add(
        EasyIssue(
          path: 'extra',
          code: 'type_mismatch',
          message: 'Expected number of microseconds.',
        ),
      );
    }
  }
  if (!json.containsKey('bigId')) {
    issues.add(
      EasyIssue(
        path: 'bigId',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('bigId') && json['bigId'] == null) {
    issues.add(
      EasyIssue(
        path: 'bigId',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('bigId')) {
    final v = json['bigId'];
    if (v is String) {
      if (BigInt.tryParse(v) == null) {
        issues.add(
          EasyIssue(
            path: 'bigId',
            code: 'invalid_bigint',
            message: 'Invalid integer string.',
          ),
        );
      }
    } else if (v is! num) {
      issues.add(
        EasyIssue(
          path: 'bigId',
          code: 'type_mismatch',
          message: 'Expected String (integer) or int.',
        ),
      );
    }
  }
  if (json.containsKey('bigOptional')) {
    final v = json['bigOptional'];
    if (v is String) {
      if (BigInt.tryParse(v) == null) {
        issues.add(
          EasyIssue(
            path: 'bigOptional',
            code: 'invalid_bigint',
            message: 'Invalid integer string.',
          ),
        );
      }
    } else if (v is! num) {
      issues.add(
        EasyIssue(
          path: 'bigOptional',
          code: 'type_mismatch',
          message: 'Expected String (integer) or int.',
        ),
      );
    }
  }
  return issues;
}

NativeTypesModel nativeTypesModelFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in nativeTypesModelValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => NativeTypesModel(
    homepage: (() {
      final v = json['homepage'];
      if (v == null) return Uri();
      if (v is String) {
        final u = Uri.tryParse(v);
        if (u != null) return u;
        onIssue?.call(
          EasyIssue(
            path: 'homepage',
            code: 'invalid_uri',
            message: 'Invalid URI.',
          ),
        );
        return Uri();
      }
      onIssue?.call(
        EasyIssue(
          path: 'homepage',
          code: 'type_mismatch',
          message: 'Expected String (URI).',
        ),
      );
      return Uri();
    })(),
    repository: (() {
      final v = json['repository'];
      if (v == null) return null;
      if (v is String) {
        final u = Uri.tryParse(v);
        if (u != null) return u;
        onIssue?.call(
          EasyIssue(
            path: 'repository',
            code: 'invalid_uri',
            message: 'Invalid URI.',
          ),
        );
        return null;
      }
      onIssue?.call(
        EasyIssue(
          path: 'repository',
          code: 'type_mismatch',
          message: 'Expected String (URI).',
        ),
      );
      return null;
    })(),
    timeout: (() {
      final v = json['timeout'];
      if (v == null) return Duration.zero;
      if (v is num) return Duration(microseconds: v.toInt());
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return Duration(microseconds: p);
      }
      onIssue?.call(
        EasyIssue(
          path: 'timeout',
          code: 'type_mismatch',
          message: 'Expected number of microseconds.',
        ),
      );
      return Duration.zero;
    })(),
    extra: (() {
      final v = json['extra'];
      if (v == null) return null;
      if (v is num) return Duration(microseconds: v.toInt());
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return Duration(microseconds: p);
      }
      onIssue?.call(
        EasyIssue(
          path: 'extra',
          code: 'type_mismatch',
          message: 'Expected number of microseconds.',
        ),
      );
      return null;
    })(),
    bigId: (() {
      final v = json['bigId'];
      if (v == null) return BigInt.zero;
      if (v is String) {
        final b = BigInt.tryParse(v);
        if (b != null) return b;
        onIssue?.call(
          EasyIssue(
            path: 'bigId',
            code: 'invalid_bigint',
            message: 'Invalid integer string.',
          ),
        );
        return BigInt.zero;
      }
      if (v is int) return BigInt.from(v);
      if (v is num) return BigInt.from(v.toInt());
      onIssue?.call(
        EasyIssue(
          path: 'bigId',
          code: 'type_mismatch',
          message: 'Expected String (integer) or int.',
        ),
      );
      return BigInt.zero;
    })(),
    bigOptional: (() {
      final v = json['bigOptional'];
      if (v == null) return null;
      if (v is String) {
        final b = BigInt.tryParse(v);
        if (b != null) return b;
        onIssue?.call(
          EasyIssue(
            path: 'bigOptional',
            code: 'invalid_bigint',
            message: 'Invalid integer string.',
          ),
        );
        return null;
      }
      if (v is int) return BigInt.from(v);
      if (v is num) return BigInt.from(v.toInt());
      onIssue?.call(
        EasyIssue(
          path: 'bigOptional',
          code: 'type_mismatch',
          message: 'Expected String (integer) or int.',
        ),
      );
      return null;
    })(),
  ))(_report);
}

class NativeTypesModelJson {
  const NativeTypesModelJson();

  static NativeTypesModel fromJson(Map<String, dynamic> json) {
    return nativeTypesModelFromJson(json);
  }

  static NativeTypesModel fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return nativeTypesModelFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return nativeTypesModelValidate(json);
  }
}

List<NativeTypesModel> nativeTypesModelFromJsonList(List<dynamic> json) => json
    .map((e) => nativeTypesModelFromJson(e as Map<String, dynamic>))
    .toList();

List<NativeTypesModel> nativeTypesModelFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => nativeTypesModelFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> nativeTypesModelToJsonList(
  List<NativeTypesModel> items,
) => items.map((e) => nativeTypesModelToJson(e)).toList();

Post postFromJson(Map<String, dynamic> json) {
  final d = json['type'];
  switch (d) {
    case 'text':
      return TextPost.fromJson(json);
    case 'video':
      return VideoPost.fromJson(json);
    default:
      return UnknownPost.fromJson(json);
  }
}

Map<String, dynamic> postToJson(Post instance) {
  return (instance as dynamic).toJson() as Map<String, dynamic>;
}

mixin PostSerializer {
  Map<String, dynamic> toJson() {
    return postToJson(this as Post);
  }
}

List<EasyIssue> postValidate(Map<String, dynamic> json) {
  final d = json['type'];
  switch (d) {
    case 'text':
      return textPostValidate(json);
    case 'video':
      return videoPostValidate(json);
    default:
      final issues = [
        EasyIssue(
          path: 'type',
          code: 'unknown_union_type',
          message: 'Unknown type: \$d',
        ),
      ];
      issues.addAll(unknownPostValidate(json));
      return issues;
  }
}

Post postFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in postValidate(json)) _report(i);
  }
  final d = json['type'];
  switch (d) {
    case 'text':
      return textPostFromJsonSafe(json, onIssue: _report, runValidate: false);
    case 'video':
      return videoPostFromJsonSafe(json, onIssue: _report, runValidate: false);
    default:
      return unknownPostFromJsonSafe(
        json,
        onIssue: _report,
        runValidate: false,
      );
  }
}

class PostJson {
  const PostJson();

  static Post fromJson(Map<String, dynamic> json) {
    return postFromJson(json);
  }

  static Post fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return postFromJsonSafe(json, onIssue: onIssue, runValidate: runValidate);
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return postValidate(json);
  }
}

List<Post> postFromJsonList(List<dynamic> json) =>
    json.map((e) => postFromJson(e as Map<String, dynamic>)).toList();

List<Post> postFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => postFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> postToJsonList(List<Post> items) =>
    items.map((e) => postToJson(e)).toList();

TextPost textPostFromJson(Map<String, dynamic> json) {
  return TextPost(
    author: (json['author'] as String?) ?? '',
    content: (json['content'] as String?) ?? '',
  );
}

Map<String, dynamic> textPostToJson(TextPost instance) {
  return <String, dynamic>{
    'author': instance.author,
    'content': instance.content,
  };
}

mixin TextPostSerializer {
  Map<String, dynamic> toJson() {
    return textPostToJson(this as TextPost);
  }
}

List<EasyIssue> textPostValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('author')) {
    issues.add(
      EasyIssue(
        path: 'author',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('author') && json['author'] == null) {
    issues.add(
      EasyIssue(
        path: 'author',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('author')) {
    final v = json['author'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'author',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  if (!json.containsKey('content')) {
    issues.add(
      EasyIssue(
        path: 'content',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('content') && json['content'] == null) {
    issues.add(
      EasyIssue(
        path: 'content',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('content')) {
    final v = json['content'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'content',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  return issues;
}

TextPost textPostFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in textPostValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => TextPost(
    author: (() {
      final v = json['author'];
      return (v is String) ? v : '';
    })(),
    content: (() {
      final v = json['content'];
      return (v is String) ? v : '';
    })(),
  ))(_report);
}

class TextPostJson {
  const TextPostJson();

  static TextPost fromJson(Map<String, dynamic> json) {
    return textPostFromJson(json);
  }

  static TextPost fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return textPostFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return textPostValidate(json);
  }
}

List<TextPost> textPostFromJsonList(List<dynamic> json) =>
    json.map((e) => textPostFromJson(e as Map<String, dynamic>)).toList();

List<TextPost> textPostFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => textPostFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> textPostToJsonList(List<TextPost> items) =>
    items.map((e) => textPostToJson(e)).toList();

VideoPost videoPostFromJson(Map<String, dynamic> json) {
  return VideoPost(
    author: (json['author'] as String?) ?? '',
    videoUrl: (json['videoUrl'] as String?) ?? '',
  );
}

Map<String, dynamic> videoPostToJson(VideoPost instance) {
  return <String, dynamic>{
    'author': instance.author,
    'videoUrl': instance.videoUrl,
  };
}

mixin VideoPostSerializer {
  Map<String, dynamic> toJson() {
    return videoPostToJson(this as VideoPost);
  }
}

List<EasyIssue> videoPostValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('author')) {
    issues.add(
      EasyIssue(
        path: 'author',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('author') && json['author'] == null) {
    issues.add(
      EasyIssue(
        path: 'author',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('author')) {
    final v = json['author'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'author',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  if (!json.containsKey('videoUrl')) {
    issues.add(
      EasyIssue(
        path: 'videoUrl',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('videoUrl') && json['videoUrl'] == null) {
    issues.add(
      EasyIssue(
        path: 'videoUrl',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('videoUrl')) {
    final v = json['videoUrl'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'videoUrl',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  return issues;
}

VideoPost videoPostFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in videoPostValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => VideoPost(
    author: (() {
      final v = json['author'];
      return (v is String) ? v : '';
    })(),
    videoUrl: (() {
      final v = json['videoUrl'];
      return (v is String) ? v : '';
    })(),
  ))(_report);
}

class VideoPostJson {
  const VideoPostJson();

  static VideoPost fromJson(Map<String, dynamic> json) {
    return videoPostFromJson(json);
  }

  static VideoPost fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return videoPostFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return videoPostValidate(json);
  }
}

List<VideoPost> videoPostFromJsonList(List<dynamic> json) =>
    json.map((e) => videoPostFromJson(e as Map<String, dynamic>)).toList();

List<VideoPost> videoPostFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => videoPostFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> videoPostToJsonList(List<VideoPost> items) =>
    items.map((e) => videoPostToJson(e)).toList();

UnknownPost unknownPostFromJson(Map<String, dynamic> json) {
  return UnknownPost();
}

Map<String, dynamic> unknownPostToJson(UnknownPost instance) {
  return <String, dynamic>{};
}

mixin UnknownPostSerializer {
  Map<String, dynamic> toJson() {
    return unknownPostToJson(this as UnknownPost);
  }
}

List<EasyIssue> unknownPostValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  return issues;
}

UnknownPost unknownPostFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in unknownPostValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => UnknownPost())(_report);
}

class UnknownPostJson {
  const UnknownPostJson();

  static UnknownPost fromJson(Map<String, dynamic> json) {
    return unknownPostFromJson(json);
  }

  static UnknownPost fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return unknownPostFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return unknownPostValidate(json);
  }
}

List<UnknownPost> unknownPostFromJsonList(List<dynamic> json) =>
    json.map((e) => unknownPostFromJson(e as Map<String, dynamic>)).toList();

List<UnknownPost> unknownPostFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => unknownPostFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> unknownPostToJsonList(List<UnknownPost> items) =>
    items.map((e) => unknownPostToJson(e)).toList();

Feed feedFromJson(Map<String, dynamic> json) {
  return Feed(
    posts:
        ((json['posts'] as List?)?.asMap().entries.map<Post>((entry) {
          final i = entry.key;
          final e = entry.value;
          return postFromJson(Map<String, dynamic>.from(e as Map));
        }).toList()) ??
        const <Post>[],
  );
}

Map<String, dynamic> feedToJson(Feed instance) {
  return <String, dynamic>{
    'posts': instance.posts.map((e) => e.toJson()).toList(),
  };
}

mixin FeedSerializer {
  Map<String, dynamic> toJson() {
    return feedToJson(this as Feed);
  }
}

List<EasyIssue> feedValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('posts')) {
    issues.add(
      EasyIssue(
        path: 'posts',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('posts') && json['posts'] == null) {
    issues.add(
      EasyIssue(
        path: 'posts',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('posts')) {
    final v = json['posts'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'posts',
          code: 'type_mismatch',
          message: 'Expected List.',
        ),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'posts' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! Map) {
            issues.add(
              EasyIssue(
                path: 'posts' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected Map for Post.',
              ),
            );
          } else {
            final child = postValidate(Map<String, dynamic>.from(e as Map));
            for (final ci in child) {
              issues.add(
                EasyIssue(
                  path: 'posts' + '[' + i.toString() + '].' + ci.path,
                  code: ci.code,
                  message: ci.message,
                ),
              );
            }
          }
        }
      }
    }
  }
  return issues;
}

Feed feedFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in feedValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Feed(
    posts: (() {
      final _v = json['posts'];
      if (_v is! List) return const <Post>[];
      final _list = _v;
      return _list.asMap().entries.map<Post>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final _v = entry.value;
          if (_v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'posts' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return postFromJsonSafe(
              const <String, dynamic>{},
              onIssue: (i) => onIssue?.call(
                EasyIssue(
                  path:
                      'posts' + '[' + entry.key.toString() + ']' + '.' + i.path,
                  code: i.code,
                  message: i.message,
                ),
              ),
              runValidate: false,
            );
          }
          if (_v is Map) {
            return postFromJsonSafe(
              Map<String, dynamic>.from(_v as Map),
              onIssue: (i) => onIssue?.call(
                EasyIssue(
                  path:
                      'posts' + '[' + entry.key.toString() + ']' + '.' + i.path,
                  code: i.code,
                  message: i.message,
                ),
              ),
              runValidate: false,
            );
          }
          onIssue?.call(
            EasyIssue(
              path: 'posts' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Expected Map for Post.',
            ),
          );
          return postFromJsonSafe(
            const <String, dynamic>{},
            onIssue: (i) => onIssue?.call(
              EasyIssue(
                path: "'posts' + '[' + entry.key.toString() + ']'." + i.path,
                code: i.code,
                message: i.message,
              ),
            ),
            runValidate: false,
          );
        })();
      }).toList();
    })(),
  ))(_report);
}

class FeedJson {
  const FeedJson();

  static Feed fromJson(Map<String, dynamic> json) {
    return feedFromJson(json);
  }

  static Feed fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return feedFromJsonSafe(json, onIssue: onIssue, runValidate: runValidate);
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return feedValidate(json);
  }
}

List<Feed> feedFromJsonList(List<dynamic> json) =>
    json.map((e) => feedFromJson(e as Map<String, dynamic>)).toList();

List<Feed> feedFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => feedFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> feedToJsonList(List<Feed> items) =>
    items.map((e) => feedToJson(e)).toList();

ApiResponse<T> apiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return ApiResponse<T>(
    data: fromJsonT(json['data']),
    statusCode: (json['statusCode'] as int?) ?? 0,
    message: json['message'] as String?,
  );
}

Map<String, dynamic> apiResponseToJson<T>(
  ApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) {
  return <String, dynamic>{
    'data': toJsonT(instance.data),
    'statusCode': instance.statusCode,
    if (instance.message != null) 'message': instance.message,
  };
}

mixin ApiResponseSerializer<T> {
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return apiResponseToJson<T>(this as ApiResponse<T>, toJsonT);
  }
}

List<EasyIssue> apiResponseValidate<T>(
  Map<String, dynamic> json, {
  List<EasyIssue> Function(Object? json)? validateT,
}) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('data')) {
    issues.add(
      EasyIssue(
        path: 'data',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('data')) {
    final v = json['data'];
    if (v != null) {
      if (validateT != null) {
        for (final n0 in validateT(v)) {
          issues.add(
            EasyIssue(
              path: 'data' + n0.path,
              code: n0.code,
              message: n0.message,
            ),
          );
        }
      }
    }
  }
  if (!json.containsKey('statusCode')) {
    issues.add(
      EasyIssue(
        path: 'statusCode',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('statusCode') && json['statusCode'] == null) {
    issues.add(
      EasyIssue(
        path: 'statusCode',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('statusCode')) {
    final v = json['statusCode'];
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'statusCode',
            code: 'type_mismatch',
            message: 'Expected int.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  if (json.containsKey('message')) {
    final v = json['message'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'message',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  return issues;
}

ApiResponse<T> apiResponseFromJsonSafe<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in apiResponseValidate<T>(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => ApiResponse<T>(
    data: fromJsonT(json['data']),
    statusCode: (() {
      final v = json['statusCode'];
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return p;
      }
      return 0;
    })(),
    message: (() {
      final v = json['message'];
      return (v is String) ? v : null;
    })(),
  ))(_report);
}

class ApiResponseJson {
  const ApiResponseJson();

  static ApiResponse<T> fromJson<T>(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return apiResponseFromJson<T>(json, fromJsonT);
  }

  static ApiResponse<T> fromJsonSafe<T>(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return apiResponseFromJsonSafe<T>(
      json,
      fromJsonT,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return apiResponseValidate(json);
  }
}

List<ApiResponse<T>> apiResponseFromJsonList<T>(
  List<dynamic> json,
  T Function(Object? json) fromJsonT,
) => json
    .map((e) => apiResponseFromJson<T>(e as Map<String, dynamic>, fromJsonT))
    .toList();

List<ApiResponse<T>> apiResponseFromJsonSafeList<T>(
  List<dynamic> json,
  T Function(Object? json) fromJsonT, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => apiResponseFromJsonSafe<T>(
        entry.value as Map<String, dynamic>,
        fromJsonT,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> apiResponseToJsonList<T>(
  List<ApiResponse<T>> items,
  Object? Function(T value) toJsonT,
) => items.map((e) => apiResponseToJson<T>(e, toJsonT)).toList();

PageResponse<T> pageResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return PageResponse<T>(
    items:
        ((json['items'] as List?)?.asMap().entries.map<T>((entry) {
          final i = entry.key;
          final e = entry.value;
          return fromJsonT(e);
        }).toList()) ??
        <T>[],
    total: (json['total'] as int?) ?? 0,
    highlight: json['highlight'] == null ? null : fromJsonT(json['highlight']),
  );
}

Map<String, dynamic> pageResponseToJson<T>(
  PageResponse<T> instance,
  Object? Function(T value) toJsonT,
) {
  return <String, dynamic>{
    'items': instance.items.map((e) => toJsonT(e)).toList(),
    'total': instance.total,
    if (instance.highlight != null)
      'highlight': (instance.highlight == null
          ? null
          : toJsonT(instance.highlight as T)),
  };
}

mixin PageResponseSerializer<T> {
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return pageResponseToJson<T>(this as PageResponse<T>, toJsonT);
  }
}

List<EasyIssue> pageResponseValidate<T>(
  Map<String, dynamic> json, {
  List<EasyIssue> Function(Object? json)? validateT,
}) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('items')) {
    issues.add(
      EasyIssue(
        path: 'items',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('items') && json['items'] == null) {
    issues.add(
      EasyIssue(
        path: 'items',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('items')) {
    final v = json['items'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'items',
          code: 'type_mismatch',
          message: 'Expected List.',
        ),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'items' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (validateT != null) {
            for (final n0 in validateT(e)) {
              issues.add(
                EasyIssue(
                  path: 'items' + '[' + i.toString() + ']' + n0.path,
                  code: n0.code,
                  message: n0.message,
                ),
              );
            }
          }
        }
      }
    }
  }
  if (!json.containsKey('total')) {
    issues.add(
      EasyIssue(
        path: 'total',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('total') && json['total'] == null) {
    issues.add(
      EasyIssue(
        path: 'total',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('total')) {
    final v = json['total'];
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'total',
            code: 'type_mismatch',
            message: 'Expected int.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  if (json.containsKey('highlight')) {
    final v = json['highlight'];
    if (v != null) {
      if (validateT != null) {
        for (final n0 in validateT(v)) {
          issues.add(
            EasyIssue(
              path: 'highlight' + n0.path,
              code: n0.code,
              message: n0.message,
            ),
          );
        }
      }
    }
  }
  return issues;
}

PageResponse<T> pageResponseFromJsonSafe<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in pageResponseValidate<T>(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => PageResponse<T>(
    items: (() {
      final _v = json['items'];
      if (_v is! List) return <T>[];
      final _list = _v;
      return _list.asMap().entries.map<T>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return fromJsonT(entry.value);
      }).toList();
    })(),
    total: (() {
      final v = json['total'];
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return p;
      }
      return 0;
    })(),
    highlight: (() {
      final v = json['highlight'];
      if (v == null) return null;
      try {
        return fromJsonT(v);
      } catch (_) {
        onIssue?.call(
          EasyIssue(
            path: 'highlight',
            code: 'type_mismatch',
            message: 'Could not convert value to T.',
          ),
        );
        return null;
      }
    })(),
  ))(_report);
}

class PageResponseJson {
  const PageResponseJson();

  static PageResponse<T> fromJson<T>(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return pageResponseFromJson<T>(json, fromJsonT);
  }

  static PageResponse<T> fromJsonSafe<T>(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return pageResponseFromJsonSafe<T>(
      json,
      fromJsonT,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return pageResponseValidate(json);
  }
}

List<PageResponse<T>> pageResponseFromJsonList<T>(
  List<dynamic> json,
  T Function(Object? json) fromJsonT,
) => json
    .map((e) => pageResponseFromJson<T>(e as Map<String, dynamic>, fromJsonT))
    .toList();

List<PageResponse<T>> pageResponseFromJsonSafeList<T>(
  List<dynamic> json,
  T Function(Object? json) fromJsonT, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => pageResponseFromJsonSafe<T>(
        entry.value as Map<String, dynamic>,
        fromJsonT,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> pageResponseToJsonList<T>(
  List<PageResponse<T>> items,
  Object? Function(T value) toJsonT,
) => items.map((e) => pageResponseToJson<T>(e, toJsonT)).toList();

Pair<A, B> pairFromJson<A, B extends Object>(
  Map<String, dynamic> json,
  A Function(Object? json) fromJsonA,
  B Function(Object? json) fromJsonB,
) {
  return Pair<A, B>(
    first: fromJsonA(json['first']),
    second: fromJsonB(json['second']),
  );
}

Map<String, dynamic> pairToJson<A, B extends Object>(
  Pair<A, B> instance,
  Object? Function(A value) toJsonA,
  Object? Function(B value) toJsonB,
) {
  return <String, dynamic>{
    'first': toJsonA(instance.first),
    'second': toJsonB(instance.second),
  };
}

mixin PairSerializer<A, B extends Object> {
  Map<String, dynamic> toJson(
    Object? Function(A value) toJsonA,
    Object? Function(B value) toJsonB,
  ) {
    return pairToJson<A, B>(this as Pair<A, B>, toJsonA, toJsonB);
  }
}

List<EasyIssue> pairValidate<A, B extends Object>(
  Map<String, dynamic> json, {
  List<EasyIssue> Function(Object? json)? validateA,
  List<EasyIssue> Function(Object? json)? validateB,
}) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('first')) {
    issues.add(
      EasyIssue(
        path: 'first',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('first')) {
    final v = json['first'];
    if (v != null) {
      if (validateA != null) {
        for (final n0 in validateA(v)) {
          issues.add(
            EasyIssue(
              path: 'first' + n0.path,
              code: n0.code,
              message: n0.message,
            ),
          );
        }
      }
    }
  }
  if (!json.containsKey('second')) {
    issues.add(
      EasyIssue(
        path: 'second',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('second')) {
    final v = json['second'];
    if (v != null) {
      if (validateB != null) {
        for (final n0 in validateB(v)) {
          issues.add(
            EasyIssue(
              path: 'second' + n0.path,
              code: n0.code,
              message: n0.message,
            ),
          );
        }
      }
    }
  }
  return issues;
}

Pair<A, B> pairFromJsonSafe<A, B extends Object>(
  Map<String, dynamic> json,
  A Function(Object? json) fromJsonA,
  B Function(Object? json) fromJsonB, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in pairValidate<A, B>(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Pair<A, B>(
    first: fromJsonA(json['first']),
    second: fromJsonB(json['second']),
  ))(_report);
}

class PairJson {
  const PairJson();

  static Pair<A, B> fromJson<A, B extends Object>(
    Map<String, dynamic> json,
    A Function(Object? json) fromJsonA,
    B Function(Object? json) fromJsonB,
  ) {
    return pairFromJson<A, B>(json, fromJsonA, fromJsonB);
  }

  static Pair<A, B> fromJsonSafe<A, B extends Object>(
    Map<String, dynamic> json,
    A Function(Object? json) fromJsonA,
    B Function(Object? json) fromJsonB, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return pairFromJsonSafe<A, B>(
      json,
      fromJsonA,
      fromJsonB,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return pairValidate(json);
  }
}

List<Pair<A, B>> pairFromJsonList<A, B extends Object>(
  List<dynamic> json,
  A Function(Object? json) fromJsonA,
  B Function(Object? json) fromJsonB,
) => json
    .map(
      (e) =>
          pairFromJson<A, B>(e as Map<String, dynamic>, fromJsonA, fromJsonB),
    )
    .toList();

List<Pair<A, B>> pairFromJsonSafeList<A, B extends Object>(
  List<dynamic> json,
  A Function(Object? json) fromJsonA,
  B Function(Object? json) fromJsonB, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => pairFromJsonSafe<A, B>(
        entry.value as Map<String, dynamic>,
        fromJsonA,
        fromJsonB,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> pairToJsonList<A, B extends Object>(
  List<Pair<A, B>> items,
  Object? Function(A value) toJsonA,
  Object? Function(B value) toJsonB,
) => items.map((e) => pairToJson<A, B>(e, toJsonA, toJsonB)).toList();

RangeModel rangeModelFromJson(Map<String, dynamic> json) {
  return RangeModel(score: (json['score'] as num?)?.toDouble() ?? 0.0);
}

Map<String, dynamic> rangeModelToJson(RangeModel instance) {
  return <String, dynamic>{'score': instance.score};
}

mixin RangeModelSerializer {
  Map<String, dynamic> toJson() {
    return rangeModelToJson(this as RangeModel);
  }
}

List<EasyIssue> rangeModelValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('score')) {
    issues.add(
      EasyIssue(
        path: 'score',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('score') && json['score'] == null) {
    issues.add(
      EasyIssue(
        path: 'score',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('score')) {
    final v = json['score'];
    if (v != null) {
      final _n = v is num
          ? v.toDouble()
          : (v is String ? double.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'score',
            code: 'type_mismatch',
            message: 'Expected number.',
          ),
        );
      } else {
        final v = _n;
        if ((v as num) < 0) {
          issues.add(
            EasyIssue(
              path: 'score',
              code: 'min_value',
              message: 'The minimum value is 0.',
            ),
          );
        }
        if ((v as num) > 100) {
          issues.add(
            EasyIssue(
              path: 'score',
              code: 'max_value',
              message: 'The maximum value is 100.',
            ),
          );
        }
      }
    }
  }
  return issues;
}

RangeModel rangeModelFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in rangeModelValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => RangeModel(
    score: (() {
      final v = json['score'];
      if (v is num) return v.toDouble();
      if (v is String) {
        final p = double.tryParse(v);
        if (p != null) return p;
      }
      return 0.0;
    })(),
  ))(_report);
}

class RangeModelJson {
  const RangeModelJson();

  static RangeModel fromJson(Map<String, dynamic> json) {
    return rangeModelFromJson(json);
  }

  static RangeModel fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return rangeModelFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return rangeModelValidate(json);
  }
}

List<RangeModel> rangeModelFromJsonList(List<dynamic> json) =>
    json.map((e) => rangeModelFromJson(e as Map<String, dynamic>)).toList();

List<RangeModel> rangeModelFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => rangeModelFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> rangeModelToJsonList(List<RangeModel> items) =>
    items.map((e) => rangeModelToJson(e)).toList();

StrictUser strictUserFromJson(Map<String, dynamic> json) {
  final issues = strictUserValidate(json);
  if (issues.isNotEmpty) throw EasyValidationException(issues);
  return strictUserFromJsonSafe(json, runValidate: false);
}

Map<String, dynamic> strictUserToJson(StrictUser instance) {
  return <String, dynamic>{
    'name': instance.name,
    'age': instance.age,
    if (instance.email != null) 'email': instance.email,
  };
}

mixin StrictUserSerializer {
  Map<String, dynamic> toJson() {
    return strictUserToJson(this as StrictUser);
  }
}

List<EasyIssue> strictUserValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('name')) {
    issues.add(
      EasyIssue(
        path: 'name',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('name') && json['name'] == null) {
    issues.add(
      EasyIssue(
        path: 'name',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('name')) {
    final v = json['name'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'name',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  if (!json.containsKey('age')) {
    issues.add(
      EasyIssue(
        path: 'age',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('age') && json['age'] == null) {
    issues.add(
      EasyIssue(
        path: 'age',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('age')) {
    final v = json['age'];
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'age',
            code: 'type_mismatch',
            message: 'Expected int.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  if (json.containsKey('email')) {
    final v = json['email'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'email',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {
      if (!RegExp(
        '^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$',
      ).hasMatch(v as String)) {
        issues.add(
          EasyIssue(
            path: 'email',
            code: 'invalid_email',
            message: 'Invalid email.',
          ),
        );
      }
    }
  }
  return issues;
}

StrictUser strictUserFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in strictUserValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => StrictUser(
    name: (() {
      final v = json['name'];
      return (v is String) ? v : '';
    })(),
    age: (() {
      final v = json['age'];
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return p;
      }
      return 0;
    })(),
    email: (() {
      final v = json['email'];
      return (v is String) ? v : null;
    })(),
  ))(_report);
}

class StrictUserJson {
  const StrictUserJson();

  static StrictUser fromJson(Map<String, dynamic> json) {
    return strictUserFromJson(json);
  }

  static StrictUser fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return strictUserFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return strictUserValidate(json);
  }
}

List<StrictUser> strictUserFromJsonList(List<dynamic> json) =>
    json.map((e) => strictUserFromJson(e as Map<String, dynamic>)).toList();

List<StrictUser> strictUserFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => strictUserFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> strictUserToJsonList(List<StrictUser> items) =>
    items.map((e) => strictUserToJson(e)).toList();

StrictOrder strictOrderFromJson(Map<String, dynamic> json) {
  final issues = strictOrderValidate(json);
  if (issues.isNotEmpty) throw EasyValidationException(issues);
  return strictOrderFromJsonSafe(json, runValidate: false);
}

Map<String, dynamic> strictOrderToJson(StrictOrder instance) {
  return <String, dynamic>{
    'id': instance.id,
    'shipping': instance.shipping.toJson(),
    'products': instance.products.map((e) => e.toJson()).toList(),
  };
}

mixin StrictOrderSerializer {
  Map<String, dynamic> toJson() {
    return strictOrderToJson(this as StrictOrder);
  }
}

List<EasyIssue> strictOrderValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('id')) {
    issues.add(
      EasyIssue(
        path: 'id',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('id') && json['id'] == null) {
    issues.add(
      EasyIssue(
        path: 'id',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('id')) {
    final v = json['id'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'id',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  if (!json.containsKey('shipping')) {
    issues.add(
      EasyIssue(
        path: 'shipping',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('shipping') && json['shipping'] == null) {
    issues.add(
      EasyIssue(
        path: 'shipping',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('shipping')) {
    final v = json['shipping'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(
          path: 'shipping',
          code: 'type_mismatch',
          message: 'Expected Map for Address.',
        ),
      );
    } else if (v is Map) {
      final child = addressValidate(Map<String, dynamic>.from(v));
      for (final ci in child) {
        issues.add(
          EasyIssue(
            path: 'shipping' + '.' + ci.path,
            code: ci.code,
            message: ci.message,
          ),
        );
      }
    }
  }
  if (!json.containsKey('products')) {
    issues.add(
      EasyIssue(
        path: 'products',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('products') && json['products'] == null) {
    issues.add(
      EasyIssue(
        path: 'products',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('products')) {
    final v = json['products'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'products',
          code: 'type_mismatch',
          message: 'Expected List.',
        ),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'products' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! Map) {
            issues.add(
              EasyIssue(
                path: 'products' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected Map for Product.',
              ),
            );
          } else {
            final child = productValidate(Map<String, dynamic>.from(e as Map));
            for (final ci in child) {
              issues.add(
                EasyIssue(
                  path: 'products' + '[' + i.toString() + '].' + ci.path,
                  code: ci.code,
                  message: ci.message,
                ),
              );
            }
          }
        }
      }
    }
  }
  return issues;
}

StrictOrder strictOrderFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in strictOrderValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => StrictOrder(
    id: (() {
      final v = json['id'];
      return (v is String) ? v : '';
    })(),
    shipping: (() {
      final _v = json['shipping'];
      if (_v == null)
        return addressFromJsonSafe(
          const <String, dynamic>{},
          onIssue: (i) => onIssue?.call(
            EasyIssue(
              path: 'shipping' + '.' + i.path,
              code: i.code,
              message: i.message,
            ),
          ),
          runValidate: false,
        );
      if (_v is Map) {
        return addressFromJsonSafe(
          Map<String, dynamic>.from(_v as Map),
          onIssue: (i) => onIssue?.call(
            EasyIssue(
              path: 'shipping' + '.' + i.path,
              code: i.code,
              message: i.message,
            ),
          ),
          runValidate: false,
        );
      }
      return addressFromJsonSafe(
        const <String, dynamic>{},
        onIssue: (i) => onIssue?.call(
          EasyIssue(
            path: 'shipping' + '.' + i.path,
            code: i.code,
            message: i.message,
          ),
        ),
        runValidate: false,
      );
    })(),
    products: (() {
      final _v = json['products'];
      if (_v is! List) return const <Product>[];
      final _list = _v;
      return _list.asMap().entries.map<Product>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final _v = entry.value;
          if (_v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'products' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return productFromJsonSafe(
              const <String, dynamic>{},
              onIssue: (i) => onIssue?.call(
                EasyIssue(
                  path:
                      'products' +
                      '[' +
                      entry.key.toString() +
                      ']' +
                      '.' +
                      i.path,
                  code: i.code,
                  message: i.message,
                ),
              ),
              runValidate: false,
            );
          }
          if (_v is Map) {
            return productFromJsonSafe(
              Map<String, dynamic>.from(_v as Map),
              onIssue: (i) => onIssue?.call(
                EasyIssue(
                  path:
                      'products' +
                      '[' +
                      entry.key.toString() +
                      ']' +
                      '.' +
                      i.path,
                  code: i.code,
                  message: i.message,
                ),
              ),
              runValidate: false,
            );
          }
          onIssue?.call(
            EasyIssue(
              path: 'products' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Expected Map for Product.',
            ),
          );
          return productFromJsonSafe(
            const <String, dynamic>{},
            onIssue: (i) => onIssue?.call(
              EasyIssue(
                path: "'products' + '[' + entry.key.toString() + ']'." + i.path,
                code: i.code,
                message: i.message,
              ),
            ),
            runValidate: false,
          );
        })();
      }).toList();
    })(),
  ))(_report);
}

class StrictOrderJson {
  const StrictOrderJson();

  static StrictOrder fromJson(Map<String, dynamic> json) {
    return strictOrderFromJson(json);
  }

  static StrictOrder fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return strictOrderFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return strictOrderValidate(json);
  }
}

List<StrictOrder> strictOrderFromJsonList(List<dynamic> json) =>
    json.map((e) => strictOrderFromJson(e as Map<String, dynamic>)).toList();

List<StrictOrder> strictOrderFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => strictOrderFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> strictOrderToJsonList(List<StrictOrder> items) =>
    items.map((e) => strictOrderToJson(e)).toList();

StrictEnvelope<T> strictEnvelopeFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  final issues = strictEnvelopeValidate<T>(json);
  if (issues.isNotEmpty) throw EasyValidationException(issues);
  return strictEnvelopeFromJsonSafe<T>(json, fromJsonT, runValidate: false);
}

Map<String, dynamic> strictEnvelopeToJson<T>(
  StrictEnvelope<T> instance,
  Object? Function(T value) toJsonT,
) {
  return <String, dynamic>{
    'payload': toJsonT(instance.payload),
    'version': instance.version,
  };
}

mixin StrictEnvelopeSerializer<T> {
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return strictEnvelopeToJson<T>(this as StrictEnvelope<T>, toJsonT);
  }
}

List<EasyIssue> strictEnvelopeValidate<T>(
  Map<String, dynamic> json, {
  List<EasyIssue> Function(Object? json)? validateT,
}) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('payload')) {
    issues.add(
      EasyIssue(
        path: 'payload',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('payload')) {
    final v = json['payload'];
    if (v != null) {
      if (validateT != null) {
        for (final n0 in validateT(v)) {
          issues.add(
            EasyIssue(
              path: 'payload' + n0.path,
              code: n0.code,
              message: n0.message,
            ),
          );
        }
      }
    }
  }
  if (!json.containsKey('version')) {
    issues.add(
      EasyIssue(
        path: 'version',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('version') && json['version'] == null) {
    issues.add(
      EasyIssue(
        path: 'version',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('version')) {
    final v = json['version'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'version',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  return issues;
}

StrictEnvelope<T> strictEnvelopeFromJsonSafe<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in strictEnvelopeValidate<T>(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => StrictEnvelope<T>(
    payload: fromJsonT(json['payload']),
    version: (() {
      final v = json['version'];
      return (v is String) ? v : '';
    })(),
  ))(_report);
}

class StrictEnvelopeJson {
  const StrictEnvelopeJson();

  static StrictEnvelope<T> fromJson<T>(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return strictEnvelopeFromJson<T>(json, fromJsonT);
  }

  static StrictEnvelope<T> fromJsonSafe<T>(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return strictEnvelopeFromJsonSafe<T>(
      json,
      fromJsonT,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return strictEnvelopeValidate(json);
  }
}

List<StrictEnvelope<T>> strictEnvelopeFromJsonList<T>(
  List<dynamic> json,
  T Function(Object? json) fromJsonT,
) => json
    .map((e) => strictEnvelopeFromJson<T>(e as Map<String, dynamic>, fromJsonT))
    .toList();

List<StrictEnvelope<T>> strictEnvelopeFromJsonSafeList<T>(
  List<dynamic> json,
  T Function(Object? json) fromJsonT, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => strictEnvelopeFromJsonSafe<T>(
        entry.value as Map<String, dynamic>,
        fromJsonT,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> strictEnvelopeToJsonList<T>(
  List<StrictEnvelope<T>> items,
  Object? Function(T value) toJsonT,
) => items.map((e) => strictEnvelopeToJson<T>(e, toJsonT)).toList();

Shape shapeFromJson(Map<String, dynamic> json) {
  final issues = shapeValidate(json);
  if (issues.isNotEmpty) throw EasyValidationException(issues);
  return shapeFromJsonSafe(json, runValidate: false);
}

Map<String, dynamic> shapeToJson(Shape instance) {
  return (instance as dynamic).toJson() as Map<String, dynamic>;
}

mixin ShapeSerializer {
  Map<String, dynamic> toJson() {
    return shapeToJson(this as Shape);
  }
}

List<EasyIssue> shapeValidate(Map<String, dynamic> json) {
  final d = json['kind'];
  switch (d) {
    case 'circle':
      return circleValidate(json);
    case 'square':
      return squareValidate(json);
    default:
      final issues = [
        EasyIssue(
          path: 'kind',
          code: 'unknown_union_type',
          message: 'Unknown type: \$d',
        ),
      ];
      return issues;
  }
}

Shape shapeFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in shapeValidate(json)) _report(i);
  }
  final d = json['kind'];
  switch (d) {
    case 'circle':
      return circleFromJsonSafe(json, onIssue: _report, runValidate: false);
    case 'square':
      return squareFromJsonSafe(json, onIssue: _report, runValidate: false);
    default:
      throw Exception(
        'Unknown union type: \$d. Provide a fallback in @EasyUnion to avoid crashes on unknown types.',
      );
  }
}

class ShapeJson {
  const ShapeJson();

  static Shape fromJson(Map<String, dynamic> json) {
    return shapeFromJson(json);
  }

  static Shape fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return shapeFromJsonSafe(json, onIssue: onIssue, runValidate: runValidate);
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return shapeValidate(json);
  }
}

List<Shape> shapeFromJsonList(List<dynamic> json) =>
    json.map((e) => shapeFromJson(e as Map<String, dynamic>)).toList();

List<Shape> shapeFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => shapeFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> shapeToJsonList(List<Shape> items) =>
    items.map((e) => shapeToJson(e)).toList();

Circle circleFromJson(Map<String, dynamic> json) {
  return Circle(radius: (json['radius'] as num?)?.toDouble() ?? 0.0);
}

Map<String, dynamic> circleToJson(Circle instance) {
  return <String, dynamic>{'radius': instance.radius};
}

mixin CircleSerializer {
  Map<String, dynamic> toJson() {
    return circleToJson(this as Circle);
  }
}

List<EasyIssue> circleValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('radius')) {
    issues.add(
      EasyIssue(
        path: 'radius',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('radius') && json['radius'] == null) {
    issues.add(
      EasyIssue(
        path: 'radius',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('radius')) {
    final v = json['radius'];
    if (v != null) {
      final _n = v is num
          ? v.toDouble()
          : (v is String ? double.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'radius',
            code: 'type_mismatch',
            message: 'Expected number.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  return issues;
}

Circle circleFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in circleValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Circle(
    radius: (() {
      final v = json['radius'];
      if (v is num) return v.toDouble();
      if (v is String) {
        final p = double.tryParse(v);
        if (p != null) return p;
      }
      return 0.0;
    })(),
  ))(_report);
}

class CircleJson {
  const CircleJson();

  static Circle fromJson(Map<String, dynamic> json) {
    return circleFromJson(json);
  }

  static Circle fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return circleFromJsonSafe(json, onIssue: onIssue, runValidate: runValidate);
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return circleValidate(json);
  }
}

List<Circle> circleFromJsonList(List<dynamic> json) =>
    json.map((e) => circleFromJson(e as Map<String, dynamic>)).toList();

List<Circle> circleFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => circleFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> circleToJsonList(List<Circle> items) =>
    items.map((e) => circleToJson(e)).toList();

Square squareFromJson(Map<String, dynamic> json) {
  return Square(side: (json['side'] as num?)?.toDouble() ?? 0.0);
}

Map<String, dynamic> squareToJson(Square instance) {
  return <String, dynamic>{'side': instance.side};
}

mixin SquareSerializer {
  Map<String, dynamic> toJson() {
    return squareToJson(this as Square);
  }
}

List<EasyIssue> squareValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('side')) {
    issues.add(
      EasyIssue(
        path: 'side',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('side') && json['side'] == null) {
    issues.add(
      EasyIssue(
        path: 'side',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('side')) {
    final v = json['side'];
    if (v != null) {
      final _n = v is num
          ? v.toDouble()
          : (v is String ? double.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'side',
            code: 'type_mismatch',
            message: 'Expected number.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  return issues;
}

Square squareFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in squareValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Square(
    side: (() {
      final v = json['side'];
      if (v is num) return v.toDouble();
      if (v is String) {
        final p = double.tryParse(v);
        if (p != null) return p;
      }
      return 0.0;
    })(),
  ))(_report);
}

class SquareJson {
  const SquareJson();

  static Square fromJson(Map<String, dynamic> json) {
    return squareFromJson(json);
  }

  static Square fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return squareFromJsonSafe(json, onIssue: onIssue, runValidate: runValidate);
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return squareValidate(json);
  }
}

List<Square> squareFromJsonList(List<dynamic> json) =>
    json.map((e) => squareFromJson(e as Map<String, dynamic>)).toList();

List<Square> squareFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => squareFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> squareToJsonList(List<Square> items) =>
    items.map((e) => squareToJson(e)).toList();
