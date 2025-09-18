// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// EasyJsonGenerator
// **************************************************************************

// ignore_for_file: type=lint
import 'package:easy_json/src/easy_issue.dart';
import 'package:example/generated/star_trek/company.easy.dart';
import 'package:example/star_trek/company.dart';
import 'package:example/star_trek/series.dart';
import 'package:easy_json/src/runtime.dart' as ej;
import 'package:easy_json/src/messages.dart';

Series seriesFromJson(Map<String, dynamic> json) {
  return Series(
    uid: (json['uid'] as String?) ?? '',
    title: (json['title'] as String?) ?? '',
    abbreviation: json['abbreviation'] as String?,
    originalRunStartDate: ej.parseDateTimeOrNull(json['originalRunStartDate']),
    originalRunEndDate: ej.parseDateTimeOrNull(json['originalRunEndDate']),
    productionStartYear: json['productionStartYear'] as int?,
    productionEndYear: json['productionEndYear'] as int?,
    seasonsCount: json['seasonsCount'] as int?,
    episodesCount: json['episodesCount'] as int?,
    featureLengthEpisodesCount: json['featureLengthEpisodesCount'] as int?,
    productionCompany: json['productionCompany'] == null
        ? null
        : companyFromJson(json['productionCompany'] as Map<String, dynamic>),
    originalBroadcaster: json['originalBroadcaster'] == null
        ? null
        : companyFromJson(json['originalBroadcaster'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> seriesToJson(Series instance) {
  return <String, dynamic>{
    'uid': instance.uid,
    'title': instance.title,
    if (instance.abbreviation != null) 'abbreviation': instance.abbreviation,
    if (instance.originalRunStartDate != null)
      'originalRunStartDate': instance.originalRunStartDate?.toIso8601String(),
    if (instance.originalRunEndDate != null)
      'originalRunEndDate': instance.originalRunEndDate?.toIso8601String(),
    if (instance.productionStartYear != null)
      'productionStartYear': instance.productionStartYear,
    if (instance.productionEndYear != null)
      'productionEndYear': instance.productionEndYear,
    if (instance.seasonsCount != null) 'seasonsCount': instance.seasonsCount,
    if (instance.episodesCount != null) 'episodesCount': instance.episodesCount,
    if (instance.featureLengthEpisodesCount != null)
      'featureLengthEpisodesCount': instance.featureLengthEpisodesCount,
    if (instance.productionCompany != null)
      'productionCompany': instance.productionCompany?.toJson(),
    if (instance.originalBroadcaster != null)
      'originalBroadcaster': instance.originalBroadcaster?.toJson(),
  };
}

mixin SeriesSerializer {
  Map<String, dynamic> toJson() {
    return seriesToJson(this as Series);
  }
}

List<EasyIssue> seriesValidate(Map<String, dynamic> json) {
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
  if (json.containsKey('abbreviation')) {
    final v = json['abbreviation'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'abbreviation',
          code: 'type_mismatch',
          message: 'Esperado String.',
        ),
      );
    }
  }
  if (json.containsKey('originalRunStartDate')) {
    final v = json['originalRunStartDate'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'originalRunStartDate',
          code: 'type_mismatch',
          message: 'Esperado String (ISO-8601) para DateTime.',
        ),
      );
    } else if (v != null) {
      try {
        DateTime.parse(v as String);
      } catch (_) {
        issues.add(
          EasyIssue(
            path: 'originalRunStartDate',
            code: 'type_mismatch',
            message: 'Formato inválido de DateTime.',
          ),
        );
      }
    }
  }
  if (json.containsKey('originalRunEndDate')) {
    final v = json['originalRunEndDate'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'originalRunEndDate',
          code: 'type_mismatch',
          message: 'Esperado String (ISO-8601) para DateTime.',
        ),
      );
    } else if (v != null) {
      try {
        DateTime.parse(v as String);
      } catch (_) {
        issues.add(
          EasyIssue(
            path: 'originalRunEndDate',
            code: 'type_mismatch',
            message: 'Formato inválido de DateTime.',
          ),
        );
      }
    }
  }
  if (json.containsKey('productionStartYear')) {
    final v = json['productionStartYear'];
    if (v != null && v is! int) {
      issues.add(
        EasyIssue(
          path: 'productionStartYear',
          code: 'type_mismatch',
          message: 'Esperado int.',
        ),
      );
    }
  }
  if (json.containsKey('productionEndYear')) {
    final v = json['productionEndYear'];
    if (v != null && v is! int) {
      issues.add(
        EasyIssue(
          path: 'productionEndYear',
          code: 'type_mismatch',
          message: 'Esperado int.',
        ),
      );
    }
  }
  if (json.containsKey('seasonsCount')) {
    final v = json['seasonsCount'];
    if (v != null && v is! int) {
      issues.add(
        EasyIssue(
          path: 'seasonsCount',
          code: 'type_mismatch',
          message: 'Esperado int.',
        ),
      );
    }
  }
  if (json.containsKey('episodesCount')) {
    final v = json['episodesCount'];
    if (v != null && v is! int) {
      issues.add(
        EasyIssue(
          path: 'episodesCount',
          code: 'type_mismatch',
          message: 'Esperado int.',
        ),
      );
    }
  }
  if (json.containsKey('featureLengthEpisodesCount')) {
    final v = json['featureLengthEpisodesCount'];
    if (v != null && v is! int) {
      issues.add(
        EasyIssue(
          path: 'featureLengthEpisodesCount',
          code: 'type_mismatch',
          message: 'Esperado int.',
        ),
      );
    }
  }
  if (json.containsKey('productionCompany')) {
    final v = json['productionCompany'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(
          path: 'productionCompany',
          code: 'type_mismatch',
          message: 'Esperado Map para Company.',
        ),
      );
    } else if (v is Map) {
      final child = companyValidate(Map<String, dynamic>.from(v));
      for (final ci in child) {
        issues.add(
          EasyIssue(
            path: 'productionCompany.' + ci.path,
            code: ci.code,
            message: ci.message,
          ),
        );
      }
    }
  }

  if (json.containsKey('originalBroadcaster')) {
    final v = json['originalBroadcaster'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(
          path: 'originalBroadcaster',
          code: 'type_mismatch',
          message: 'Esperado Map para Company.',
        ),
      );
    } else if (v is Map) {
      final child = companyValidate(Map<String, dynamic>.from(v));
      for (final ci in child) {
        issues.add(
          EasyIssue(
            path: 'originalBroadcaster.' + ci.path,
            code: ci.code,
            message: ci.message,
          ),
        );
      }
    }
  }

  return issues;
}

