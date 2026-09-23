# dart_easy_json

[![pub package](https://img.shields.io/pub/v/dart_easy_json.svg)](https://pub.dev/packages/dart_easy_json)
[![CI](https://github.com/llFurtll/easy_json/actions/workflows/ci.yml/badge.svg)](https://github.com/llFurtll/easy_json/actions/workflows/ci.yml)

Code generation for JSON in Dart that doesn't fall over on bad data. Besides `fromJson`/`toJson`, it generates a `fromJsonSafe` that never throws and reports every problem with its exact path, a standalone `validate`, and declarative validation rules — all from annotations on plain Dart classes.

## Quick start

**1. Install**

```bash
dart pub add dart_easy_json dev:build_runner
```

**2. Annotate a model** and import the file that will be generated next to it:

```dart
// lib/models/user.dart
import 'package:dart_easy_json/easy_json.dart';

import 'user.easy.dart';

@EasyJson()
class User with UserSerializer {
  final String name;
  final int age;
  final String? email;

  User({required this.name, required this.age, this.email});

  factory User.fromJson(Map<String, dynamic> json) => userFromJson(json);
}
```

**3. Generate the code**

```bash
dart run build_runner build
```

**4. Use it**

```dart
final user = User.fromJson({'name': 'Ana', 'age': 30});
print(user.toJson()); // {name: Ana, age: 30}
```

Null fields are left out of `toJson` by default (see `includeIfNull`).

## Why dart_easy_json?

*   **Parsing that never throws.** `fromJsonSafe` builds the object even from broken data, using sensible fallbacks, and tells you what was wrong through `onIssue` — so one bad field in an API response doesn't take down the whole screen.
*   **Every problem, with its path.** Issues come with the exact location (`items[2].price`, `shipping.address.city`) and a stable, machine-readable `code` you can switch on.
*   **Validation from annotations.** `@EasyValidate(minLength: 3)`, `format: EasyFormat.email`, `min`/`max`, dates in the past/future, or your own function — checked by `validate`, `fromJsonSafe` and strict mode.
*   **Strict when you want it.** `@EasyJson(strict: true)` turns `fromJson` into "validate everything, then throw one exception listing all the problems".
*   **Covers the real-world cases**: polymorphic unions, generic classes (`PageResponse<T>`), nested paths, custom converters, inheritance, and types like `DateTime`, `Uri`, `Duration`, `BigInt` and `Uint8List` out of the box.

## Supported types

| Type | In JSON | Notes |
|---|---|---|
| `int`, `double`, `num`, `bool`, `String` | number / bool / string | Numeric strings (`"5"`, `"3.5"`) are accepted for `int`, `double` and `num`. |
| Enums | the value's `name` | `fromJsonSafe` also accepts the index. |
| `DateTime` | ISO-8601 string | Also reads milliseconds since epoch. |
| `Uri` | string | |
| `Duration` | number of **microseconds** | Matches `Duration.inMicroseconds`, no precision lost. |
| `BigInt` | decimal string | JSON numbers can't safely carry big integers (a JS/web runtime only keeps exact integers up to 2^53). `fromJsonSafe` also accepts a plain number. |
| `Uint8List` | Base64 string | |
| `List<T>`, `Set<T>` | array | `T` can be any type in this table. |
| `Map<String, V>`, `Map<int, V>` | object | Keys are always strings in JSON; `int` keys are converted both ways. |
| Other `@EasyJson` classes | object | Nested models, including lists and maps of them. |
| Type parameters (`T`) | whatever your converter returns | See [Generic classes](#generic-classes). |

Anything else can be handled with [`@EasyConvert`](#easyconvert).

## Safe parsing with `fromJsonSafe`

```dart
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
```

```dart
final issues = <EasyIssue>[];
final product = Product.fromJsonSafe(
  {'name': 'TV', 'price': 'cheap'},
  onIssue: issues.add,
);

// The object is still built, with fallbacks for what was wrong:
// product.name == 'TV', product.price == 0.0, product.stock == 0

for (final issue in issues) print(issue);
// [min_length] name: Must have at least 3 characters.
// [type_mismatch] price: Expected number.
// [missing_required] stock: Missing required field.
```

Each `EasyIssue` has a `path`, a `code` (see [Issue codes](#issue-codes)) and a human-readable `message`, and each problem is reported once. Nullable fields stay `null` when the value is missing or `null`; non-nullable ones fall back to a neutral value (`0`, `''`, `false`, an empty list...), which you can customize with [`@EasyKey(fallback: ...)`](#easykey).

### Validating without parsing

Every model also gets a `validate` function (and a static `validate` on the generated `${Class}Json` companion class) that only checks the payload, without building the object:

```dart
final problems = ProductJson.validate({'name': 'TV', 'price': 'cheap'});
if (problems.isNotEmpty) {
  // reject the request, show the errors, ...
}
```

## Validation rules with `@EasyValidate`

```dart
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

  // ... constructor
}

// Custom validators must be static methods or top-level functions.
class Rules {
  static bool isEven(int value) => value.isEven;
}
```

| Rule | Applies to |
|---|---|
| `minLength`, `maxLength` | `String` (characters), `List`/`Set`/`Map` (elements) |
| `regex` | `String` |
| `format` (`EasyFormat.email`, `.url`, `.uuid`) | `String` |
| `min`, `max` (inclusive) | `int`, `double`, `num` |
| `past`, `future` | `DateTime` |
| `custom` | any type — a `bool Function(FieldType value)` |

Rules are checked by `validate`, by `fromJsonSafe` (as issues) and by `fromJson` in [strict mode](#strict-mode).

## Strict mode

By default, the plain `fromJson` fails on bad data with whatever Dart's own casts throw — usually a `TypeError` that doesn't say which field was wrong. With `strict: true`, `fromJson` validates first and throws an `EasyValidationException` listing **every** problem:

```dart
@EasyJson(strict: true)
class SignUp with SignUpSerializer {
  final String name;
  final int age;

  @EasyValidate(format: EasyFormat.email)
  final String email;

  SignUp({required this.name, required this.age, required this.email});
}
```

```dart
try {
  signUpFromJson({'age': 'forty', 'email': 'ana@'});
} on EasyValidationException catch (e) {
  print(e);
  // EasyValidationException: 3 issue(s) found
  //   [missing_required] name: Missing required field.
  //   [type_mismatch] age: Expected int.
  //   [invalid_email] email: Invalid email.
}
```

Issues in nested objects and list items keep their full path (`shipping.number`, `products[1].id`). Strict mode also works on [unions](#unions), where an unknown discriminator becomes an `unknown_union_type` issue. `fromJsonSafe` and `validate` behave the same with or without it.

## Working with lists

Besides the per-object functions, each model gets helpers to convert a whole JSON array at once:

```dart
final users = userFromJsonList(jsonArray); // List<dynamic> -> List<User>

// Never throws; reports which item each issue came from.
userFromJsonSafeList(jsonArray, onIssue: (index, issue) {
  print('item $index: $issue'); // item 1: [type_mismatch] age: Expected int.
});

final back = userToJsonList(users); // List<User> -> List<Map<String, dynamic>>
```

## Generic classes

Classes with type parameters are supported. The generator can't know how to convert `T`, so the generated functions take one converter per type parameter — `fromJsonT` to read and `toJsonT` to write (the same convention as `json_serializable`):

```dart
@EasyJson()
class PageResponse<T> with PageResponseSerializer<T> {
  final List<T> items;
  final int total;

  PageResponse({required this.items, required this.total});
}
```

```dart
final page = pageResponseFromJson(
  json,
  (item) => User.fromJson(item as Map<String, dynamic>),
);

final out = page.toJson((user) => user.toJson());
```

One `PageResponse<T>` serves every paginated endpoint, instead of a `UserPage`, `ProductPage`, ... per model. With several type parameters you pass one converter each, in declaration order (`pairFromJson(json, fromJsonA, fromJsonB)`); bounds like `<T extends Base>` are preserved; the companion class and list helpers take the same converters.

**Current limitations** — these fail at build time with a clear message instead of generating broken code:

*   Generic fields can be `T`, `T?` or `List<T>`. `Set<T>`, `Map<K, T>` and nested collections like `List<List<T>>` aren't supported yet.
*   A generic `@EasyJson` class can't be used as another field's type yet (e.g. `final PageResponse<User> page;`).
*   Generic `@EasyUnion` classes and fields inherited from a generic superclass aren't supported yet.
*   In `fromJsonSafe`, a nullable `T?` whose converter throws is reported and becomes `null`; a non-nullable `T` has no possible fallback, so it's only as safe as the converter you pass.

## Unions

`@EasyUnion` handles polymorphic JSON: a `discriminator` field decides which subclass to build.

```dart
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
```

```dart
final posts = [
  {'type': 'text', 'content': 'Hello'},
  {'type': 'video', 'url': 'https://youtu.be/x'},
  {'type': 'poll'},
].map(postFromJson).toList();
// [TextPost, VideoPost, UnknownPost]
```

Each subclass needs a `factory X.fromJson` delegating to its generated function — the union's `fromJson` calls it. Without a `fallback`, an unknown type throws in `fromJson` (or is reported, in [strict mode](#strict-mode)). A field typed `List<Post>` in another model is dispatched the same way.

## Inheritance

Fields inherited from a superclass are serialized too, which fits architectures where a plain entity is extended by a JSON model:

```dart
class UserEntity {
  final String emailAddress;
  UserEntity({required this.emailAddress});
}

@EasyJson(caseStyle: CaseStyle.snake)
class UserModel extends UserEntity with UserModelSerializer {
  UserModel({required super.emailAddress});
}

print(UserModel(emailAddress: 'a@b.com').toJson()); // {email_address: a@b.com}
```

To annotate an inherited field (a custom key, a validation rule, ...), `@override` it in the subclass and annotate it there.

## Annotation reference

This model uses most of the field annotations at once:

```dart
class EpochMs {
  static DateTime fromJson(Object? v) =>
      DateTime.fromMillisecondsSinceEpoch(v as int, isUtc: true);
  static int toJson(DateTime v) => v.millisecondsSinceEpoch;
}

@EasyJson(caseStyle: CaseStyle.snake)
class Order with OrderSerializer {
  @EasyKey(name: '_id')
  final String id;

  final String customerName; // -> "customer_name"

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
```

```dart
final order = orderFromJson({
  '_id': 'A-1',
  'customer_name': 'Ana',
  'shipping': {'address': {'city': 'Curitiba'}},
  'created_at': 1700000000000,
  'quantities': {'10': 2, '20': 1},
});

print(order.toJson());
// {_id: A-1, customer_name: Ana, created_at: 1700000000000,
//  quantities: {10: 2, 20: 1}, shipping: {address: {city: Curitiba}}}
```

### `@EasyJson`

| Parameter | Default | |
|---|---|---|
| `caseStyle` | `null` | Key style for fields without an explicit name: `CaseStyle.snake`, `.kebab`, `.camel`, `.pascal`, `.none`. |
| `includeIfNull` | `false` | Whether `toJson` writes null fields. |
| `strict` | `false` | See [Strict mode](#strict-mode). |
| `fromJson` / `toJson` | `true` | Set one to `false` to skip generating that direction (see below). |

### `@EasyKey`

*   `name`: the JSON key for this field (overrides `caseStyle`).
*   `includeIfNull`: overrides the class setting for this field.
*   `fallback`: value used by `fromJsonSafe` when the field is invalid — or missing/`null`, if the field isn't nullable. Supported for `int`, `double`, `num`, `bool`, `String` and, written as in JSON, `DateTime` (ISO string or epoch ms), `Uri` (string), `Duration` (microseconds), `BigInt` (int or string) and `Uint8List` (Base64 string): e.g. `@EasyKey(fallback: '2020-01-01T00:00:00Z')`.
*   `itemFallback`: same, for each invalid item of a `List` or value of a `Map`.
*   `enumFallback`: the `name` of the enum value to use as fallback.

These values are checked at build time: a fallback of the wrong type, a malformed date or URI, an `enumFallback` that isn't a value of the enum, or a fallback on a type that doesn't support one fails the build with a message pointing at the field.

### `@EasyPath`

Reads the field from a nested location (`'shipping.address.city'`) without writing intermediate classes. `toJson` writes it back at the same nested location, so the output can be read again.

### `@EasyConvert`

Your own conversion functions for the field (`fromJson`/`toJson`), or for each value of a `Map` (`valueFromJson`/`valueToJson`). They must be static methods or top-level functions.

### `@EasyMapKey`

Converts JSON object keys (always strings) to `int` keys: `{"10": 2}` becomes `Map<int, int>{10: 2}`, and back to strings in `toJson`. `Map<int, V>` fields do this even without the annotation.

### `@EasyIgnore`

Leaves the field out of both reading and writing. Since `fromJson` won't pass it, the constructor parameter must be optional (a default value, or nullable).

### Read-only and write-only models

Skip the code you don't need for models that only go one way:

```dart
@EasyJson(toJson: false) // only fromJson / fromJsonSafe / validate
class LoginResponse {
  final String token;
  LoginResponse({required this.token});
}

@EasyJson(fromJson: false) // only toJson
class LoginRequest with LoginRequestSerializer {
  final String user;
  final String password;
  LoginRequest({required this.user, required this.password});
}
```

## Issue codes

The `code` of an `EasyIssue` is stable and safe to switch on.

| Code | Meaning |
|---|---|
| `missing_required` | A non-nullable field without a default value is missing. |
| `type_mismatch` | The value has the wrong type (e.g. a string where a number was expected). |
| `null_not_allowed` | A collection item is `null` but its type isn't nullable. |
| `invalid_enum` | A string that isn't the name of any enum value. |
| `invalid_enum_index` | An integer outside the enum's index range. |
| `key_type_mismatch` | A map key that can't be converted to the key type. |
| `invalid_uri` | A string that isn't a valid URI. |
| `invalid_bigint` | A string that isn't a valid integer. |
| `invalid_base64` | A string that isn't valid Base64 (`Uint8List`). |
| `min_length`, `max_length` | `@EasyValidate(minLength / maxLength)` failed. |
| `regex_mismatch` | `@EasyValidate(regex)` failed. |
| `invalid_email`, `invalid_url`, `invalid_uuid` | `@EasyValidate(format)` failed. |
| `min_value`, `max_value` | `@EasyValidate(min / max)` failed. |
| `must_be_past`, `must_be_future` | `@EasyValidate(past / future)` failed. |
| `custom_validation_failed` | `@EasyValidate(custom)` returned `false`. |
| `unknown_union_type` | The discriminator doesn't match any class in `@EasyUnion`'s `mapping`. |

## Configuration

### Putting generated files in a separate folder

By default, `user.easy.dart` is created next to `user.dart`. To keep generated files in their own folder, add a `build.yaml` to your project:

```yaml
targets:
  $default:
    builders:
      dart_easy_json:easy_json_builder:
        options:
          build_extensions:
            "^lib/{{}}.dart": "lib/generated/{{}}.easy.dart"
```

Then import them from there: `import 'package:my_app/generated/models/user.easy.dart';`.

### Analyzer

The generated files only import public libraries, so no analyzer configuration is needed. If you prefer to keep them out of your lint reports anyway:

```yaml
# analysis_options.yaml
analyzer:
  exclude:
    - "**.easy.dart"
```

## API stability

`dart_easy_json` follows [semantic versioning](https://semver.org) since `1.0.0`. These are part of the public API — breaking any of them requires a major version:

*   The annotations and their parameters: `@EasyJson`, `@EasyKey`, `@EasyValidate`, `@EasyUnion`, `@EasyConvert`, `@EasyMapKey`, `@EasyIgnore`, `@EasyPath`, `CaseStyle`, `EasyFormat`.
*   The names of generated code: `${x}FromJson`, `${x}ToJson`, `${x}Validate`, `${x}FromJsonSafe`, `${x}FromJsonList`, `${x}FromJsonSafeList`, `${x}ToJsonList`, the `${Class}Serializer` mixin, the `${Class}Json` companion class and, for generic classes, the `fromJson${T}` / `toJson${T}` converter parameters.
*   The shape of `EasyIssue` (`path` / `code` / `message`), the [issue codes](#issue-codes) and `EasyValidationException`.
*   The public exports of `package:dart_easy_json/easy_json.dart` and `package:dart_easy_json/runtime.dart`.

`@EasyConvert`'s functions are intentionally untyped (`Function?`) rather than generic, trading compile-time checking of the converter for flexibility. Anything under `lib/src/` is internal and may change in any release.

## Changelog

See [CHANGELOG.md](CHANGELOG.md).
