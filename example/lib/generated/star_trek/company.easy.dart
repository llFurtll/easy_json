// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// EasyJsonGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// EasyJsonGenerator
// **************************************************************************

// ignore_for_file: type=lint, unused_import, unnecessary_cast, unused_local_variable, duplicate_import
import 'package:example/star_trek/company.dart';
import 'package:dart_easy_json/runtime.dart';
import 'package:example/star_trek/company.dart';

import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_easy_json/runtime.dart' as ej;

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
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('uid') && json['uid'] == null) {
    issues.add(
      EasyIssue(
        path: 'uid',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
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
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  if (!json.containsKey('name')) {
    issues.add(
      EasyIssue(
        path: 'name',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('name') && json['name'] == null) {
    issues.add(
      EasyIssue(
        path: 'name',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
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
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  return issues;
}

Company companyFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in companyValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Company(
    uid: (() {
      final v = json['uid'];
      return (v is String) ? v : '';
    })(),
    name: (() {
      final v = json['name'];
      return (v is String) ? v : '';
    })(),
  ))(_report);
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

List<Company> companyFromJsonList(List<dynamic> json) =>
    json.map((e) => companyFromJson(e as Map<String, dynamic>)).toList();

List<Company> companyFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => companyFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> companyToJsonList(List<Company> items) =>
    items.map((e) => companyToJson(e)).toList();
