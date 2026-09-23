import 'easy_issue.dart';

/// Thrown by the generated `fromJson` of a class annotated with
/// `@EasyJson(strict: true)` when the payload fails validation.
///
/// Carries **every** problem found (not just the first one), with the same
/// [EasyIssue]s that `validate` / `fromJsonSafe` would report.
class EasyValidationException implements Exception {
  /// All problems found in the payload. Never empty.
  final List<EasyIssue> issues;

  const EasyValidationException(this.issues);

  @override
  String toString() {
    final buf = StringBuffer(
      'EasyValidationException: ${issues.length} issue(s) found',
    );
    for (final issue in issues) {
      buf.write('\n  $issue');
    }
    return buf.toString();
  }
}
