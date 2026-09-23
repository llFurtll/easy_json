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
import 'package:example/star_trek/simple_ref.dart';
import 'package:dart_easy_json/runtime.dart';
import 'package:example/star_trek/simple_ref.dart';

import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_easy_json/runtime.dart' as ej;

SimpleRef simpleRefFromJson(Map<String, dynamic> json) {
  return SimpleRef(
    uid: (json['uid'] as String?) ?? '',
    title: (json['title'] as String?) ?? '',
  );
}

Map<String, dynamic> simpleRefToJson(SimpleRef instance) {
  return <String, dynamic>{'uid': instance.uid, 'title': instance.title};
}

mixin SimpleRefSerializer {
  Map<String, dynamic> toJson() {
    return simpleRefToJson(this as SimpleRef);
  }
}

List<EasyIssue> simpleRefValidate(Map<String, dynamic> json) {
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
  if (!json.containsKey('title')) {
    issues.add(
      EasyIssue(
        path: 'title',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('title') && json['title'] == null) {
    issues.add(
      EasyIssue(
        path: 'title',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('title')) {
    final v = json['title'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'title',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  return issues;
}

SimpleRef simpleRefFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in simpleRefValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => SimpleRef(
    uid: (() {
      final v = json['uid'];
      return (v is String) ? v : '';
    })(),
    title: (() {
      final v = json['title'];
      return (v is String) ? v : '';
    })(),
  ))(_report);
}

class SimpleRefJson {
  const SimpleRefJson();

  static SimpleRef fromJson(Map<String, dynamic> json) {
    return simpleRefFromJson(json);
  }

  static SimpleRef fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return simpleRefFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return simpleRefValidate(json);
  }
}

List<SimpleRef> simpleRefFromJsonList(List<dynamic> json) =>
    json.map((e) => simpleRefFromJson(e as Map<String, dynamic>)).toList();

List<SimpleRef> simpleRefFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => simpleRefFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> simpleRefToJsonList(List<SimpleRef> items) =>
    items.map((e) => simpleRefToJson(e)).toList();
