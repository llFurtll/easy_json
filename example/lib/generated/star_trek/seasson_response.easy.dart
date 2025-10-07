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
import 'package:example/generated/star_trek/seasson.easy.dart';
import 'package:example/star_trek/seasson.dart';
import 'package:example/star_trek/seasson_response.dart';
import 'package:dart_easy_json/src/runtime.dart' as ej;
import 'package:dart_easy_json/src/messages.dart';

SeasonResponse seasonResponseFromJson(Map<String, dynamic> json) {
  return SeasonResponse(
    season: seasonFromJson(json['season'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> seasonResponseToJson(SeasonResponse instance) {
  return <String, dynamic>{'season': instance.season.toJson()};
}

mixin SeasonResponseSerializer {
  Map<String, dynamic> toJson() {
    return seasonResponseToJson(this as SeasonResponse);
  }
}

List<EasyIssue> seasonResponseValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('season')) {
    issues.add(
      EasyIssue(
        path: 'season',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.',
      ),
    );
  }
  if (json.containsKey('season')) {
    final v = json['season'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(
          path: 'season',
          code: 'type_mismatch',
          message: 'Esperado Map para Season.',
        ),
      );
    } else if (v is Map) {
      final child = seasonValidate(Map<String, dynamic>.from(v));
      for (final ci in child) {
        issues.add(
          EasyIssue(
            path: 'season.' + ci.path,
            code: ci.code,
            message: ci.message,
          ),
        );
      }
    }
  }

  return issues;
}

SeasonResponse seasonResponseFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  if (runValidate) {
    final _issues = seasonResponseValidate(json);
    if (onIssue != null) {
      for (final i in _issues) onIssue(i);
    }
  }
  return SeasonResponse(
    season: (() {
      final _v = json['season'];
      if (_v == null)
        return seasonFromJsonSafe(
          const <String, dynamic>{},
          onIssue: (i) => onIssue?.call(
            EasyIssue(
              path: 'season' + '.' + i.path,
              code: i.code,
              message: i.message,
            ),
          ),
          runValidate: false,
        );
      if (_v is Map) {
        return seasonFromJsonSafe(
          Map<String, dynamic>.from(_v as Map),
          onIssue: (i) => onIssue?.call(
            EasyIssue(
              path: 'season' + '.' + i.path,
              code: i.code,
              message: i.message,
            ),
          ),
          runValidate: false,
        );
      }
      return seasonFromJsonSafe(
        const <String, dynamic>{},
        onIssue: (i) => onIssue?.call(
          EasyIssue(
            path: 'season' + '.' + i.path,
            code: i.code,
            message: i.message,
          ),
        ),
        runValidate: false,
      );
    })(),
  );
}

class SeasonResponseJson {
  const SeasonResponseJson();

  static SeasonResponse fromJson(Map<String, dynamic> json) {
    return seasonResponseFromJson(json);
  }

  static SeasonResponse fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return seasonResponseFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return seasonResponseValidate(json);
  }
}
