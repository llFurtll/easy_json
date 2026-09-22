/// A single problem found while parsing or validating a JSON payload.
///
/// Returned (never thrown) by the generated `fromJsonSafe` and `validate`
/// functions, so a payload can be inspected for every problem at once instead
/// of failing on the first one.
class EasyIssue {
  /// The field's JSON path, e.g. `'address.street'` or, inside a list/map,
  /// `'items[2].street'` / `'items.someKey'`.
  final String path;

  /// A short, stable machine-readable code identifying the kind of problem,
  /// e.g. `'missing_required'`, `'type_mismatch'`, `'invalid_enum'`,
  /// `'min_length'`, `'max_length'`, `'regex_mismatch'`, `'invalid_email'`,
  /// `'invalid_url'`, `'invalid_uuid'`, `'min_value'`, `'max_value'`,
  /// `'custom_validation_failed'`, `'invalid_base64'`, `'invalid_uri'`,
  /// `'invalid_bigint'`, `'must_be_past'`, `'must_be_future'` or
  /// `'unknown_union_type'`. Safe to switch on.
  final String code;

  /// A human-readable explanation, in English, suitable for logs or as a
  /// starting point for a user-facing message.
  final String message;

  const EasyIssue({required this.path, required this.code, required this.message});

  @override
  String toString() => '[$code] $path: $message';
}
