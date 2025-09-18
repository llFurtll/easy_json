// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// EasyJsonGenerator
// **************************************************************************

// ignore_for_file: type=lint
import 'dart:core';
import 'package:easy_json/src/easy_issue.dart';
import 'package:easy_json/test_models.dart';
import 'package:easy_json/src/runtime.dart' as ej;
import 'package:easy_json/src/messages.dart';

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

Order orderFromJson(Map<String, dynamic> json) {
  return Order(
    orderId: (json['orderId'] as String?) ?? '',
    createdAt: TmDateMs.fromJson(json['createdAt']),
    buyerRole: TmRole.values.byName(json['buyerRole'] as String),
    shipping: addressFromJson(json['shipping'] as Map<String, dynamic>),
    items: (Map<dynamic, dynamic>.from(json['items'] as Map))
        .entries
        .fold(<int, Product>{}, (acc, entry) {
      final k = (entry.key is int
          ? (entry.key as int)
          : (entry.key is num
              ? (entry.key as num).toInt()
              : int.parse(entry.key as String)));
      final v = productFromJson(Map<String, dynamic>.from(entry.value as Map));
      acc[k] = v;
      return acc;
    }),
    quantities: (Map<dynamic, dynamic>.from(json['quantities'] as Map))
        .entries
        .fold(<String, int>{}, (acc, entry) {
      final k =
          (entry.key is String ? (entry.key as String) : entry.key.toString());
      final v = (entry.value as int?) ?? 0;
      acc[k] = v;
      return acc;
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
        .entries
        .fold(<String, TmStatus>{}, (acc, entry) {
      final k =
          (entry.key is String ? (entry.key as String) : entry.key.toString());
      final v = TmStatus.values.byName(entry.value as String);
      acc[k] = v;
      return acc;
    }),
    scores: (Map<dynamic, dynamic>.from(json['scores'] as Map))
        .entries
        .fold(<String, int>{}, (acc, entry) {
      final k =
          (entry.key is String ? (entry.key as String) : entry.key.toString());
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
    'items': instance.items.map((k, v) => MapEntry(k, v.toJson())),
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
      final ok = TmRole.values.any((e) => e.name == v);
      if (!ok) {
        issues.add(EasyIssue(
            path: 'buyerRole',
            code: 'invalid_enum',
            message: "Valor '$v' não corresponde a TmRole."));
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
    } else if (v is Map) {
      final child = addressValidate(Map<String, dynamic>.from(v));
      for (final ci in child) {
        issues.add(EasyIssue(
            path: 'shipping.' + ci.path, code: ci.code, message: ci.message));
      }
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

      for (final e in v.entries) {
        final val = e.value;
        if (val != null && val is! Map) {
          issues.add(EasyIssue(
              path: 'items.' + e.key.toString(),
              code: 'type_mismatch',
              message: 'Esperado Map para Product.'));
        } else if (val is Map) {
          final child = productValidate(Map<String, dynamic>.from(val as Map));
          for (final ci in child) {
            issues.add(EasyIssue(
                path: 'items.' + e.key.toString() + '.' + ci.path,
                code: ci.code,
                message: ci.message));
          }
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
    } else if (v is Map) {
      for (final e in v.entries) {
        final val = e.value;
        if (val != null && val is! int) {
          issues.add(EasyIssue(
              path: 'quantities.' + e.key.toString(),
              code: 'type_mismatch',
              message: 'Esperado int.'));
        }
      }
    }
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
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(EasyIssue(
              path: 'notes[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Valor nulo não permitido.'));
        } else {
          if (e is! String) {
            issues.add(EasyIssue(
                path: 'notes[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Esperado String.'));
          }
        }
      }
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
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(EasyIssue(
              path: 'tags[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Valor nulo não permitido.'));
        } else {
          if (e is! String) {
            issues.add(EasyIssue(
                path: 'tags[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Esperado String.'));
          }
        }
      }
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
    } else if (v is Map) {
      for (final e in v.entries) {
        final val = e.value;
        if (val != null && val is! String) {
          issues.add(EasyIssue(
              path: 'statusHistory.' + e.key.toString(),
              code: 'type_mismatch',
              message: 'Esperado String com nome do enum.'));
        } else if (val != null) {
          final ok = TmStatus.values.any((x) => x.name == val);
          if (!ok) {
            issues.add(EasyIssue(
                path: 'statusHistory.' + e.key.toString(),
                code: 'invalid_enum',
                message: "Valor '$val' não corresponde a TmStatus."));
          }
        }
      }
    }
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
      if (v is DateTime) return v;
      if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
      if (v is num) return DateTime.fromMillisecondsSinceEpoch(v.toInt());
      if (v is String) {
        try {
          return DateTime.parse(v);
        } catch (_) {
          onIssue?.call(EasyIssue(
              path: 'createdAt',
              code: 'type_mismatch',
              message: 'Formato inválido de DateTime.'));
          return DateTime.fromMillisecondsSinceEpoch(0);
        }
      }
      onIssue?.call(EasyIssue(
          path: 'createdAt',
          code: 'type_mismatch',
          message: 'Esperado String/epoch/DateTime.'));
      return DateTime.fromMillisecondsSinceEpoch(0);
    })(),
    buyerRole: (() {
      final v = json['buyerRole'];
      if (v == null)
        return TmRole.values.firstWhere((e) => e.name == 'guest',
            orElse: () => TmRole.values.first);

      // String pelo .name (tolerante a espaços/case)
      if (v is String) {
        final s = v.trim();
        for (final e in TmRole.values) {
          if (e.name == s || e.name.toLowerCase() == s.toLowerCase()) return e;
        }
        onIssue?.call(EasyIssue(
            path: 'buyerRole',
            code: 'invalid_enum',
            message: "Valor '$v' não corresponde a TmRole."));
        return TmRole.values.firstWhere((e) => e.name == 'guest',
            orElse: () => TmRole.values.first);
      }

      // Índice numérico
      if (v is int) {
        if (v >= 0 && v < TmRole.values.length) return TmRole.values[v];
        onIssue?.call(EasyIssue(
            path: 'buyerRole',
            code: 'invalid_enum_index',
            message: 'Índice de enum fora do intervalo.'));
        return TmRole.values.firstWhere((e) => e.name == 'guest',
            orElse: () => TmRole.values.first);
      }

      onIssue?.call(EasyIssue(
          path: 'buyerRole',
          code: 'type_mismatch',
          message: 'Esperado String com nome do enum ou índice int.'));
      return TmRole.values.firstWhere((e) => e.name == 'guest',
          orElse: () => TmRole.values.first);
    })(),
    shipping: (() {
      final _v = json['shipping'];
      if (_v == null)
        return addressFromJsonSafe(const <String, dynamic>{},
            onIssue: (i) => onIssue?.call(EasyIssue(
                path: 'shipping' + '.' + i.path,
                code: i.code,
                message: i.message)),
            runValidate: false);
      if (_v is Map) {
        return addressFromJsonSafe(Map<String, dynamic>.from(_v as Map),
            onIssue: (i) => onIssue?.call(EasyIssue(
                path: 'shipping' + '.' + i.path,
                code: i.code,
                message: i.message)),
            runValidate: false);
      }
      return addressFromJsonSafe(const <String, dynamic>{},
          onIssue: (i) => onIssue?.call(EasyIssue(
              path: 'shipping' + '.' + i.path,
              code: i.code,
              message: i.message)),
          runValidate: false);
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
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final v = entry.value;
          if (v is String) return v;
          onIssue?.call(EasyIssue(
              path: 'notes' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Esperado String.'));
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
              if (vv is String) return vv;
              onIssue?.call(EasyIssue(
                  path: 'tags' + '[' + entry.key.toString() + ']',
                  code: 'type_mismatch',
                  message: 'Esperado String.'));
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
          onIssue?.call(EasyIssue(
              path: 'statusHistory' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Chave incompatível com o tipo do mapa.'));
          continue;
        }
        final v = (entry.value is String
            ? TmStatus.values.firstWhere((x) => x.name == entry.value,
                orElse: () => TmStatus.values.first)
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
          onIssue?.call(EasyIssue(
              path: 'scores' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Chave incompatível com o tipo do mapa.'));
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
  );
}

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
    issues.add(EasyIssue(
        path: 'user_name',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.'));
  }
  if (json.containsKey('user_name')) {
    final v = json['user_name'];
    if (v != null && v is! String) {
      issues.add(EasyIssue(
          path: 'user_name',
          code: 'type_mismatch',
          message: 'Esperado String.'));
    }
  }
  if (!json.containsKey('created_at')) {
    issues.add(EasyIssue(
        path: 'created_at',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.'));
  }
  if (json.containsKey('created_at')) {
    final v = json['created_at'];
    if (v != null && v is! String) {
      issues.add(EasyIssue(
          path: 'created_at',
          code: 'type_mismatch',
          message: 'Esperado String (ISO-8601) para DateTime.'));
    } else if (v != null) {
      try {
        DateTime.parse(v as String);
      } catch (_) {
        issues.add(EasyIssue(
            path: 'created_at',
            code: 'type_mismatch',
            message: 'Formato inválido de DateTime.'));
      }
    }
  }
  if (json.containsKey('e_mail')) {
    final v = json['e_mail'];
    if (v != null && v is! String) {
      issues.add(EasyIssue(
          path: 'e_mail', code: 'type_mismatch', message: 'Esperado String.'));
    }
  }
  return issues;
}

User userFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  if (runValidate) {
    final _issues = userValidate(json);
    if (onIssue != null) {
      for (final i in _issues) onIssue(i);
    }
  }
  return User(
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
          onIssue?.call(EasyIssue(
              path: 'created_at',
              code: 'type_mismatch',
              message: 'Formato inválido de DateTime.'));
          return DateTime.fromMillisecondsSinceEpoch(0);
        }
      }
      onIssue?.call(EasyIssue(
          path: 'created_at',
          code: 'type_mismatch',
          message: 'Esperado String/epoch/DateTime.'));
      return DateTime.fromMillisecondsSinceEpoch(0);
    })(),
    email: (() {
      final v = json['e_mail'];
      return (v is String) ? v : null;
    })(),
  );
}
