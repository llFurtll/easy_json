// example/lib/models.dart
import 'package:easy_json/easy_json.dart';
import 'package:example/generated/models.easy.dart';

// ===== Enums =====
enum OrderRole { admin, member, guest }
enum OrderStatus { pending, paid, shipped, delivered, cancelled }

// ===== Converters de exemplo =====
class DateMsConv {
  static DateTime fromJson(Object? v) =>
      v is int ? DateTime.fromMillisecondsSinceEpoch(v)
               : DateTime.fromMillisecondsSinceEpoch(0);
  static Object toJson(DateTime v) => v.millisecondsSinceEpoch;
}

class IntFromAny {
  static int fromJson(Object? v) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v) ?? 0;
    return 0;
  }
  static Object toJson(int v) => v;
}

// ===== Classe aninhada =====
@EasyJson()
class Address with AddressSerializer {
  final String street;
  final int number;

  // fallback por campo: se vier inválido no SAFE, mantém '' e 0
  const Address({
    @EasyKey(fallback: '') this.street = '',
    @EasyKey(fallback: 0) this.number = 0,
  });

  factory Address.fromJson(Map<String, dynamic> json) => addressFromJson(json);
  factory Address.fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
  }) =>
      addressFromJsonSafe(json, onIssue: onIssue);
}

// ===== Classe principal =====
@EasyJson(includeIfNull: false)
class Order with OrderSerializer {
  /// id simples
  final String orderId;

  /// conversor por CAMPO (epoch ms <-> DateTime)
  @EasyConvert(fromJson: DateMsConv.fromJson, toJson: DateMsConv.toJson)
  final DateTime createdAt;

  /// enum com fallback (se inválido no SAFE, vira 'guest')
  @EasyKey(enumFallback: 'guest')
  final OrderRole buyerRole;

  /// objeto aninhado
  final Address shipping;

  /// Mapa com CHAVE int (coerção de "1","2",3.0 -> 1,2,3), VALOR objeto @EasyJson
  @EasyMapKey(type: EasyMapKeyType.int)
  final Map<int, Product> items;

  /// Quantidades com fallback por ITEM: se item inválido -> 0
  @EasyKey(itemFallback: 0)
  final Map<String, int> quantities;

  /// Notas “livres”
  final List<String> notes;

  /// Set de tags (entra como List no JSON)
  final Set<String> tags;

  /// Mapa de status por ISO-date string
  final Map<String, OrderStatus> statusHistory;

  /// Exemplo de Map com conversor por VALOR (coage "10"/12.0 -> 10)
  @EasyConvert(valueFromJson: IntFromAny.fromJson, valueToJson: IntFromAny.toJson)
  final Map<String, int> scores;

  const Order({
    required this.orderId,
    required this.createdAt,
    required this.buyerRole,
    required this.shipping,
    required this.items,
    required this.quantities,
    required this.notes,
    required this.tags,
    required this.statusHistory,
    required this.scores,
  });

  factory Order.fromJson(Map<String, dynamic> json) => orderFromJson(json);
  factory Order.fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
  }) =>
      orderFromJsonSafe(json, onIssue: onIssue);
}

// ===== Outro @EasyJson usado no Map<int, Product> =====
@EasyJson()
class Product with ProductSerializer {
  final int id;

  // se preço vier inválido no SAFE, use 0.0
  @EasyKey(fallback: 0.0)
  final double price;

  // nome com fallback ''
  @EasyKey(fallback: '')
  final String name;

  const Product({
    required this.id,
    required this.price,
    required this.name,
  });

  factory Product.fromJson(Map<String, dynamic> json) => productFromJson(json);
  factory Product.fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
  }) =>
      productFromJsonSafe(json, onIssue: onIssue);
}
