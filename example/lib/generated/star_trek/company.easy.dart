// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// EasyJsonGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// EasyJsonGenerator
// **************************************************************************

// ignore_for_file: type=lint
import 'package:dart_easy_json/src/easy_issue.dart';
import 'package:example/star_trek/company.dart';
import 'package:dart_easy_json/src/runtime.dart' as ej;
import 'package:dart_easy_json/src/messages.dart';

Company companyFromJson(Map<String, dynamic> json) {
  return Company(
    uid: (json['uid'] as String?) ?? '',
    name: (json['name'] as String?) ?? '',
  );
}

Map<String, dynamic> companyToJson(Company instance) {
  return <String, dynamic>{'uid': instance.uid, 'name': instance.name};
}

mixin CompanySerializer {
  Map<String, dynamic> toJson() {
    return companyToJson(this as Company);
  }
}

List<EasyIssue> companyValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('uid')) {
    issues.add(
      EasyIssue(
        path: 'uid',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.',
      ),
    );
  }
  if (json.containsKey('uid')) {
    final v = json['uid'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'uid',
          code: 'type_mismatch',
          message: 'Esperado String.',
        ),
      );
    }
  }
  if (!json.containsKey('name')) {
    issues.add(
      EasyIssue(
        path: 'name',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.',
      ),
    );
  }
  if (json.containsKey('name')) {
    final v = json['name'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'name',
          code: 'type_mismatch',
          message: 'Esperado String.',
        ),
      );
    }
  }
  return issues;
}

Company companyFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  if (runValidate) {
    final _issues = companyValidate(json);
    if (onIssue != null) {
      for (final i in _issues) onIssue(i);
    }
  }
  return Company(
    uid: (() {
      final v = json['uid'];
      return (v is String) ? v : '';
    })(),
    name: (() {
      final v = json['name'];
      return (v is String) ? v : '';
    })(),
  );
}

class CompanyJson {
  const CompanyJson();

  static Company fromJson(Map<String, dynamic> json) {
    return companyFromJson(json);
  }

  static Company fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return companyFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return companyValidate(json);
  }
}
