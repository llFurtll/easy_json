/// Annotations and runtime types for `dart_easy_json`.
///
/// Import this in the files where you declare your `@EasyJson` model
/// classes. It gives you the annotations (`EasyJson`, `EasyKey`,
/// `EasyValidate`, `EasyUnion`, `EasyConvert`, `EasyMapKey`, `EasyIgnore`,
/// `EasyPath`, `CaseStyle`, `EasyFormat`), [EasyIssue], used by
/// `fromJsonSafe` and `validate`, and [EasyValidationException], thrown by
/// the `fromJson` of `@EasyJson(strict: true)` classes.
///
/// Add `dart_easy_json` as a `dev_dependency` too and configure
/// `package:build_runner` to run the generator — see the package README for
/// the full setup.
library;

export 'src/annotations.dart';
export 'src/easy_issue.dart';
export 'src/easy_validation_exception.dart';
