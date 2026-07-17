## 0.8.1

*   **FIX**: Fixed static analysis lint issues (`curly_braces_in_flow_control_structures`) in `uint8list_strategy.dart` to achieve full 50/50 on static analysis.
*   **CHORE**: Updated `analyzer` dependency constraint from `^8.1.1` to `>=8.1.1 <15.0.0` to support the latest stable version and achieve full 40/40 on up-to-date dependencies.
*   **GOAL**: Achieve 160/160 pub points on pub.dev.

## 0.8.0

*   **FEAT**: Added `@EasyUnion` annotation for Polymorphic JSON Serialization. Supports seamless serialization and deserialization of sealed classes/abstract interfaces based on a discriminator field.
*   **FEAT**: Support for union type fallbacks. Unknown union types can optionally fallback to a default type without throwing exceptions during validation.

## 0.7.0

*   **FEAT**: Added native support for `Uint8List` (Binary Data). `easy_json` now automatically serializes/deserializes `Uint8List` fields to/from Base64 strings.
*   **FEAT**: Added `fromJson` and `toJson` flags to the `@EasyJson` annotation to support read-only (API responses) and write-only (API requests) models, avoiding dead code generation.
*   **REFACTOR**: Removed the `flutter` SDK dependency. The package is now a pure Dart package, enabling usage in CLI, server-side, and other non-Flutter Dart environments.
*   **I18N**: Standardized all fallback and hardcoded error messages to English.
*   **CHORE**: Fixed `analyzer` experimental member use warnings in the code generator.

## 0.6.0

*   **FEAT**: Added support for class inheritance. The `EasyJson` generator now navigates through superclasses to automatically detect and include inherited fields in the serialization methods.
*   **FEAT**: Added support for the `@override` pattern on parent variables, allowing custom annotations like `@EasyKey` or `@EasyValidate` to be applied to inherited fields.

## 0.5.0

*   **FEAT**: Added `@EasyIgnore` annotation to exclude specific fields from serialization and deserialization.
*   **FEAT**: Added `@EasyPath` annotation to map fields directly to nested JSON keys (e.g., `client.address.city`), eliminating the need for intermediate classes.
*   **FIX**: Updated `fromJsonSafe` validation logic to correctly report errors for missing or invalid fields located at nested paths defined by `@EasyPath`.

## 0.4.2

* **FIX**: Enhanced `fromJsonSafe` generation strategy for fields using `@EasyConvert`.
    * Now implements a smart fallback mechanism: if the custom converter throws an exception (e.g., strict type mismatch), the generator attempts to use the library's native robust parsing logic (supporting ISO-8601 for DateTime, numeric coercion, etc.) before reverting to the default fallback value.
    * This ensures that valid data (like an ISO String) is not discarded even if the custom converter (e.g., `TmDateMs`) strictly expects an `int`.

## 0.4.1

*   **DOCS**: Significantly improved and corrected the `README.md` file with clearer instructions, accurate configuration examples, and better explanations of all features.

## 0.4.0

*   **FEAT**: Added `@EasyValidate` annotation for powerful, declarative validation.
    *   Supports `minLength`, `maxLength` for Strings and Collections.
    *   Supports `min`, `max` for numbers.
    *   Supports `regex` for custom string patterns.
    *   Supports pre-defined `format` validation for `email`, `url`, and `uuid`.
    *   Supports `DateTime` validation with `past` and `future` checks.
    *   Supports `custom` validation with user-defined functions for maximum flexibility.
*   **I18N**: All default validation and error messages are now in English, making the library more universal.
*   **FIX**: The code generator now correctly resolves and imports custom validators, enums, and converters defined in separate files.

## 0.3.0

*   **FEAT**: The generator now respects the `build_extensions` configuration defined in `build.yaml`. This allows users to customize the output directory for generated files (e.g., `lib/generated/`), and the `import`s in the `.easy.dart` files will be created correctly, pointing to the configured location.
*   **DOCS**: Added a section to `README.md` explaining how to exclude generated files from static analysis in `analysis_options.yaml`, improving the developer experience.

## 0.2.0

*   Initial version of the package with the main features of serialization, safe deserialization, and validation.