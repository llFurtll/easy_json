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
import 'package:example/generated/star_trek/episode.easy.dart';
import 'package:example/generated/star_trek/series.easy.dart';
import 'package:example/star_trek/episode.dart';
import 'package:example/star_trek/seasson.dart';
import 'package:example/star_trek/series.dart';
import 'package:dart_easy_json/src/runtime.dart' as ej;
import 'package:dart_easy_json/src/messages.dart';

Season seasonFromJson(Map<String, dynamic> json) {
  return Season(
    uid: (json['uid'] as String?) ?? '',
    title: (json['title'] as String?) ?? '',
    series: seriesFromJson(json['series'] as Map<String, dynamic>),
    seasonNumber: (json['seasonNumber'] as int?) ?? 0,
    numberOfEpisodes: (json['numberOfEpisodes'] as int?) ?? 0,
    episodes:
        ((json['episodes'] as List?)?.asMap().entries.map<Episode>((entry) {
          final i = entry.key;
          final e = entry.value;
          return episodeFromJson(Map<String, dynamic>.from(e as Map));
        }).toList()) ??
        const <Episode>[],
  );
}

Map<String, dynamic> seasonToJson(Season instance) {
  return <String, dynamic>{
    'uid': instance.uid,
    'title': instance.title,
    'series': instance.series.toJson(),
    'seasonNumber': instance.seasonNumber,
    'numberOfEpisodes': instance.numberOfEpisodes,
    'episodes': instance.episodes.map((e) => e.toJson()).toList(),
  };
}

mixin SeasonSerializer {
  Map<String, dynamic> toJson() {
    return seasonToJson(this as Season);
  }
}

List<EasyIssue> seasonValidate(Map<String, dynamic> json) {
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
          message: 'Esperado Map para Series.',
        ),
      );
    } else if (v is Map) {
      final child = seriesValidate(Map<String, dynamic>.from(v));
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
  if (!json.containsKey('numberOfEpisodes')) {
    issues.add(
      EasyIssue(
        path: 'numberOfEpisodes',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.',
      ),
    );
  }
  if (json.containsKey('numberOfEpisodes')) {
    final v = json['numberOfEpisodes'];
    if (v != null && v is! int) {
      issues.add(
        EasyIssue(
          path: 'numberOfEpisodes',
          code: 'type_mismatch',
          message: 'Esperado int.',
        ),
      );
    }
  }
  if (!json.containsKey('episodes')) {
    issues.add(
      EasyIssue(
        path: 'episodes',
        code: 'missing_required',
        message: 'Campo obrigatório ausente.',
      ),
    );
  }
  if (json.containsKey('episodes')) {
    final v = json['episodes'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'episodes',
          code: 'type_mismatch',
          message: 'Esperado List.',
        ),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'episodes[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Valor nulo não permitido.',
            ),
          );
        } else {
          if (e is! Map) {
            issues.add(
              EasyIssue(
                path: 'episodes[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Esperado Map para Episode.',
              ),
            );
          } else {
            final child = episodeValidate(Map<String, dynamic>.from(e as Map));
            for (final ci in child) {
              issues.add(
                EasyIssue(
                  path: 'episodes[' + i.toString() + '].' + ci.path,
                  code: ci.code,
                  message: ci.message,
                ),
              );
            }
          }
        }
      }
    }
  }

  return issues;
}

Season seasonFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  if (runValidate) {
    final _issues = seasonValidate(json);
    if (onIssue != null) {
      for (final i in _issues) onIssue(i);
    }
  }
  return Season(
    uid: (() {
      final v = json['uid'];
      return (v is String) ? v : '';
    })(),
    title: (() {
      final v = json['title'];
      return (v is String) ? v : '';
    })(),
    series: (() {
      final _v = json['series'];
      if (_v == null)
        return seriesFromJsonSafe(
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
        return seriesFromJsonSafe(
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
      return seriesFromJsonSafe(
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
    seasonNumber: (() {
      final v = json['seasonNumber'];
      return (v is int) ? v : 0;
    })(),
    numberOfEpisodes: (() {
      final v = json['numberOfEpisodes'];
      return (v is int) ? v : 0;
    })(),
    episodes: (() {
      final _v = json['episodes'];
      if (_v is! List) return const <Episode>[];
      final _list = _v;
      return _list.asMap().entries.map<Episode>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final _v = entry.value;
          if (_v is Map) {
            return episodeFromJsonSafe(
              Map<String, dynamic>.from(_v as Map),
              onIssue: (i) => onIssue?.call(
                EasyIssue(
                  path:
                      'episodes' +
                      '[' +
                      entry.key.toString() +
                      ']' +
                      '.' +
                      i.path,
                  code: i.code,
                  message: i.message,
                ),
              ),
              runValidate: false,
            );
          }
          onIssue?.call(
            EasyIssue(
              path: 'episodes' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Esperado Map para Episode.',
            ),
          );
          return episodeFromJsonSafe(
            const <String, dynamic>{},
            onIssue: (i) => onIssue?.call(
              EasyIssue(
                path:
                    'episodes' +
                    '[' +
                    entry.key.toString() +
                    ']' +
                    '.' +
                    i.path,
                code: i.code,
                message: i.message,
              ),
            ),
            runValidate: false,
          );
        })();
      }).toList();
    })(),
  );
}

class SeasonJson {
  const SeasonJson();

  static Season fromJson(Map<String, dynamic> json) {
    return seasonFromJson(json);
  }

  static Season fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return seasonFromJsonSafe(json, onIssue: onIssue, runValidate: runValidate);
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return seasonValidate(json);
  }
}
