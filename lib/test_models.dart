import 'package:dart_easy_json/easy_json.dart';
import 'package:dart_easy_json/generated/test_models.easy.dart';

enum TmRole { admin, viewer, guest, editor }
enum TmStatus { pending, paid, shipped, delivered, cancelled }

// ---- Converters p/ testes ----
class TmDateMs {
  static DateTime fromJson(Object? v) =>
      v is int ? DateTime.fromMillisecondsSinceEpoch(v)
               : DateTime.fromMillisecondsSinceEpoch(0);
  static Object toJson(DateTime v) => v.millisecondsSinceEpoch;
}

class TmIntAny {
  static int fromJson(Object? v) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v) ?? 0;
    return 0;
  }
  static Object toJson(int v) => v;
}

@EasyJson()
class Address with AddressSerializer {
  final String street;
  final int number;

  const Address({
    @EasyKey(fallback: '') this.street = '',
    @EasyKey(fallback: 0) this.number = 0,
  });

  factory Address.fromJson(Map<String, dynamic> json) => addressFromJson(json);
  factory Address.fromJsonSafe(Map<String, dynamic> json, {void Function(EasyIssue)? onIssue})
    => addressFromJsonSafe(json, onIssue: onIssue);
}

@EasyJson()
class Product with ProductSerializer {
  final int id;
  @EasyKey(fallback: 0.0)
  final double price;
  @EasyKey(fallback: '')
  final String name;

  const Product({required this.id, required this.price, required this.name});

  factory Product.fromJson(Map<String, dynamic> json) => productFromJson(json);
  factory Product.fromJsonSafe(Map<String, dynamic> json, {void Function(EasyIssue)? onIssue})
    => productFromJsonSafe(json, onIssue: onIssue);
}

@EasyJson(includeIfNull: false)
class Order with OrderSerializer {
  final String orderId;

  @EasyConvert(fromJson: TmDateMs.fromJson, toJson: TmDateMs.toJson)
  final DateTime createdAt;

  @EasyKey(enumFallback: 'guest')
  final TmRole buyerRole;

  final Address shipping;

  @EasyMapKey(type: EasyMapKeyType.int)
  final Map<int, Product> items;

  @EasyKey(itemFallback: 0)
  final Map<String, int> quantities;

  final List<String> notes;

  final Set<String> tags;

  final Map<String, TmStatus> statusHistory;

  @EasyConvert(valueFromJson: TmIntAny.fromJson, valueToJson: TmIntAny.toJson)
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
  factory Order.fromJsonSafe(Map<String, dynamic> json, {void Function(EasyIssue)? onIssue})
    => orderFromJsonSafe(json, onIssue: onIssue);
}

@EasyJson(caseStyle: CaseStyle.snake, includeIfNull: false)
class User with UserSerializer {
  final String userName;     // -> "user_name"
  final DateTime createdAt;  // -> "created_at"

  @EasyKey(name: 'e_mail')
  final String? email;       // -> "e_mail" (override manual)

  const User({
    required this.userName,
    required this.createdAt,
    this.email,
  });

  /// Gerados pelo easy_json (delegam para o .easy.dart)
  factory User.fromJson(Map<String, dynamic> json) => userFromJson(json);

  factory User.fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) =>
      userFromJsonSafe(
        json,
        onIssue: onIssue,
        runValidate: runValidate,
      );
}

