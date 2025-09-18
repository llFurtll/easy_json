// lib/src/easy_issue.dart
class EasyIssue {
  final String path;     // ex: 'address.street' ou 'user_age'
  final String code;     // ex: 'missing_required' | 'type_mismatch' | 'invalid_enum' | 'nested_error'
  final String message;  // explicação humana

  const EasyIssue({required this.path, required this.code, required this.message});

  @override
  String toString() => '[$code] $path: $message';
}
