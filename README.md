# Easy JSON

[![pub package](https://img.shields.io/pub/v/dart_easy_json.svg)](https://pub.dev/packages/dart_easy_json)

A powerful and flexible code generation library for JSON serialization and deserialization in Dart. `easy_json` focuses on safety, performance, and ease of use, automating the creation of boilerplate code while providing robust data validation and error handling out of the box.

## Main Features

*   **Automatic Code Generation**: Creates all the necessary serialization boilerplate for you (`fromJson`, `toJson`).
*   **Safe Deserialization**: Provides a `fromJsonSafe` method that never throws exceptions. It uses sensible fallbacks for invalid data and reports all issues found.
*   **Declarative Validation**: Use the `@EasyValidate` annotation to define powerful validation rules directly on your model fields (e.g., min/max length, regex, formats like email/URL).
*   **Standalone Validation**: Generates a `validate` method that checks a JSON map against your model's rules without the overhead of object instantiation.
*   **Highly Customizable**: Configure JSON key `caseStyle`, custom names, converters, per-field fallbacks, and much more.
*   **Clean API**: Generates a `...Serializer` mixin for instance methods and top-level functions for a clean, static-like API.

## 1. Installation

Add the necessary dependencies to your project's `pubspec.yaml` file. The `dart_easy_json` package is required in both sections for two key reasons:

```yaml
# pubspec.yaml

dependencies:
  # 1. For Runtime: Your application code needs the annotations (@EasyJson, @EasyKey),
  #    mixins, and helper classes (EasyIssue) to compile.
  dart_easy_json: ^0.4.0 # Use the latest version from pub.dev

dev_dependencies:
  # 2. For Development: The build_runner tool needs to find and execute the code
  #    generator, which is also included in this package.
  dart_easy_json: ^0.4.0 # Must match the version in dependencies
  build_runner: ^2.4.0
```

Run `dart pub get` to install the packages.

## 2. Configuration

To keep your project organized, it's highly recommended to place generated files in a separate directory.

### `build.yaml`

Create a `build.yaml` file in your project's root to configure the output location for the generated files.

```yaml
# build.yaml

targets:
  $default:
    builders:
      # This key is composed of: <package_name>:<builder_name>
      dart_easy_json:easy_json_builder:
        options:
          build_extensions:
            # Maps input (e.g., lib/models/user.dart)
            # to output (e.g., lib/generated/models/user.easy.dart)
            "^lib/{{}}.dart": "lib/generated/{{}}.easy.dart"
```

### `analysis_options.yaml`

To prevent the Dart analyzer from linting the auto-generated files, exclude them in your `analysis_options.yaml`.

```yaml
# analysis_options.yaml

analyzer:
  exclude:
    # Exclude all files in the generated directory
    - "lib/generated/**"
    # Or, if you don't use a dedicated directory, exclude by file pattern:
    # - "**.easy.dart"
```

## 3. Basic Usage

### Step 1: Annotate Your Model

Create your model class, annotate it with `@EasyJson`, add the `...Serializer` mixin, and **import** the file that will be generated.

```dart
// lib/models/user.dart
import 'package:dart_easy_json/easy_json.dart';

// The path must match the output location from your build.yaml
import 'package:my_project/generated/models/user.easy.dart'; // Adjust path as needed

@EasyJson(caseStyle: CaseStyle.snake, includeIfNull: false)
class User with UserSerializer {
  final String userName;
  final DateTime createdAt;

  @EasyKey(name: 'e_mail') // Override the caseStyle for this specific field
  final String? email;

  const User({
    required this.userName,
    required this.createdAt,
    this.email,
  });

  // Factory constructors that delegate to the public, generated functions.
  factory User.fromJson(Map<String, dynamic> json) => userFromJson(json);
  factory User.fromJsonSafe(Map<String, dynamic> json, {void Function(EasyIssue)? onIssue})
    => userFromJsonSafe(json, onIssue: onIssue);
}
```

### Step 2: Run the Code Generator

Execute the `build_runner` command in your terminal to generate the serialization code.

```bash
dart run build_runner build --delete-conflicting-outputs
```

This will create the `user.easy.dart` file in the configured output directory.

### Step 3: Use Your Model

You can now seamlessly serialize and deserialize your objects.

```dart
void main() {
  final user = User(
    userName: 'John Doe',
    createdAt: DateTime.now(),
    email: 'john.doe@example.com',
  );

  // Serialization (uses the `toJson` method from the UserSerializer mixin)
  final Map<String, dynamic> jsonMap = user.toJson();
  print(jsonMap);
  // Output: {'user_name': 'John Doe', 'created_at': '...', 'e_mail': '...'}

  // Deserialization (uses the factory constructor)
  final userFromJson = User.fromJson(jsonMap);
  print(userFromJson.userName); // Output: John Doe
}
```

## 4. Safe Deserialization and Validation

A core strength of `easy_json` is its robust error handling.

### `fromJsonSafe` and `EasyIssue`

The `fromJsonSafe` method **never throws an exception**. Instead, it uses fallback values for any invalid or missing fields and reports all problems through the optional `onIssue` callback.

Each problem is reported as an `EasyIssue` object:

```dart
class EasyIssue {
  final String path;   // JSON path to the problematic field (e.g., "items[2].price")
  final String code;   // A machine-readable error code (e.g., "type_mismatch", "min_length")
  final String message; // A human-readable description of the issue.
}
```

**Example:**

```dart
final badJson = {
  'user_name': 'Te', // Fails validation (too short)
  // 'created_at' is missing (required field)
  'e_mail': 12345,   // Wrong type
};

final issues = <EasyIssue>[];

// Use fromJsonSafe to parse the invalid JSON
final user = User.fromJsonSafe(badJson, onIssue: issues.add);

// The 'user' object is still created successfully with fallback values:
// user.userName -> '' (default fallback for String)
// user.createdAt -> DateTime(0) (default fallback for DateTime)
// user.email -> null (since it's nullable)

print('Found ${issues.length} issues:');
for (final issue in issues) {
  print('- ${issue.path}: ${issue.code} (${issue.message})');
}
/* Output:
Found 3 issues:
- user_name: min_length (Value 'Te' must have at least 3 characters.)
- created_at: missing_required (Field is required but was not found.)
- e_mail: type_mismatch (Expected a value of type String, but got a value of type int.)
*/
```

### Standalone Validation

If you only need to validate a JSON payload without the overhead of creating an object, use the static `validate` method from the generated companion class (`UserJson`).

```dart
final problems = UserJson.validate(badJson);

if (problems.isNotEmpty) {
  print('The JSON is invalid!');
  // ... handle errors ...
}
```

## 5. Declarative Validation with `@EasyValidate`

Define powerful validation rules directly on your model fields. These are automatically checked by `fromJsonSafe` and `validate`.

```dart
@EasyJson()
class Product {
  @EasyValidate(minLength: 3, maxLength: 50)
  final String name;

  @EasyValidate(min: 0, max: 9999.99)
  final double price;

  @EasyValidate(format: EasyFormat.uuid)
  final String sku;

  @EasyValidate(past: true)
  final DateTime? listedDate;

  @EasyValidate(custom: MyValidators.isStockAvailable)
  final int stock;

  // ... constructor and factories ...
}

// Custom validation functions must be static or top-level.
class MyValidators {
  static bool isStockAvailable(int stock) => stock >= 0;
}
```

#### Supported Validation Rules

*   **For `String`, `List`, `Set`, `Map`**:
    *   `minLength`, `maxLength`
*   **For `num` (`int`, `double`)**:
    *   `min`, `max`
*   **For `String`**:
    *   `regex`: A regular expression pattern.
    *   `format`: Pre-defined formats like `EasyFormat.email`, `EasyFormat.url`, `EasyFormat.uuid`.
*   **For `DateTime`**:
    *   `past`: The date must be in the past.
    *   `future`: The date must be in the future.
*   **For any type**:
    *   `custom`: A `bool Function(T value)` that returns `true` if the value is valid.

## 6. Class Inheritance (Clean Architecture / DDD)

`easy_json` seamlessly supports class inheritance. If you use an architecture where you have base Entities and need to create a Model to process the API JSON, the inherited attributes from the parent class will be read and mapped automatically.

```dart
class UserEntity {
  final String emailAddress;
  UserEntity({required this.emailAddress});
}

@EasyJson(caseStyle: CaseStyle.snake)
class UserModel extends UserEntity with UserModelSerializer {
  // The emailAddress field will be automatically serialized as "email_address" 
  // due to the caseStyle declared in the child class's @EasyJson annotation.
  
  UserModel({
    required super.emailAddress,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => userModelFromJson(json);
}
```

### Applying Annotations to Inherited Fields

If the global behavior (like `caseStyle`) is not enough and you need to apply a specific annotation to an inherited attribute (e.g., a custom key name or field validation), simply `@override` this field in the child class and annotate it there:

```dart
@EasyJson()
class UserModel extends UserEntity with UserModelSerializer {
  @override
  @EasyKey(name: 'custom_email_address')
  final String emailAddress;

  UserModel({
    required this.emailAddress,
  }) : super(emailAddress: emailAddress);

  factory UserModel.fromJson(Map<String, dynamic> json) => userModelFromJson(json);
}
```

## 7. Advanced Customization

### `@EasyKey` Annotation

Use `@EasyKey` to control field-specific behavior:
*   `name`: Overrides the JSON key name (e.g., `@EasyKey(name: '_id')`).
*   `includeIfNull`: Overrides the class-level `includeIfNull` setting for this field.
*   `fallback`: Provides a specific fallback value for `fromJsonSafe` (e.g., `@EasyKey(fallback: -1)`).
*   `itemFallback`: Provides a fallback for items in a collection (`List`, `Set`, `Map`).
*   `enumFallback`: The `name` of the enum value to use as a fallback.

### `@EasyIgnore` Annotation

Use `@EasyIgnore` to exclude a field from both serialization (`toJson`) and deserialization (`fromJson`).

```dart
@EasyJson()
class User {
  final String username;

  @EasyIgnore()
  final String internalSecret; // Will not be read from or written to JSON

  User({required this.username, this.internalSecret = ''});
}
```

### `@EasyPath` Annotation

Use `@EasyPath` to map a field directly to a nested value in the JSON structure using dot notation. This is useful for flattening complex JSON responses without creating intermediate classes.

```dart
@EasyJson()
class Product {
  // Maps to json['meta']['stock']['count']
  @EasyPath('meta.stock.count')
  final int stockCount;

  Product({required this.stockCount});
}
```

### `@EasyConvert` Annotation

For complex types or custom formats, use `@EasyConvert` to provide your own `fromJson` and `toJson` functions.

```dart
class MillisecondsSinceEpochConverter {
  static DateTime fromJson(int ms) => DateTime.fromMillisecondsSinceEpoch(ms, isUtc: true);
  static int toJson(DateTime dt) => dt.millisecondsSinceEpoch;
}

@EasyJson()
class Order {
  @EasyConvert(
    fromJson: MillisecondsSinceEpochConverter.fromJson,
    toJson: MillisecondsSinceEpochConverter.toJson
  )
  final DateTime createdAt;

  // ... constructor and factories ...
}
```