Series seriesFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  if (runValidate) {
    final _issues = seriesValidate(json);
    if (onIssue != null) {
      for (final i in _issues) onIssue(i);
    }
  }
  return Series(
    uid: (() {
      final v = json['uid'];
      return (v is String) ? v : '';
    })(),
    title: (() {
      final v = json['title'];
      return (v is String) ? v : '';
    })(),
    abbreviation: (() {
      final v = json['abbreviation'];
      return (v is String) ? v : null;
    })(),
    originalRunStartDate: (() {
      final v = json['originalRunStartDate'];
      if (v == null) return null;
      if (v is DateTime) return v;
      if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
      if (v is num) return DateTime.fromMillisecondsSinceEpoch(v.toInt());
      if (v is String) {
        try {
          return DateTime.parse(v);
        } catch (_) {
          onIssue?.call(
            EasyIssue(
              path: 'originalRunStartDate',
              code: 'type_mismatch',
              message: 'Formato inválido de DateTime.',
            ),
          );
          return null;
        }
      }
      onIssue?.call(
        EasyIssue(
          path: 'originalRunStartDate',
          code: 'type_mismatch',
          message: 'Esperado String/epoch/DateTime.',
        ),
      );
      return null;
    })(),
    originalRunEndDate: (() {
      final v = json['originalRunEndDate'];
      if (v == null) return null;
      if (v is DateTime) return v;
      if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
      if (v is num) return DateTime.fromMillisecondsSinceEpoch(v.toInt());
      if (v is String) {
        try {
          return DateTime.parse(v);
        } catch (_) {
          onIssue?.call(
            EasyIssue(
              path: 'originalRunEndDate',
              code: 'type_mismatch',
              message: 'Formato inválido de DateTime.',
            ),
          );
          return null;
        }
      }
      onIssue?.call(
        EasyIssue(
          path: 'originalRunEndDate',
          code: 'type_mismatch',
          message: 'Esperado String/epoch/DateTime.',
        ),
      );
      return null;
    })(),
    productionStartYear: (() {
      final v = json['productionStartYear'];
      return (v is int) ? v : 0;
    })(),
    productionEndYear: (() {
      final v = json['productionEndYear'];
      return (v is int) ? v : 0;
    })(),
    seasonsCount: (() {
      final v = json['seasonsCount'];
      return (v is int) ? v : 0;
    })(),
    episodesCount: (() {
      final v = json['episodesCount'];
      return (v is int) ? v : 0;
    })(),
    featureLengthEpisodesCount: (() {
      final v = json['featureLengthEpisodesCount'];
      return (v is int) ? v : 0;
    })(),
    productionCompany: (() {
      final _v = json['productionCompany'];
      if (_v == null) return null;
      if (_v is Map) {
        return companyFromJsonSafe(
          Map<String, dynamic>.from(_v as Map),
          onIssue: (i) => onIssue?.call(
            EasyIssue(
              path: 'productionCompany' + '.' + i.path,
              code: i.code,
              message: i.message,
            ),
          ),
          runValidate: false,
        );
      }
      return null;
    })(),
    originalBroadcaster: (() {
      final _v = json['originalBroadcaster'];
      if (_v == null) return null;
      if (_v is Map) {
        return companyFromJsonSafe(
          Map<String, dynamic>.from(_v as Map),
          onIssue: (i) => onIssue?.call(
            EasyIssue(
              path: 'originalBroadcaster' + '.' + i.path,
              code: i.code,
              message: i.message,
            ),
          ),
          runValidate: false,
        );
      }
      return null;
    })(),
  );
}

class SeriesJson {
  const SeriesJson();

  static Series fromJson(Map<String, dynamic> json) {
    return seriesFromJson(json);
  }

  static Series fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return seriesFromJsonSafe(json, onIssue: onIssue, runValidate: runValidate);
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return seriesValidate(json);
  }
}
