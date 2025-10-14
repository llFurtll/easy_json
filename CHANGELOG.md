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