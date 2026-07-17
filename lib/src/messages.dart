// lib/src/messages.dart
library;

class EasyMessages {
  static String missingRequired(String path) =>
    'Missing required field.';

  static String typeMismatch(String path, String expected) =>
    'Expected $expected.';

  static String invalidEnum(String path, String enumName, Object? got) =>
    "Value '$got' does not match $enumName.";

  static String nullNotAllowed(String path) =>
    'Null value not allowed.';

  static String keyTypeMismatch(String path) =>
    'Incompatible key type for map.';
}
