// Os mesmos modelos usados nos exemplos do README.md.
// test/readme_test.dart confere que as saídas mostradas no README são as reais:
// se mudar algo aqui ou no README, mude nos dois.

import 'package:dart_easy_json/easy_json.dart';

import 'readme_models.easy.dart';

// ---- Quick start ----
@EasyJson()
class User with UserSerializer {
  final String name;
  final int age;
  final String? email;

  User({required this.name, required this.age, this.email});

  factory User.fromJson(Map<String, dynamic> json) => userFromJson(json);
}

// ---- Safe parsing ----
@EasyJson()
class Product with ProductSerializer {
  @EasyValidate(minLength: 3)
  final String name;
  final double price;
  final int stock;

  Product({required this.name, required this.price, required this.stock});

  factory Product.fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
  }) => productFromJsonSafe(json, onIssue: onIssue);
}

// ---- Strict ----
@EasyJson(strict: true)
class SignUp with SignUpSerializer {
  final String name;
  final int age;

  @EasyValidate(format: EasyFormat.email)
  final String email;

  SignUp({required this.name, required this.age, required this.email});
}

// ---- Generics ----
@EasyJson()
class PageResponse<T> with PageResponseSerializer<T> {
  final List<T> items;
  final int total;

  PageResponse({required this.items, required this.total});
}

@EasyJson()
class UserSearch with UserSearchSerializer {
  final PageResponse<User> results;
  final Map<String, List<User>> byTeam;

  UserSearch({required this.results, required this.byTeam});
}

class Page<T> {
  final List<T> items;
  Page({required this.items});
}

@EasyJson()
class UserPage extends Page<User> with UserPageSerializer {
  UserPage({required super.items});
}

// ---- Union ----
@EasyJson()
@EasyUnion(
  discriminator: 'type',
  mapping: {'text': TextPost, 'video': VideoPost},
  fallback: UnknownPost,
)
sealed class Post {
  Map<String, dynamic> toJson();
}

@EasyJson()
class TextPost extends Post with TextPostSerializer {
  final String content;
  TextPost({required this.content});
  factory TextPost.fromJson(Map<String, dynamic> json) => textPostFromJson(json);
}

@EasyJson()
class VideoPost extends Post with VideoPostSerializer {
  final String url;
  VideoPost({required this.url});
  factory VideoPost.fromJson(Map<String, dynamic> json) => videoPostFromJson(json);
}

@EasyJson()
class UnknownPost extends Post with UnknownPostSerializer {
  UnknownPost();
  factory UnknownPost.fromJson(Map<String, dynamic> json) => unknownPostFromJson(json);
}

// ---- Annotations ----
class EpochMs {
  static DateTime fromJson(Object? v) => DateTime.fromMillisecondsSinceEpoch(v as int, isUtc: true);
  static int toJson(DateTime v) => v.millisecondsSinceEpoch;
}

@EasyJson(caseStyle: CaseStyle.snake)
class Order with OrderSerializer {
  @EasyKey(name: '_id')
  final String id;

  final String customerName;

  @EasyPath('shipping.address.city')
  final String city;

  @EasyConvert(fromJson: EpochMs.fromJson, toJson: EpochMs.toJson)
  final DateTime createdAt;

  @EasyMapKey(type: EasyMapKeyType.int)
  final Map<int, int> quantities;

  @EasyIgnore()
  final bool selected;

  Order({
    required this.id,
    required this.customerName,
    required this.city,
    required this.createdAt,
    required this.quantities,
    this.selected = false,
  });
}

// ---- Inheritance ----
class UserEntity {
  final String emailAddress;
  UserEntity({required this.emailAddress});
}

@EasyJson(caseStyle: CaseStyle.snake)
class UserModel extends UserEntity with UserModelSerializer {
  UserModel({required super.emailAddress});
}

// ---- Read-only / write-only ----
@EasyJson(toJson: false)
class LoginResponse {
  final String token;
  LoginResponse({required this.token});
}

@EasyJson(fromJson: false)
class LoginRequest with LoginRequestSerializer {
  final String user;
  final String password;
  LoginRequest({required this.user, required this.password});
}

// ---- Validation rules ----
@EasyJson()
class Account with AccountSerializer {
  @EasyValidate(minLength: 3, maxLength: 20, regex: r'^[a-z0-9_]+$')
  final String username;

  @EasyValidate(format: EasyFormat.email)
  final String email;

  @EasyValidate(min: 18, max: 120)
  final int age;

  @EasyValidate(past: true)
  final DateTime birthDate;

  @EasyValidate(custom: Rules.isEven)
  final int luckyNumber;

  Account({
    required this.username,
    required this.email,
    required this.age,
    required this.birthDate,
    required this.luckyNumber,
  });
}

// Custom validators must be static methods or top-level functions.
class Rules {
  static bool isEven(int value) => value.isEven;
}

// ---- Map<int, V> sem @EasyMapKey ----
@EasyJson()
class IntKeyed with IntKeyedSerializer {
  final Map<int, String> names;
  IntKeyed({required this.names});
}
