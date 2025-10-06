// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// EasyJsonGenerator
// **************************************************************************

// ignore_for_file: type=lint
import 'package:dart_easy_json/src/easy_issue.dart';
import 'package:example/generated/star_trek/simple_ref.easy.dart';
import 'package:example/star_trek/episode.dart';
import 'package:example/star_trek/simple_ref.dart';
import 'package:dart_easy_json/src/runtime.dart' as ej;
import 'package:dart_easy_json/src/messages.dart';

Episode episodeFromJson(Map<String, dynamic> json) {
  return Episode(
    uid: (json['uid'] as String?) ?? '',
    title: (json['title'] as String?) ?? '',
    titleGerman: json['titleGerman'] as String?,
    titleItalian: json['titleItalian'] as String?,
    titleJapanese: json['titleJapanese'] as String?,
    series: simpleRefFromJson(json['series'] as Map<String, dynamic>),
    season: simpleRefFromJson(json['season'] as Map<String, dynamic>),
    seasonNumber: (json['seasonNumber'] as int?) ?? 0,
    episodeNumber: (json['episodeNumber'] as int?) ?? 0,
    productionSerialNumber: json['productionSerialNumber'] as String?,
    featureLength: json['featureLength'] as bool?,
    stardateFrom: (json['stardateFrom'] as num?)?.toDouble(),
    stardateTo: (json['stardateTo'] as num?)?.toDouble(),
    yearFrom: json['yearFrom'] as int?,
    yearTo: json['yearTo'] as int?,
    usAirDate: ej.parseDateTimeOrNull(json['usAirDate']),
    finalScriptDate: json['finalScriptDate'] as String?,
  );
}

Map<String, dynamic> episodeToJson(Episode instance) {
  return <String, dynamic>{
    'uid': instance.uid,
    'title': instance.title,
    if (instance.titleGerman != null) 'titleGerman': instance.titleGerman,
    if (instance.titleItalian != null) 'titleItalian': instance.titleItalian,
    if (instance.titleJapanese != null) 'titleJapanese': instance.titleJapanese,
    'series': instance.series.toJson(),
    'season': instance.season.toJson(),
    'seasonNumber': instance.seasonNumber,
    'episodeNumber': instance.episodeNumber,
    if (instance.productionSerialNumber != null)
      'productionSerialNumber': instance.productionSerialNumber,
    if (instance.featureLength != null) 'featureLength': instance.featureLength,
    if (instance.stardateFrom != null) 'stardateFrom': instance.stardateFrom,
    if (instance.stardateTo != null) 'stardateTo': instance.stardateTo,
    if (instance.yearFrom != null) 'yearFrom': instance.yearFrom,
    if (instance.yearTo != null) 'yearTo': instance.yearTo,
    if (instance.usAirDate != null)
      'usAirDate': instance.usAirDate?.toIso8601String(),
    if (instance.finalScriptDate != null)
      'finalScriptDate': instance.finalScriptDate,
  };
}

mixin EpisodeSerializer {
  Map<String, dynamic> toJson() {
    return episodeToJson(this as Episode);
  }
}

List<EasyIssue> episodeValidate(Map<String, dynamic> json) {
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
  if (json.containsKey('titleGerman')) {
    final v = json['titleGerman'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'titleGerman',
          code: 'type_mismatch',
          message: 'Esperado String.',
        ),
      );
    }
  }
  if (json.containsKey('titleItalian')) {
    final v = json['titleItalian'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'titleItalian',
          code: 'type_mismatch',
          message: 'Esperado String.',
        ),
      );
    }
  }
  if (json.containsKey('titleJapanese')) {
    final v = json['titleJapanese'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'titleJapanese',
          code: 'type_mismatch',
          message: 'Esperado String.',
        ),
      );
    }
  }
  if (!json.containsKey('series')) {
    issues.add(
      EasyIssue(
        path: 'series',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.',
      ),
    );
  }
  if (json.containsKey('series')) {
    final v = json['series'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(
          path: 'series',
          code: 'type_mismatch',
          message: 'Esperado Map para SimpleRef.',
        ),
      );
    } else if (v is Map) {
      final child = simpleRefValidate(Map<String, dynamic>.from(v));
      for (final ci in child) {
        issues.add(
          EasyIssue(
            path: 'series.' + ci.path,
            code: ci.code,
            message: ci.message,
          ),
        );
      }
    }
  }

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
          message: 'Esperado Map para SimpleRef.',
        ),
      );
    } else if (v is Map) {
      final child = simpleRefValidate(Map<String, dynamic>.from(v));
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

  if (!json.containsKey('seasonNumber')) {
    issues.add(
      EasyIssue(
        path: 'seasonNumber',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.',
      ),
    );
  }
  if (json.containsKey('seasonNumber')) {
    final v = json['seasonNumber'];
    if (v != null && v is! int) {
      issues.add(
        EasyIssue(
          path: 'seasonNumber',
          code: 'type_mismatch',
          message: 'Esperado int.',
        ),
      );
    }
  }
  if (!json.containsKey('episodeNumber')) {
    issues.add(
      EasyIssue(
        path: 'episodeNumber',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.',
      ),
    );
  }
  if (json.containsKey('episodeNumber')) {
    final v = json['episodeNumber'];
    if (v != null && v is! int) {
      issues.add(
        EasyIssue(
          path: 'episodeNumber',
          code: 'type_mismatch',
          message: 'Esperado int.',
        ),
      );
    }
  }
  if (json.containsKey('productionSerialNumber')) {
    final v = json['productionSerialNumber'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'productionSerialNumber',
          code: 'type_mismatch',
          message: 'Esperado String.',
        ),
      );
    }
  }
  if (json.containsKey('featureLength')) {
    final v = json['featureLength'];
    if (v != null && v is! bool) {
      issues.add(
        EasyIssue(
          path: 'featureLength',
          code: 'type_mismatch',
          message: 'Esperado bool.',
        ),
      );
    }
  }
  if (json.containsKey('stardateFrom')) {
    final v = json['stardateFrom'];
    if (v != null && v is! num) {
      issues.add(
        EasyIssue(
          path: 'stardateFrom',
          code: 'type_mismatch',
          message: 'Esperado número (int/double).',
        ),
      );
    }
  }
  if (json.containsKey('stardateTo')) {
    final v = json['stardateTo'];
    if (v != null && v is! num) {
      issues.add(
        EasyIssue(
          path: 'stardateTo',
          code: 'type_mismatch',
          message: 'Esperado número (int/double).',
        ),
      );
    }
  }
  if (json.containsKey('yearFrom')) {
    final v = json['yearFrom'];
    if (v != null && v is! int) {
      issues.add(
        EasyIssue(
          path: 'yearFrom',
          code: 'type_mismatch',
          message: 'Esperado int.',
        ),
      );
    }
  }
  if (json.containsKey('yearTo')) {
    final v = json['yearTo'];
    if (v != null && v is! int) {
      issues.add(
        EasyIssue(
          path: 'yearTo',
          code: 'type_mismatch',
          message: 'Esperado int.',
        ),
      );
    }
  }
  if (json.containsKey('usAirDate')) {
    final v = json['usAirDate'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'usAirDate',
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
            path: 'usAirDate',
            code: 'type_mismatch',
            message: 'Formato inválido de DateTime.',
          ),
        );
      }
    }
  }
  if (json.containsKey('finalScriptDate')) {
    final v = json['finalScriptDate'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'finalScriptDate',
          code: 'type_mismatch',
          message: 'Esperado String.',
        ),
      );
    }
  }
  return issues;
}

