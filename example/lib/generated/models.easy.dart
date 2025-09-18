// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// EasyJsonGenerator
// **************************************************************************

// ignore_for_file: type=lint
import 'dart:core';
import 'package:easy_json/src/easy_issue.dart';
import 'package:example/models.dart';

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
      issues.add(EasyIssue(
          path: 'street', code: 'type_mismatch', message: 'Esperado String.'));
    }
  }
  if (json.containsKey('number')) {
    final v = json['number'];
    if (v != null && v is! int) {
      issues.add(EasyIssue(
          path: 'number', code: 'type_mismatch', message: 'Esperado int.'));
    }
  }
  return issues;
}

Address addressFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  if (runValidate) {
    final _issues = addressValidate(json);
    if (onIssue != null) {
      for (final i in _issues) onIssue(i);
    }
  }
  return Address(
    street: (() {
      final v = json['street'];
      return (v is String) ? v : '';
    })(),
    number: (() {
      final v = json['number'];
      return (v is int) ? v : 0;
    })(),
  );
}

Order orderFromJson(Map<String, dynamic> json) {
  return Order(
    orderId: (json['orderId'] as String?) ?? '',
    createdAt: json['createdAt'] == null
        ? DateTime.fromMillisecondsSinceEpoch(0)
        : DateTime.parse(json['createdAt'] as String),
    buyerRole: OrderRole.values.byName(json['buyerRole'] as String),
    shipping: addressFromJson(json['shipping'] as Map<String, dynamic>),
    items: (Map<dynamic, dynamic>.from(json['items'] as Map))
        .map<int, Product>((key, value) {
      final entry = MapEntry(key, value);
      final k = (int.parse(entry.key as String));
      final v = productFromJson(Map<String, dynamic>.from(entry.value as Map));
      return MapEntry(k, v);
    }),
    quantities: (Map<dynamic, dynamic>.from(json['quantities'] as Map))
        .map<String, int>((key, value) {
      final entry = MapEntry(key, value);
      final k = (entry.key as String);
      final v = (entry.value as int?) ?? 0;
      return MapEntry(k, v);
    }),
    notes: ((json['notes'] as List?)?.asMap().entries.map<String>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (e as String?) ?? '';
        }).toList()) ??
        const <String>[],
    tags: ((json['tags'] as List?)?.asMap().entries.map<String>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (e as String?) ?? '';
        }).toSet()) ??
        const <String>{},
    statusHistory: (Map<dynamic, dynamic>.from(json['statusHistory'] as Map))
        .map<String, OrderStatus>((key, value) {
      final entry = MapEntry(key, value);
      final k = (entry.key as String);
      final v = OrderStatus.values.byName(entry.value as String);
      return MapEntry(k, v);
    }),
    scores: (Map<dynamic, dynamic>.from(json['scores'] as Map))
        .map<String, int>((key, value) {
      final entry = MapEntry(key, value);
      final k = (entry.key as String);
      final v = IntFromAny.fromJson(entry.value);
      return MapEntry(k, v);
    }),
  );
}

