import 'dart:typed_data';

import 'package:dart_easy_json/easy_json.dart';
import 'package:dart_easy_json/types.dart';
import 'test_models.easy.dart';

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

@EasyJson()
class ValidationModel with ValidationModelSerializer {
  @EasyValidate(minLength: 3, maxLength: 10)
  final String username;

  @EasyValidate(min: 18, max: 99, custom: MyCustomValidators.isPositive)
  final int age;

  @EasyValidate(regex: r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
  final String? email;

  @EasyValidate(minLength: 1, maxLength: 3)
  final List<String> tags;

  @EasyValidate(format: EasyFormat.url)
  final String? websiteUrl;

  @EasyValidate(format: EasyFormat.uuid)
  final String uniqueId;

  @EasyValidate(past: true)
  final DateTime dateOfBirth;

  @EasyValidate(future: true)
  final DateTime? nextAppointment;

  const ValidationModel({
    required this.username,
    required this.age,
    this.email,
    required this.tags,
    this.websiteUrl,
    required this.uniqueId,
    required this.dateOfBirth,
    this.nextAppointment,
  });

  factory ValidationModel.fromJson(Map<String, dynamic> json) =>
      validationModelFromJson(json);
}

@EasyJson()
class IgnoreModel with IgnoreModelSerializer {
  final String visible;

  @EasyIgnore()
  final String secret;

  IgnoreModel({
    required this.visible,
    this.secret = 'default_secret',
  });

  factory IgnoreModel.fromJson(Map<String, dynamic> json) => ignoreModelFromJson(json);
  factory IgnoreModel.fromJsonSafe(Map<String, dynamic> json, {void Function(EasyIssue)? onIssue}) => ignoreModelFromJsonSafe(json, onIssue: onIssue);
}

@EasyJson()
class PathModel with PathModelSerializer {
  @EasyPath('meta.count')
  final int count;

  @EasyPath('meta.info.user_name')
  final String userName;

  PathModel({required this.count, required this.userName});

  factory PathModel.fromJson(Map<String, dynamic> json) => pathModelFromJson(json);
  factory PathModel.fromJsonSafe(Map<String, dynamic> json, {void Function(EasyIssue)? onIssue}) => pathModelFromJsonSafe(json, onIssue: onIssue);
}

class BaseEntity {
  final String baseId;
  final String baseName;

  const BaseEntity({
    required this.baseId,
    required this.baseName,
  });
}

@EasyJson(caseStyle: CaseStyle.snake)
class InheritedModel extends BaseEntity with InheritedModelSerializer {
  @override
  @EasyKey(name: 'custom_base_name')
  // ignore: overridden_fields
  final String baseName;

  final int childValue;

  InheritedModel({
    required super.baseId,
    required this.baseName,
    required this.childValue,
  }) : super(baseName: baseName);

  factory InheritedModel.fromJson(Map<String, dynamic> json) => inheritedModelFromJson(json);
  factory InheritedModel.fromJsonSafe(Map<String, dynamic> json, {void Function(EasyIssue)? onIssue}) => inheritedModelFromJsonSafe(json, onIssue: onIssue);
}

@EasyJson(toJson: false)
class ReadOnlyModel {
  final int id;
  final String name;

  ReadOnlyModel({required this.id, required this.name});

  factory ReadOnlyModel.fromJson(Map<String, dynamic> json) => readOnlyModelFromJson(json);
  factory ReadOnlyModel.fromJsonSafe(Map<String, dynamic> json, {void Function(EasyIssue)? onIssue}) => readOnlyModelFromJsonSafe(json, onIssue: onIssue);
}

@EasyJson(fromJson: false)
class WriteOnlyModel with WriteOnlyModelSerializer {
  final int id;
  final String name;

  WriteOnlyModel({required this.id, required this.name});
}

@EasyJson()
class DocumentModel with DocumentModelSerializer {
  final Uint8List fileData;
  final Uint8List? optionalData;

  DocumentModel({required this.fileData, this.optionalData});

  factory DocumentModel.fromJson(Map<String, dynamic> json) => documentModelFromJson(json);
  factory DocumentModel.fromJsonSafe(Map<String, dynamic> json, {void Function(EasyIssue)? onIssue}) => documentModelFromJsonSafe(json, onIssue: onIssue);
}

@EasyJson()
@EasyUnion(discriminator: 'type', mapping: {
  'text': TextPost,
  'video': VideoPost,
}, fallback: UnknownPost)
sealed class Post {
  Map<String, dynamic> toJson();
}

@EasyJson()
class TextPost extends Post with TextPostSerializer {
  final String author;
  final String content;

  TextPost({required this.author, required this.content});

  factory TextPost.fromJson(Map<String, dynamic> json) => textPostFromJson(json);
  factory TextPost.fromJsonSafe(Map<String, dynamic> json, {void Function(EasyIssue)? onIssue})
    => textPostFromJsonSafe(json, onIssue: onIssue);
}

@EasyJson()
class VideoPost extends Post with VideoPostSerializer {
  final String author;
  final String videoUrl;

  VideoPost({required this.author, required this.videoUrl});

  factory VideoPost.fromJson(Map<String, dynamic> json) => videoPostFromJson(json);
  factory VideoPost.fromJsonSafe(Map<String, dynamic> json, {void Function(EasyIssue)? onIssue})
    => videoPostFromJsonSafe(json, onIssue: onIssue);
}

@EasyJson()
class UnknownPost extends Post with UnknownPostSerializer {
  UnknownPost();

  factory UnknownPost.fromJson(Map<String, dynamic> json) => unknownPostFromJson(json);
  factory UnknownPost.fromJsonSafe(Map<String, dynamic> json, {void Function(EasyIssue)? onIssue})
    => unknownPostFromJsonSafe(json, onIssue: onIssue);
}

@EasyJson()
class Feed with FeedSerializer {
  final List<Post> posts;
  Feed({required this.posts});

  factory Feed.fromJson(Map<String, dynamic> json) => feedFromJson(json);
  factory Feed.fromJsonSafe(Map<String, dynamic> json, {void Function(EasyIssue)? onIssue})
    => feedFromJsonSafe(json, onIssue: onIssue);
}