Episode episodeFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  if (runValidate) {
    final _issues = episodeValidate(json);
    if (onIssue != null) {
      for (final i in _issues) onIssue(i);
    }
  }
  return Episode(
    uid: (() {
      final v = json['uid'];
      return (v is String) ? v : '';
    })(),
    title: (() {
      final v = json['title'];
      return (v is String) ? v : '';
    })(),
    titleGerman: (() {
      final v = json['titleGerman'];
      return (v is String) ? v : null;
    })(),
    titleItalian: (() {
      final v = json['titleItalian'];
      return (v is String) ? v : null;
    })(),
    titleJapanese: (() {
      final v = json['titleJapanese'];
      return (v is String) ? v : null;
    })(),
    series: (() {
      final _v = json['series'];
      if (_v == null)
        return simpleRefFromJsonSafe(
          const <String, dynamic>{},
          onIssue: (i) => onIssue?.call(
            EasyIssue(
              path: 'series' + '.' + i.path,
              code: i.code,
              message: i.message,
            ),
          ),
          runValidate: false,
        );
      if (_v is Map) {
        return simpleRefFromJsonSafe(
          Map<String, dynamic>.from(_v as Map),
          onIssue: (i) => onIssue?.call(
            EasyIssue(
              path: 'series' + '.' + i.path,
              code: i.code,
              message: i.message,
            ),
          ),
          runValidate: false,
        );
      }
      return simpleRefFromJsonSafe(
        const <String, dynamic>{},
        onIssue: (i) => onIssue?.call(
          EasyIssue(
            path: 'series' + '.' + i.path,
            code: i.code,
            message: i.message,
          ),
        ),
        runValidate: false,
      );
    })(),
    season: (() {
      final _v = json['season'];
      if (_v == null)
        return simpleRefFromJsonSafe(
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
        return simpleRefFromJsonSafe(
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
      return simpleRefFromJsonSafe(
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
    seasonNumber: (() {
      final v = json['seasonNumber'];
      return (v is int) ? v : 0;
    })(),
    episodeNumber: (() {
      final v = json['episodeNumber'];
      return (v is int) ? v : 0;
    })(),
    productionSerialNumber: (() {
      final v = json['productionSerialNumber'];
      return (v is String) ? v : null;
    })(),
    featureLength: (() {
      final v = json['featureLength'];
      return (v is bool) ? v : false;
    })(),
    stardateFrom: (() {
      final v = json['stardateFrom'];
      return (v is num) ? v.toDouble() : 0.0;
    })(),
    stardateTo: (() {
      final v = json['stardateTo'];
      return (v is num) ? v.toDouble() : 0.0;
    })(),
    yearFrom: (() {
      final v = json['yearFrom'];
      return (v is int) ? v : 0;
    })(),
    yearTo: (() {
      final v = json['yearTo'];
      return (v is int) ? v : 0;
    })(),
    usAirDate: (() {
      final v = json['usAirDate'];
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
              path: 'usAirDate',
              code: 'type_mismatch',
              message: 'Formato inválido de DateTime.',
            ),
          );
          return null;
        }
      }
      onIssue?.call(
        EasyIssue(
          path: 'usAirDate',
          code: 'type_mismatch',
          message: 'Esperado String/epoch/DateTime.',
        ),
      );
      return null;
    })(),
    finalScriptDate: (() {
      final v = json['finalScriptDate'];
      return (v is String) ? v : null;
    })(),
  );
}

class EpisodeJson {
  const EpisodeJson();

  static Episode fromJson(Map<String, dynamic> json) {
    return episodeFromJson(json);
  }

  static Episode fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return episodeFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return episodeValidate(json);
  }
}