Map<String, dynamic> orderToJson(Order instance) {
  return <String, dynamic>{
    'orderId': instance.orderId,
    'createdAt': instance.createdAt,
    'buyerRole': instance.buyerRole.name,
    'shipping': instance.shipping.toJson(),
    'items': instance.items.map((k, v) => MapEntry(k, v.toJson())),
    'quantities': instance.quantities,
    'notes': instance.notes,
    'tags': instance.tags.toList(),
    'statusHistory': instance.statusHistory.map((k, v) => MapEntry(k, v.name)),
    'scores': instance.scores.map((k, v) => MapEntry(k, IntFromAny.toJson(v))),
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
    issues.add(EasyIssue(
        path: 'orderId',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.'));
  }
  if (json.containsKey('orderId')) {
    final v = json['orderId'];
    if (v != null && v is! String) {
      issues.add(EasyIssue(
          path: 'orderId', code: 'type_mismatch', message: 'Esperado String.'));
    }
  }
  if (!json.containsKey('createdAt')) {
    issues.add(EasyIssue(
        path: 'createdAt',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.'));
  }
  if (json.containsKey('createdAt')) {
    final v = json['createdAt'];
    if (v != null && v is! String) {
      issues.add(EasyIssue(
          path: 'createdAt',
          code: 'type_mismatch',
          message: 'Esperado String (ISO-8601) para DateTime.'));
    } else if (v != null) {
      try {
        DateTime.parse(v as String);
      } catch (_) {
        issues.add(EasyIssue(
            path: 'createdAt',
            code: 'type_mismatch',
            message: 'Formato inválido de DateTime.'));
      }
    }
  }
  if (!json.containsKey('buyerRole')) {
    issues.add(EasyIssue(
        path: 'buyerRole',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.'));
  }
  if (json.containsKey('buyerRole')) {
    final v = json['buyerRole'];
    if (v != null && v is! String) {
      issues.add(EasyIssue(
          path: 'buyerRole',
          code: 'type_mismatch',
          message: 'Esperado String com o nome do enum.'));
    } else if (v != null) {
      final ok = OrderRole.values.any((e) => e.name == v);
      if (!ok) {
        issues.add(EasyIssue(
            path: 'buyerRole',
            code: 'invalid_enum',
            message: "Valor '$v' não corresponde a OrderRole."));
      }
    }
  }

  if (!json.containsKey('shipping')) {
    issues.add(EasyIssue(
        path: 'shipping',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.'));
  }
  if (json.containsKey('shipping')) {
    final v = json['shipping'];
    if (v != null && v is! Map) {
      issues.add(EasyIssue(
          path: 'shipping',
          code: 'type_mismatch',
          message: 'Esperado Map para Address.'));
    }
  }

  if (!json.containsKey('items')) {
    issues.add(EasyIssue(
        path: 'items',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.'));
  }
  if (json.containsKey('items')) {
    final v = json['items'];
    if (v != null && v is! Map) {
      issues.add(EasyIssue(
          path: 'items', code: 'type_mismatch', message: 'Esperado Map.'));
    } else if (v is Map) {
      for (final e in v.entries) {
        final k = e.key;
        final ok = (k is int) ||
            (k is num) ||
            (k is String && num.tryParse(k) != null);
        if (!ok) {
          issues.add(EasyIssue(
              path: 'items.' + k.toString(),
              code: 'key_type_mismatch',
              message: 'Chave incompatível com o tipo do mapa.'));
        }
      }
    }
  }

  if (!json.containsKey('quantities')) {
    issues.add(EasyIssue(
        path: 'quantities',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.'));
  }
  if (json.containsKey('quantities')) {
    final v = json['quantities'];
    if (v != null && v is! Map) {
      issues.add(EasyIssue(
          path: 'quantities', code: 'type_mismatch', message: 'Esperado Map.'));
    } else if (v is Map) {}
  }

  if (!json.containsKey('notes')) {
    issues.add(EasyIssue(
        path: 'notes',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.'));
  }
  if (json.containsKey('notes')) {
    final v = json['notes'];
    if (v != null && v is! List) {
      issues.add(EasyIssue(
          path: 'notes', code: 'type_mismatch', message: 'Esperado List.'));
    }
  }

  if (!json.containsKey('tags')) {
    issues.add(EasyIssue(
        path: 'tags',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.'));
  }
  if (json.containsKey('tags')) {
    final v = json['tags'];
    if (v != null && v is! List) {
      issues.add(EasyIssue(
          path: 'tags',
          code: 'type_mismatch',
          message: 'Esperado List para Set.'));
    }
  }

  if (!json.containsKey('statusHistory')) {
    issues.add(EasyIssue(
        path: 'statusHistory',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.'));
  }
  if (json.containsKey('statusHistory')) {
    final v = json['statusHistory'];
    if (v != null && v is! Map) {
      issues.add(EasyIssue(
          path: 'statusHistory',
          code: 'type_mismatch',
          message: 'Esperado Map.'));
    } else if (v is Map) {}
  }

  if (!json.containsKey('scores')) {
    issues.add(EasyIssue(
        path: 'scores',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.'));
  }
  if (json.containsKey('scores')) {
    final v = json['scores'];
    if (v != null && v is! Map) {
      issues.add(EasyIssue(
          path: 'scores', code: 'type_mismatch', message: 'Esperado Map.'));
    } else if (v is Map) {}
  }

  return issues;
}

Order orderFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  if (runValidate) {
    final _issues = orderValidate(json);
    if (onIssue != null) {
      for (final i in _issues) onIssue(i);
    }
  }
  return Order(
    orderId: (() {
      final v = json['orderId'];
      return (v is String) ? v : '';
    })(),
    createdAt: (() {
      final v = json['createdAt'];
      if (v == null) return DateTime.fromMillisecondsSinceEpoch(0);
      if (v is! String) return DateTime.fromMillisecondsSinceEpoch(0);
      try {
        return DateTime.parse(v);
      } catch (_) {
        return DateTime.fromMillisecondsSinceEpoch(0);
      }
    })(),
    buyerRole: (() {
      final v = json['buyerRole'];
      if (v is String) {
        return OrderRole.values.firstWhere((e) => e.name == v,
            orElse: () => OrderRole.values.firstWhere((e) => e.name == 'guest',
                orElse: () => OrderRole.values.first));
      }
      return OrderRole.values.firstWhere((e) => e.name == 'guest',
          orElse: () => OrderRole.values.first);
    })(),
    shipping: addressFromJsonSafe(json['shipping'] as Map<String, dynamic>,
        onIssue: (i) => onIssue?.call(EasyIssue(
            path: 'shipping' + '.' + i.path, code: i.code, message: i.message)),
        runValidate: false),
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
          onIssue?.call(EasyIssue(
              path: 'items' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Chave incompatível com o tipo do mapa.'));
          continue;
        }
        final v = (() {
          final _v = entry.value;
          if (_v is Map) {
            return productFromJsonSafe(Map<String, dynamic>.from(_v as Map),
                onIssue: (i) => onIssue?.call(EasyIssue(
                    path: 'items' + '.' + k.toString() + '.' + i.path,
                    code: i.code,
                    message: i.message)),
                runValidate: false);
          }
          return productFromJsonSafe(const <String, dynamic>{},
              onIssue: (i) => onIssue?.call(EasyIssue(
                  path: 'items' + '.' + k.toString() + '.' + i.path,
                  code: i.code,
                  message: i.message)),
              runValidate: false);
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
          onIssue?.call(EasyIssue(
              path: 'quantities' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Chave incompatível com o tipo do mapa.'));
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
        final i = entry.key;
        final e = entry.value;
        return (() {
          final v = e;
          return (v is String) ? v : '';
        })();
      }).toList();
    })(),
    tags: (() {
      final _v = json['tags'];
      if (_v is! List) return const <String>{};
      final _list = _v;
      return _list.asMap().entries.map<String>((entry) {
        final i = entry.key;
        final e = entry.value;
        return (() {
          final v = e;
          return (v is String) ? v : '';
        })();
      }).toSet();
    })(),
    statusHistory: (() {
      final _v = json['statusHistory'];
      if (_v is! Map) return const <String, OrderStatus>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <String, OrderStatus>{};
      for (final entry in _mapRaw.entries) {
        final k = (entry.key is String) ? entry.key : (entry.key?.toString());
        if (k == null) {
          onIssue?.call(EasyIssue(
              path: 'statusHistory' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Chave incompatível com o tipo do mapa.'));
          continue;
        }
        final v = (entry.value is String
            ? OrderStatus.values.firstWhere((x) => x.name == entry.value,
                orElse: () => OrderStatus.values.first)
            : OrderStatus.values.first);
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
          onIssue?.call(EasyIssue(
              path: 'scores' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Chave incompatível com o tipo do mapa.'));
          continue;
        }
        final v = (() {
          try {
            return IntFromAny.fromJson(entry.value);
          } catch (_) {
            return 0;
          }
        })();
        _out[k] = v;
      }
      return _out;
    })(),
  );
}

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
    issues.add(EasyIssue(
        path: 'id',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.'));
  }
  if (json.containsKey('id')) {
    final v = json['id'];
    if (v != null && v is! int) {
      issues.add(EasyIssue(
          path: 'id', code: 'type_mismatch', message: 'Esperado int.'));
    }
  }
  if (!json.containsKey('price')) {
    issues.add(EasyIssue(
        path: 'price',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.'));
  }
  if (json.containsKey('price')) {
    final v = json['price'];
    if (v != null && v is! num) {
      issues.add(EasyIssue(
          path: 'price',
          code: 'type_mismatch',
          message: 'Esperado número (int/double).'));
    }
  }
  if (!json.containsKey('name')) {
    issues.add(EasyIssue(
        path: 'name',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.'));
  }
  if (json.containsKey('name')) {
    final v = json['name'];
    if (v != null && v is! String) {
      issues.add(EasyIssue(
          path: 'name', code: 'type_mismatch', message: 'Esperado String.'));
    }
  }
  return issues;
}

Product productFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  if (runValidate) {
    final _issues = productValidate(json);
    if (onIssue != null) {
      for (final i in _issues) onIssue(i);
    }
  }
  return Product(
    id: (() {
      final v = json['id'];
      return (v is int) ? v : 0;
    })(),
    price: (() {
      final v = json['price'];
      return (v is num) ? v.toDouble() : 0.0;
    })(),
    name: (() {
      final v = json['name'];
      return (v is String) ? v : '';
    })(),
  );
}
