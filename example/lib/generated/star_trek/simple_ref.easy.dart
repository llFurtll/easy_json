// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// EasyJsonGenerator
// **************************************************************************

// ignore_for_file: type=lint
import 'package:easy_json/src/easy_issue.dart';
import 'package:example/star_trek/simple_ref.dart';
import 'package:easy_json/src/runtime.dart' as ej;
import 'package:easy_json/src/messages.dart';

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
  if (!json.containsKey('title')) {
    issues.add(
      EasyIssue(
        path: 'title',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.',
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
          message: 'Esperado String.',
        ),
      );
    }
  }
  return issues;
}

SimpleRef simpleRefFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  if (runValidate) {
    final _issues = simpleRefValidate(json);
    if (onIssue != null) {
      for (final i in _issues) onIssue(i);
    }
  }
  return SimpleRef(
    uid: (() {
      final v = json['uid'];
      return (v is String) ? v : '';
    })(),
    title: (() {
      final v = json['title'];
      return (v is String) ? v : '';
    })(),
  );
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
