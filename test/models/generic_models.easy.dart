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
import 'generic_models.dart';
import 'generic_models.dart';
import 'generic_models.easy.dart';

import 'package:dart_easy_json/runtime.dart';

import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_easy_json/runtime.dart' as ej;

Item itemFromJson(Map<String, dynamic> json) {
  return Item(n: (json['n'] as int?) ?? 0);
}

Map<String, dynamic> itemToJson(Item instance) {
  return <String, dynamic>{'n': instance.n};
}

mixin ItemSerializer {
  Map<String, dynamic> toJson() {
    return itemToJson(this as Item);
  }
}

List<EasyIssue> itemValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('n')) {
    issues.add(
      EasyIssue(
        path: 'n',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('n') && json['n'] == null) {
    issues.add(
      EasyIssue(
        path: 'n',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('n')) {
    final v = json['n'];
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(path: 'n', code: 'type_mismatch', message: 'Expected int.'),
        );
      } else {
        final v = _n;
        if ((v as num) < 0) {
          issues.add(
            EasyIssue(
              path: 'n',
              code: 'min_value',
              message: 'The minimum value is 0.',
            ),
          );
        }
      }
    }
  }
  return issues;
}

Item itemFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in itemValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Item(
    n: (() {
      final v = json['n'];
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return p;
      }
      return 0;
    })(),
  ))(_report);
}

class ItemJson {
  const ItemJson();

  static Item fromJson(Map<String, dynamic> json) {
    return itemFromJson(json);
  }

  static Item fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return itemFromJsonSafe(json, onIssue: onIssue, runValidate: runValidate);
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return itemValidate(json);
  }
}

List<Item> itemFromJsonList(List<dynamic> json) =>
    json.map((e) => itemFromJson(e as Map<String, dynamic>)).toList();

List<Item> itemFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => itemFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> itemToJsonList(List<Item> items) =>
    items.map((e) => itemToJson(e)).toList();

Box<T> boxFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return Box<T>(
    tags:
        ((json['tags'] as List?)?.asMap().entries.map<T>((entry) {
          final i = entry.key;
          final e = entry.value;
          return fromJsonT(e);
        }).toSet()) ??
        <T>{},
    byKey: (Map<dynamic, dynamic>.from(json['byKey'] as Map)).entries
        .fold<Map<String, T>>(<String, T>{}, (acc, entry) {
          final k = (entry.key is String
              ? (entry.key as String)
              : entry.key.toString());
          final v = fromJsonT(entry.value);
          acc[k] = v;
          return acc;
        }),
    grid:
        ((json['grid'] as List?)?.asMap().entries.map<List<T>>((entry) {
          final i = entry.key;
          final e = entry.value;
          return <T>[for (final e0 in (e as List)) fromJsonT(e0)];
        }).toList()) ??
        <List<T>>[],
    maybe: json['maybe'] == null ? null : fromJsonT(json['maybe']),
  );
}

Map<String, dynamic> boxToJson<T>(
  Box<T> instance,
  Object? Function(T value) toJsonT,
) {
  return <String, dynamic>{
    'tags': instance.tags.map((e) => toJsonT(e)).toList(),
    'byKey': instance.byKey.map((k, v) => MapEntry(k, toJsonT(v))),
    'grid': instance.grid
        .map((e) => e.map((e0) => toJsonT(e0)).toList())
        .toList(),
    if (instance.maybe != null)
      'maybe': (instance.maybe == null ? null : toJsonT(instance.maybe as T)),
  };
}

mixin BoxSerializer<T> {
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return boxToJson<T>(this as Box<T>, toJsonT);
  }
}

List<EasyIssue> boxValidate<T>(
  Map<String, dynamic> json, {
  List<EasyIssue> Function(Object? json)? validateT,
}) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('tags')) {
    issues.add(
      EasyIssue(
        path: 'tags',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('tags') && json['tags'] == null) {
    issues.add(
      EasyIssue(
        path: 'tags',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('tags')) {
    final v = json['tags'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'tags',
          code: 'type_mismatch',
          message: 'Expected List for Set.',
        ),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'tags' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (validateT != null) {
            for (final n0 in validateT(e)) {
              issues.add(
                EasyIssue(
                  path: 'tags' + '[' + i.toString() + ']' + n0.path,
                  code: n0.code,
                  message: n0.message,
                ),
              );
            }
          }
        }
      }
    }
  }
  if (!json.containsKey('byKey')) {
    issues.add(
      EasyIssue(
        path: 'byKey',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('byKey') && json['byKey'] == null) {
    issues.add(
      EasyIssue(
        path: 'byKey',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('byKey')) {
    final v = json['byKey'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(
          path: 'byKey',
          code: 'type_mismatch',
          message: 'Expected Map.',
        ),
      );
    } else if (v is Map) {
      for (final e in v.entries) {
        {
          final x0 = e.value;
          if (x0 != null) {
            if (validateT != null) {
              for (final n0 in validateT(x0)) {
                issues.add(
                  EasyIssue(
                    path: 'byKey' + '.' + e.key.toString() + n0.path,
                    code: n0.code,
                    message: n0.message,
                  ),
                );
              }
            }
          }
        }
      }
    }
  }
  if (!json.containsKey('grid')) {
    issues.add(
      EasyIssue(
        path: 'grid',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('grid') && json['grid'] == null) {
    issues.add(
      EasyIssue(
        path: 'grid',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('grid')) {
    final v = json['grid'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'grid',
          code: 'type_mismatch',
          message: 'Expected List.',
        ),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'grid' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! List) {
            issues.add(
              EasyIssue(
                path: 'grid' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected List.',
              ),
            );
          } else {
            for (var i0 = 0; i0 < e.length; i0++) {
              {
                final x1 = e[i0];
                if (x1 != null) {
                  if (validateT != null) {
                    for (final n1 in validateT(x1)) {
                      issues.add(
                        EasyIssue(
                          path:
                              'grid' +
                              '[' +
                              i.toString() +
                              ']' +
                              '[' +
                              i0.toString() +
                              ']' +
                              n1.path,
                          code: n1.code,
                          message: n1.message,
                        ),
                      );
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  if (json.containsKey('maybe')) {
    final v = json['maybe'];
    if (v != null) {
      if (validateT != null) {
        for (final n0 in validateT(v)) {
          issues.add(
            EasyIssue(
              path: 'maybe' + n0.path,
              code: n0.code,
              message: n0.message,
            ),
          );
        }
      }
    }
  }
  return issues;
}

Box<T> boxFromJsonSafe<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in boxValidate<T>(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Box<T>(
    tags: (() {
      final _v = json['tags'];
      if (_v is! List) return <T>{};
      final _list = _v;
      return _list
          .asMap()
          .entries
          .map<T?>((entry) {
            return fromJsonT(entry.value);
          })
          .where((x) => x != null)
          .cast<T>()
          .toSet();
    })(),
    byKey: (() {
      final _v = json['byKey'];
      if (_v is! Map) return <String, T>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <String, T>{};
      for (final entry in _mapRaw.entries) {
        final k = (entry.key is String) ? entry.key : (entry.key?.toString());
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 'byKey' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = fromJsonT(entry.value);
        _out[k] = v;
      }
      return _out;
    })(),
    grid: (() {
      final _v = json['grid'];
      if (_v is! List) return <List<T>>[];
      final _list = _v;
      return _list.asMap().entries.map<List<T>>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final x0 = entry.value;
          if (x0 == null) {
            onIssue?.call(
              EasyIssue(
                path: 'grid' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return <T>[];
          }
          if (x0 is! List) {
            onIssue?.call(
              EasyIssue(
                path: 'grid' + '[' + entry.key.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected List.',
              ),
            );
            return <T>[];
          }
          return <T>[for (var i0 = 0; i0 < x0.length; i0++) fromJsonT(x0[i0])];
        })();
      }).toList();
    })(),
    maybe: (() {
      final v = json['maybe'];
      if (v == null) return null;
      try {
        return fromJsonT(v);
      } catch (_) {
        onIssue?.call(
          EasyIssue(
            path: 'maybe',
            code: 'type_mismatch',
            message: 'Could not convert value to T.',
          ),
        );
        return null;
      }
    })(),
  ))(_report);
}

class BoxJson {
  const BoxJson();

  static Box<T> fromJson<T>(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return boxFromJson<T>(json, fromJsonT);
  }

  static Box<T> fromJsonSafe<T>(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return boxFromJsonSafe<T>(
      json,
      fromJsonT,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return boxValidate(json);
  }
}

List<Box<T>> boxFromJsonList<T>(
  List<dynamic> json,
  T Function(Object? json) fromJsonT,
) => json
    .map((e) => boxFromJson<T>(e as Map<String, dynamic>, fromJsonT))
    .toList();

List<Box<T>> boxFromJsonSafeList<T>(
  List<dynamic> json,
  T Function(Object? json) fromJsonT, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => boxFromJsonSafe<T>(
        entry.value as Map<String, dynamic>,
        fromJsonT,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> boxToJsonList<T>(
  List<Box<T>> items,
  Object? Function(T value) toJsonT,
) => items.map((e) => boxToJson<T>(e, toJsonT)).toList();

Holder holderFromJson(Map<String, dynamic> json) {
  return Holder(
    box: boxFromJson<Item>(
      Map<String, dynamic>.from(json['box'] as Map),
      (Object? e0) => itemFromJson(Map<String, dynamic>.from(e0 as Map)),
    ),
    nums: (json['nums'] == null
        ? null
        : boxFromJson<int>(
            Map<String, dynamic>.from(json['nums'] as Map),
            (Object? e0) => (e0 as int),
          )),
    many:
        ((json['many'] as List?)?.asMap().entries.map<Box<String>>((entry) {
          final i = entry.key;
          final e = entry.value;
          return boxFromJson<String>(
            Map<String, dynamic>.from(e as Map),
            (Object? e0) => (e0 as String),
          );
        }).toList()) ??
        const <Box<String>>[],
    named: (Map<dynamic, dynamic>.from(json['named'] as Map)).entries
        .fold<Map<String, Box<Item>>>(<String, Box<Item>>{}, (acc, entry) {
          final k = (entry.key is String
              ? (entry.key as String)
              : entry.key.toString());
          final v = boxFromJson<Item>(
            Map<String, dynamic>.from(entry.value as Map),
            (Object? e0) => itemFromJson(Map<String, dynamic>.from(e0 as Map)),
          );
          acc[k] = v;
          return acc;
        }),
  );
}

Map<String, dynamic> holderToJson(Holder instance) {
  return <String, dynamic>{
    'box': instance.box.toJson((e0) => e0.toJson()),
    if (instance.nums != null) 'nums': instance.nums?.toJson((e0) => e0),
    'many': instance.many.map((e) => e.toJson((e0) => e0)).toList(),
    'named': instance.named.map(
      (k, v) => MapEntry(k, v.toJson((e0) => e0.toJson())),
    ),
  };
}

mixin HolderSerializer {
  Map<String, dynamic> toJson() {
    return holderToJson(this as Holder);
  }
}

List<EasyIssue> holderValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('box')) {
    issues.add(
      EasyIssue(
        path: 'box',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('box') && json['box'] == null) {
    issues.add(
      EasyIssue(
        path: 'box',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('box')) {
    final v = json['box'];
    if (v != null) {
      if (v is! Map) {
        issues.add(
          EasyIssue(
            path: 'box',
            code: 'type_mismatch',
            message: 'Expected Map for Box.',
          ),
        );
      } else {
        for (final n0 in boxValidate<Item>(
          Map<String, dynamic>.from(v),
          validateT: (Object? e0) {
            final issues = <EasyIssue>[];
            {
              final x1 = e0;
              if (x1 == null) {
                issues.add(
                  EasyIssue(
                    path: '',
                    code: 'null_not_allowed',
                    message: 'Null value not allowed.',
                  ),
                );
              } else {
                if (x1 is! Map) {
                  issues.add(
                    EasyIssue(
                      path: '',
                      code: 'type_mismatch',
                      message: 'Expected Map for Item.',
                    ),
                  );
                } else {
                  for (final n1 in itemValidate(
                    Map<String, dynamic>.from(x1),
                  )) {
                    issues.add(
                      EasyIssue(
                        path: '' + '.' + n1.path,
                        code: n1.code,
                        message: n1.message,
                      ),
                    );
                  }
                }
              }
            }
            return issues;
          },
        )) {
          issues.add(
            EasyIssue(
              path: 'box' + '.' + n0.path,
              code: n0.code,
              message: n0.message,
            ),
          );
        }
      }
    }
  }
  if (json.containsKey('nums')) {
    final v = json['nums'];
    if (v != null) {
      if (v is! Map) {
        issues.add(
          EasyIssue(
            path: 'nums',
            code: 'type_mismatch',
            message: 'Expected Map for Box.',
          ),
        );
      } else {
        for (final n0 in boxValidate<int>(
          Map<String, dynamic>.from(v),
          validateT: (Object? e0) {
            final issues = <EasyIssue>[];
            {
              final x1 = e0;
              if (x1 == null) {
                issues.add(
                  EasyIssue(
                    path: '',
                    code: 'null_not_allowed',
                    message: 'Null value not allowed.',
                  ),
                );
              } else {
                if (x1 is! int) {
                  issues.add(
                    EasyIssue(
                      path: '',
                      code: 'type_mismatch',
                      message: 'Expected int.',
                    ),
                  );
                }
              }
            }
            return issues;
          },
        )) {
          issues.add(
            EasyIssue(
              path: 'nums' + '.' + n0.path,
              code: n0.code,
              message: n0.message,
            ),
          );
        }
      }
    }
  }
  if (!json.containsKey('many')) {
    issues.add(
      EasyIssue(
        path: 'many',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('many') && json['many'] == null) {
    issues.add(
      EasyIssue(
        path: 'many',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('many')) {
    final v = json['many'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'many',
          code: 'type_mismatch',
          message: 'Expected List.',
        ),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'many' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! Map) {
            issues.add(
              EasyIssue(
                path: 'many' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected Map for Box.',
              ),
            );
          } else {
            for (final n0 in boxValidate<String>(
              Map<String, dynamic>.from(e),
              validateT: (Object? e0) {
                final issues = <EasyIssue>[];
                {
                  final x1 = e0;
                  if (x1 == null) {
                    issues.add(
                      EasyIssue(
                        path: '',
                        code: 'null_not_allowed',
                        message: 'Null value not allowed.',
                      ),
                    );
                  } else {
                    if (x1 is! String) {
                      issues.add(
                        EasyIssue(
                          path: '',
                          code: 'type_mismatch',
                          message: 'Expected String.',
                        ),
                      );
                    }
                  }
                }
                return issues;
              },
            )) {
              issues.add(
                EasyIssue(
                  path: 'many' + '[' + i.toString() + ']' + '.' + n0.path,
                  code: n0.code,
                  message: n0.message,
                ),
              );
            }
          }
        }
      }
    }
  }
  if (!json.containsKey('named')) {
    issues.add(
      EasyIssue(
        path: 'named',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('named') && json['named'] == null) {
    issues.add(
      EasyIssue(
        path: 'named',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('named')) {
    final v = json['named'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(
          path: 'named',
          code: 'type_mismatch',
          message: 'Expected Map.',
        ),
      );
    } else if (v is Map) {
      for (final e in v.entries) {
        {
          final x0 = e.value;
          if (x0 == null) {
            issues.add(
              EasyIssue(
                path: 'named' + '.' + e.key.toString(),
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
          } else {
            if (x0 is! Map) {
              issues.add(
                EasyIssue(
                  path: 'named' + '.' + e.key.toString(),
                  code: 'type_mismatch',
                  message: 'Expected Map for Box.',
                ),
              );
            } else {
              for (final n0 in boxValidate<Item>(
                Map<String, dynamic>.from(x0),
                validateT: (Object? e0) {
                  final issues = <EasyIssue>[];
                  {
                    final x1 = e0;
                    if (x1 == null) {
                      issues.add(
                        EasyIssue(
                          path: '',
                          code: 'null_not_allowed',
                          message: 'Null value not allowed.',
                        ),
                      );
                    } else {
                      if (x1 is! Map) {
                        issues.add(
                          EasyIssue(
                            path: '',
                            code: 'type_mismatch',
                            message: 'Expected Map for Item.',
                          ),
                        );
                      } else {
                        for (final n1 in itemValidate(
                          Map<String, dynamic>.from(x1),
                        )) {
                          issues.add(
                            EasyIssue(
                              path: '' + '.' + n1.path,
                              code: n1.code,
                              message: n1.message,
                            ),
                          );
                        }
                      }
                    }
                  }
                  return issues;
                },
              )) {
                issues.add(
                  EasyIssue(
                    path: 'named' + '.' + e.key.toString() + '.' + n0.path,
                    code: n0.code,
                    message: n0.message,
                  ),
                );
              }
            }
          }
        }
      }
    }
  }
  return issues;
}

Holder holderFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in holderValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Holder(
    box: (() {
      final x0 = json['box'];
      if (x0 == null)
        return boxFromJsonSafe<Item>(
          const <String, dynamic>{},
          (Object? e0) => ((void Function(EasyIssue)? onIssue) => (() {
            final x1 = e0;
            if (x1 == null) {
              onIssue?.call(
                EasyIssue(
                  path: 'box',
                  code: 'null_not_allowed',
                  message: 'Null value not allowed.',
                ),
              );
              return itemFromJsonSafe(
                const <String, dynamic>{},
                onIssue: (n1) => onIssue?.call(
                  EasyIssue(
                    path: 'box' + '.' + n1.path,
                    code: n1.code,
                    message: n1.message,
                  ),
                ),
                runValidate: false,
              );
            }
            if (x1 is! Map) {
              onIssue?.call(
                EasyIssue(
                  path: 'box',
                  code: 'type_mismatch',
                  message: 'Expected Map for Item.',
                ),
              );
              return itemFromJsonSafe(
                const <String, dynamic>{},
                onIssue: (n1) => onIssue?.call(
                  EasyIssue(
                    path: 'box' + '.' + n1.path,
                    code: n1.code,
                    message: n1.message,
                  ),
                ),
                runValidate: false,
              );
            }
            return itemFromJsonSafe(
              Map<String, dynamic>.from(x1),
              onIssue: (n1) => onIssue?.call(
                EasyIssue(
                  path: 'box' + '.' + n1.path,
                  code: n1.code,
                  message: n1.message,
                ),
              ),
              runValidate: false,
            );
          })())(null),
          onIssue: (n0) => onIssue?.call(
            EasyIssue(
              path: 'box' + '.' + n0.path,
              code: n0.code,
              message: n0.message,
            ),
          ),
          runValidate: false,
        );
      if (x0 is! Map) {
        onIssue?.call(
          EasyIssue(
            path: 'box',
            code: 'type_mismatch',
            message: 'Expected Map for Box.',
          ),
        );
        return boxFromJsonSafe<Item>(
          const <String, dynamic>{},
          (Object? e0) => ((void Function(EasyIssue)? onIssue) => (() {
            final x1 = e0;
            if (x1 == null) {
              onIssue?.call(
                EasyIssue(
                  path: 'box',
                  code: 'null_not_allowed',
                  message: 'Null value not allowed.',
                ),
              );
              return itemFromJsonSafe(
                const <String, dynamic>{},
                onIssue: (n1) => onIssue?.call(
                  EasyIssue(
                    path: 'box' + '.' + n1.path,
                    code: n1.code,
                    message: n1.message,
                  ),
                ),
                runValidate: false,
              );
            }
            if (x1 is! Map) {
              onIssue?.call(
                EasyIssue(
                  path: 'box',
                  code: 'type_mismatch',
                  message: 'Expected Map for Item.',
                ),
              );
              return itemFromJsonSafe(
                const <String, dynamic>{},
                onIssue: (n1) => onIssue?.call(
                  EasyIssue(
                    path: 'box' + '.' + n1.path,
                    code: n1.code,
                    message: n1.message,
                  ),
                ),
                runValidate: false,
              );
            }
            return itemFromJsonSafe(
              Map<String, dynamic>.from(x1),
              onIssue: (n1) => onIssue?.call(
                EasyIssue(
                  path: 'box' + '.' + n1.path,
                  code: n1.code,
                  message: n1.message,
                ),
              ),
              runValidate: false,
            );
          })())(null),
          onIssue: (n0) => onIssue?.call(
            EasyIssue(
              path: 'box' + '.' + n0.path,
              code: n0.code,
              message: n0.message,
            ),
          ),
          runValidate: false,
        );
      }
      return boxFromJsonSafe<Item>(
        Map<String, dynamic>.from(x0),
        (Object? e0) => ((void Function(EasyIssue)? onIssue) => (() {
          final x1 = e0;
          if (x1 == null) {
            onIssue?.call(
              EasyIssue(
                path: 'box',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return itemFromJsonSafe(
              const <String, dynamic>{},
              onIssue: (n1) => onIssue?.call(
                EasyIssue(
                  path: 'box' + '.' + n1.path,
                  code: n1.code,
                  message: n1.message,
                ),
              ),
              runValidate: false,
            );
          }
          if (x1 is! Map) {
            onIssue?.call(
              EasyIssue(
                path: 'box',
                code: 'type_mismatch',
                message: 'Expected Map for Item.',
              ),
            );
            return itemFromJsonSafe(
              const <String, dynamic>{},
              onIssue: (n1) => onIssue?.call(
                EasyIssue(
                  path: 'box' + '.' + n1.path,
                  code: n1.code,
                  message: n1.message,
                ),
              ),
              runValidate: false,
            );
          }
          return itemFromJsonSafe(
            Map<String, dynamic>.from(x1),
            onIssue: (n1) => onIssue?.call(
              EasyIssue(
                path: 'box' + '.' + n1.path,
                code: n1.code,
                message: n1.message,
              ),
            ),
            runValidate: false,
          );
        })())(null),
        onIssue: (n0) => onIssue?.call(
          EasyIssue(
            path: 'box' + '.' + n0.path,
            code: n0.code,
            message: n0.message,
          ),
        ),
        runValidate: false,
      );
    })(),
    nums: (() {
      final x0 = json['nums'];
      if (x0 == null) return null;
      if (x0 is! Map) {
        onIssue?.call(
          EasyIssue(
            path: 'nums',
            code: 'type_mismatch',
            message: 'Expected Map for Box.',
          ),
        );
        return null;
      }
      return boxFromJsonSafe<int>(
        Map<String, dynamic>.from(x0),
        (Object? e0) => ((void Function(EasyIssue)? onIssue) => (() {
          final x1 = e0;
          if (x1 == null) {
            onIssue?.call(
              EasyIssue(
                path: 'nums',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return 0;
          }
          if (x1 is int) return x1;
          onIssue?.call(
            EasyIssue(
              path: 'nums',
              code: 'type_mismatch',
              message: 'Expected int.',
            ),
          );
          return 0;
        })())(null),
        onIssue: (n0) => onIssue?.call(
          EasyIssue(
            path: 'nums' + '.' + n0.path,
            code: n0.code,
            message: n0.message,
          ),
        ),
        runValidate: false,
      );
    })(),
    many: (() {
      final _v = json['many'];
      if (_v is! List) return const <Box<String>>[];
      final _list = _v;
      return _list.asMap().entries.map<Box<String>>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final x0 = entry.value;
          if (x0 == null) {
            onIssue?.call(
              EasyIssue(
                path: 'many' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return boxFromJsonSafe<String>(
              const <String, dynamic>{},
              (Object? e0) => ((void Function(EasyIssue)? onIssue) => (() {
                final x1 = e0;
                if (x1 == null) {
                  onIssue?.call(
                    EasyIssue(
                      path: 'many' + '[' + entry.key.toString() + ']',
                      code: 'null_not_allowed',
                      message: 'Null value not allowed.',
                    ),
                  );
                  return '';
                }
                if (x1 is String) return x1;
                onIssue?.call(
                  EasyIssue(
                    path: 'many' + '[' + entry.key.toString() + ']',
                    code: 'type_mismatch',
                    message: 'Expected String.',
                  ),
                );
                return '';
              })())(null),
              onIssue: (n0) => onIssue?.call(
                EasyIssue(
                  path:
                      'many' + '[' + entry.key.toString() + ']' + '.' + n0.path,
                  code: n0.code,
                  message: n0.message,
                ),
              ),
              runValidate: false,
            );
          }
          if (x0 is! Map) {
            onIssue?.call(
              EasyIssue(
                path: 'many' + '[' + entry.key.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected Map for Box.',
              ),
            );
            return boxFromJsonSafe<String>(
              const <String, dynamic>{},
              (Object? e0) => ((void Function(EasyIssue)? onIssue) => (() {
                final x1 = e0;
                if (x1 == null) {
                  onIssue?.call(
                    EasyIssue(
                      path: 'many' + '[' + entry.key.toString() + ']',
                      code: 'null_not_allowed',
                      message: 'Null value not allowed.',
                    ),
                  );
                  return '';
                }
                if (x1 is String) return x1;
                onIssue?.call(
                  EasyIssue(
                    path: 'many' + '[' + entry.key.toString() + ']',
                    code: 'type_mismatch',
                    message: 'Expected String.',
                  ),
                );
                return '';
              })())(null),
              onIssue: (n0) => onIssue?.call(
                EasyIssue(
                  path:
                      'many' + '[' + entry.key.toString() + ']' + '.' + n0.path,
                  code: n0.code,
                  message: n0.message,
                ),
              ),
              runValidate: false,
            );
          }
          return boxFromJsonSafe<String>(
            Map<String, dynamic>.from(x0),
            (Object? e0) => ((void Function(EasyIssue)? onIssue) => (() {
              final x1 = e0;
              if (x1 == null) {
                onIssue?.call(
                  EasyIssue(
                    path: 'many' + '[' + entry.key.toString() + ']',
                    code: 'null_not_allowed',
                    message: 'Null value not allowed.',
                  ),
                );
                return '';
              }
              if (x1 is String) return x1;
              onIssue?.call(
                EasyIssue(
                  path: 'many' + '[' + entry.key.toString() + ']',
                  code: 'type_mismatch',
                  message: 'Expected String.',
                ),
              );
              return '';
            })())(null),
            onIssue: (n0) => onIssue?.call(
              EasyIssue(
                path: 'many' + '[' + entry.key.toString() + ']' + '.' + n0.path,
                code: n0.code,
                message: n0.message,
              ),
            ),
            runValidate: false,
          );
        })();
      }).toList();
    })(),
    named: (() {
      final _v = json['named'];
      if (_v is! Map) return const <String, Box<Item>>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <String, Box<Item>>{};
      for (final entry in _mapRaw.entries) {
        final k = (entry.key is String) ? entry.key : (entry.key?.toString());
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 'named' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = (() {
          final x0 = entry.value;
          if (x0 == null) {
            onIssue?.call(
              EasyIssue(
                path: 'named' + '.' + k.toString(),
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return boxFromJsonSafe<Item>(
              const <String, dynamic>{},
              (Object? e0) => ((void Function(EasyIssue)? onIssue) => (() {
                final x1 = e0;
                if (x1 == null) {
                  onIssue?.call(
                    EasyIssue(
                      path: 'named' + '.' + k.toString(),
                      code: 'null_not_allowed',
                      message: 'Null value not allowed.',
                    ),
                  );
                  return itemFromJsonSafe(
                    const <String, dynamic>{},
                    onIssue: (n1) => onIssue?.call(
                      EasyIssue(
                        path: 'named' + '.' + k.toString() + '.' + n1.path,
                        code: n1.code,
                        message: n1.message,
                      ),
                    ),
                    runValidate: false,
                  );
                }
                if (x1 is! Map) {
                  onIssue?.call(
                    EasyIssue(
                      path: 'named' + '.' + k.toString(),
                      code: 'type_mismatch',
                      message: 'Expected Map for Item.',
                    ),
                  );
                  return itemFromJsonSafe(
                    const <String, dynamic>{},
                    onIssue: (n1) => onIssue?.call(
                      EasyIssue(
                        path: 'named' + '.' + k.toString() + '.' + n1.path,
                        code: n1.code,
                        message: n1.message,
                      ),
                    ),
                    runValidate: false,
                  );
                }
                return itemFromJsonSafe(
                  Map<String, dynamic>.from(x1),
                  onIssue: (n1) => onIssue?.call(
                    EasyIssue(
                      path: 'named' + '.' + k.toString() + '.' + n1.path,
                      code: n1.code,
                      message: n1.message,
                    ),
                  ),
                  runValidate: false,
                );
              })())(null),
              onIssue: (n0) => onIssue?.call(
                EasyIssue(
                  path: 'named' + '.' + k.toString() + '.' + n0.path,
                  code: n0.code,
                  message: n0.message,
                ),
              ),
              runValidate: false,
            );
          }
          if (x0 is! Map) {
            onIssue?.call(
              EasyIssue(
                path: 'named' + '.' + k.toString(),
                code: 'type_mismatch',
                message: 'Expected Map for Box.',
              ),
            );
            return boxFromJsonSafe<Item>(
              const <String, dynamic>{},
              (Object? e0) => ((void Function(EasyIssue)? onIssue) => (() {
                final x1 = e0;
                if (x1 == null) {
                  onIssue?.call(
                    EasyIssue(
                      path: 'named' + '.' + k.toString(),
                      code: 'null_not_allowed',
                      message: 'Null value not allowed.',
                    ),
                  );
                  return itemFromJsonSafe(
                    const <String, dynamic>{},
                    onIssue: (n1) => onIssue?.call(
                      EasyIssue(
                        path: 'named' + '.' + k.toString() + '.' + n1.path,
                        code: n1.code,
                        message: n1.message,
                      ),
                    ),
                    runValidate: false,
                  );
                }
                if (x1 is! Map) {
                  onIssue?.call(
                    EasyIssue(
                      path: 'named' + '.' + k.toString(),
                      code: 'type_mismatch',
                      message: 'Expected Map for Item.',
                    ),
                  );
                  return itemFromJsonSafe(
                    const <String, dynamic>{},
                    onIssue: (n1) => onIssue?.call(
                      EasyIssue(
                        path: 'named' + '.' + k.toString() + '.' + n1.path,
                        code: n1.code,
                        message: n1.message,
                      ),
                    ),
                    runValidate: false,
                  );
                }
                return itemFromJsonSafe(
                  Map<String, dynamic>.from(x1),
                  onIssue: (n1) => onIssue?.call(
                    EasyIssue(
                      path: 'named' + '.' + k.toString() + '.' + n1.path,
                      code: n1.code,
                      message: n1.message,
                    ),
                  ),
                  runValidate: false,
                );
              })())(null),
              onIssue: (n0) => onIssue?.call(
                EasyIssue(
                  path: 'named' + '.' + k.toString() + '.' + n0.path,
                  code: n0.code,
                  message: n0.message,
                ),
              ),
              runValidate: false,
            );
          }
          return boxFromJsonSafe<Item>(
            Map<String, dynamic>.from(x0),
            (Object? e0) => ((void Function(EasyIssue)? onIssue) => (() {
              final x1 = e0;
              if (x1 == null) {
                onIssue?.call(
                  EasyIssue(
                    path: 'named' + '.' + k.toString(),
                    code: 'null_not_allowed',
                    message: 'Null value not allowed.',
                  ),
                );
                return itemFromJsonSafe(
                  const <String, dynamic>{},
                  onIssue: (n1) => onIssue?.call(
                    EasyIssue(
                      path: 'named' + '.' + k.toString() + '.' + n1.path,
                      code: n1.code,
                      message: n1.message,
                    ),
                  ),
                  runValidate: false,
                );
              }
              if (x1 is! Map) {
                onIssue?.call(
                  EasyIssue(
                    path: 'named' + '.' + k.toString(),
                    code: 'type_mismatch',
                    message: 'Expected Map for Item.',
                  ),
                );
                return itemFromJsonSafe(
                  const <String, dynamic>{},
                  onIssue: (n1) => onIssue?.call(
                    EasyIssue(
                      path: 'named' + '.' + k.toString() + '.' + n1.path,
                      code: n1.code,
                      message: n1.message,
                    ),
                  ),
                  runValidate: false,
                );
              }
              return itemFromJsonSafe(
                Map<String, dynamic>.from(x1),
                onIssue: (n1) => onIssue?.call(
                  EasyIssue(
                    path: 'named' + '.' + k.toString() + '.' + n1.path,
                    code: n1.code,
                    message: n1.message,
                  ),
                ),
                runValidate: false,
              );
            })())(null),
            onIssue: (n0) => onIssue?.call(
              EasyIssue(
                path: 'named' + '.' + k.toString() + '.' + n0.path,
                code: n0.code,
                message: n0.message,
              ),
            ),
            runValidate: false,
          );
        })();
        _out[k] = v;
      }
      return _out;
    })(),
  ))(_report);
}

class HolderJson {
  const HolderJson();

  static Holder fromJson(Map<String, dynamic> json) {
    return holderFromJson(json);
  }

  static Holder fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return holderFromJsonSafe(json, onIssue: onIssue, runValidate: runValidate);
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return holderValidate(json);
  }
}

List<Holder> holderFromJsonList(List<dynamic> json) =>
    json.map((e) => holderFromJson(e as Map<String, dynamic>)).toList();

List<Holder> holderFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => holderFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> holderToJsonList(List<Holder> items) =>
    items.map((e) => holderToJson(e)).toList();

Wrapper<T> wrapperFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return Wrapper<T>(
    inner: boxFromJson<T>(
      Map<String, dynamic>.from(json['inner'] as Map),
      (Object? e0) => fromJsonT(e0),
    ),
  );
}

Map<String, dynamic> wrapperToJson<T>(
  Wrapper<T> instance,
  Object? Function(T value) toJsonT,
) {
  return <String, dynamic>{'inner': instance.inner.toJson((e0) => toJsonT(e0))};
}

mixin WrapperSerializer<T> {
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return wrapperToJson<T>(this as Wrapper<T>, toJsonT);
  }
}

List<EasyIssue> wrapperValidate<T>(
  Map<String, dynamic> json, {
  List<EasyIssue> Function(Object? json)? validateT,
}) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('inner')) {
    issues.add(
      EasyIssue(
        path: 'inner',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('inner') && json['inner'] == null) {
    issues.add(
      EasyIssue(
        path: 'inner',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('inner')) {
    final v = json['inner'];
    if (v != null) {
      if (v is! Map) {
        issues.add(
          EasyIssue(
            path: 'inner',
            code: 'type_mismatch',
            message: 'Expected Map for Box.',
          ),
        );
      } else {
        for (final n0 in boxValidate<T>(
          Map<String, dynamic>.from(v),
          validateT: validateT,
        )) {
          issues.add(
            EasyIssue(
              path: 'inner' + '.' + n0.path,
              code: n0.code,
              message: n0.message,
            ),
          );
        }
      }
    }
  }
  return issues;
}

Wrapper<T> wrapperFromJsonSafe<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in wrapperValidate<T>(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Wrapper<T>(
    inner: (() {
      final x0 = json['inner'];
      if (x0 == null)
        return boxFromJsonSafe<T>(
          const <String, dynamic>{},
          (Object? e0) =>
              ((void Function(EasyIssue)? onIssue) => fromJsonT(e0))(null),
          onIssue: (n0) => onIssue?.call(
            EasyIssue(
              path: 'inner' + '.' + n0.path,
              code: n0.code,
              message: n0.message,
            ),
          ),
          runValidate: false,
        );
      if (x0 is! Map) {
        onIssue?.call(
          EasyIssue(
            path: 'inner',
            code: 'type_mismatch',
            message: 'Expected Map for Box.',
          ),
        );
        return boxFromJsonSafe<T>(
          const <String, dynamic>{},
          (Object? e0) =>
              ((void Function(EasyIssue)? onIssue) => fromJsonT(e0))(null),
          onIssue: (n0) => onIssue?.call(
            EasyIssue(
              path: 'inner' + '.' + n0.path,
              code: n0.code,
              message: n0.message,
            ),
          ),
          runValidate: false,
        );
      }
      return boxFromJsonSafe<T>(
        Map<String, dynamic>.from(x0),
        (Object? e0) =>
            ((void Function(EasyIssue)? onIssue) => fromJsonT(e0))(null),
        onIssue: (n0) => onIssue?.call(
          EasyIssue(
            path: 'inner' + '.' + n0.path,
            code: n0.code,
            message: n0.message,
          ),
        ),
        runValidate: false,
      );
    })(),
  ))(_report);
}

class WrapperJson {
  const WrapperJson();

  static Wrapper<T> fromJson<T>(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return wrapperFromJson<T>(json, fromJsonT);
  }

  static Wrapper<T> fromJsonSafe<T>(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return wrapperFromJsonSafe<T>(
      json,
      fromJsonT,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return wrapperValidate(json);
  }
}

List<Wrapper<T>> wrapperFromJsonList<T>(
  List<dynamic> json,
  T Function(Object? json) fromJsonT,
) => json
    .map((e) => wrapperFromJson<T>(e as Map<String, dynamic>, fromJsonT))
    .toList();

List<Wrapper<T>> wrapperFromJsonSafeList<T>(
  List<dynamic> json,
  T Function(Object? json) fromJsonT, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => wrapperFromJsonSafe<T>(
        entry.value as Map<String, dynamic>,
        fromJsonT,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> wrapperToJsonList<T>(
  List<Wrapper<T>> items,
  Object? Function(T value) toJsonT,
) => items.map((e) => wrapperToJson<T>(e, toJsonT)).toList();

ItemPage itemPageFromJson(Map<String, dynamic> json) {
  return ItemPage(
    items:
        ((json['items'] as List?)?.asMap().entries.map<Item>((entry) {
          final i = entry.key;
          final e = entry.value;
          return itemFromJson(Map<String, dynamic>.from(e as Map));
        }).toList()) ??
        const <Item>[],
    first: json['first'] == null
        ? null
        : itemFromJson(json['first'] as Map<String, dynamic>),
    total: (json['total'] as int?) ?? 0,
  );
}

Map<String, dynamic> itemPageToJson(ItemPage instance) {
  return <String, dynamic>{
    'items': instance.items.map((e) => e.toJson()).toList(),
    if (instance.first != null) 'first': instance.first?.toJson(),
    'total': instance.total,
  };
}

mixin ItemPageSerializer {
  Map<String, dynamic> toJson() {
    return itemPageToJson(this as ItemPage);
  }
}

List<EasyIssue> itemPageValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('items')) {
    issues.add(
      EasyIssue(
        path: 'items',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('items') && json['items'] == null) {
    issues.add(
      EasyIssue(
        path: 'items',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('items')) {
    final v = json['items'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'items',
          code: 'type_mismatch',
          message: 'Expected List.',
        ),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'items' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! Map) {
            issues.add(
              EasyIssue(
                path: 'items' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected Map for Item.',
              ),
            );
          } else {
            final child = itemValidate(Map<String, dynamic>.from(e as Map));
            for (final ci in child) {
              issues.add(
                EasyIssue(
                  path: 'items' + '[' + i.toString() + '].' + ci.path,
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
  if (json.containsKey('first')) {
    final v = json['first'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(
          path: 'first',
          code: 'type_mismatch',
          message: 'Expected Map for Item.',
        ),
      );
    } else if (v is Map) {
      final child = itemValidate(Map<String, dynamic>.from(v));
      for (final ci in child) {
        issues.add(
          EasyIssue(
            path: 'first' + '.' + ci.path,
            code: ci.code,
            message: ci.message,
          ),
        );
      }
    }
  }
  if (!json.containsKey('total')) {
    issues.add(
      EasyIssue(
        path: 'total',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('total') && json['total'] == null) {
    issues.add(
      EasyIssue(
        path: 'total',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('total')) {
    final v = json['total'];
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'total',
            code: 'type_mismatch',
            message: 'Expected int.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  return issues;
}

ItemPage itemPageFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in itemPageValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => ItemPage(
    items: (() {
      final _v = json['items'];
      if (_v is! List) return const <Item>[];
      final _list = _v;
      return _list.asMap().entries.map<Item>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final _v = entry.value;
          if (_v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'items' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return itemFromJsonSafe(
              const <String, dynamic>{},
              onIssue: (i) => onIssue?.call(
                EasyIssue(
                  path:
                      'items' + '[' + entry.key.toString() + ']' + '.' + i.path,
                  code: i.code,
                  message: i.message,
                ),
              ),
              runValidate: false,
            );
          }
          if (_v is Map) {
            return itemFromJsonSafe(
              Map<String, dynamic>.from(_v as Map),
              onIssue: (i) => onIssue?.call(
                EasyIssue(
                  path:
                      'items' + '[' + entry.key.toString() + ']' + '.' + i.path,
                  code: i.code,
                  message: i.message,
                ),
              ),
              runValidate: false,
            );
          }
          onIssue?.call(
            EasyIssue(
              path: 'items' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Expected Map for Item.',
            ),
          );
          return itemFromJsonSafe(
            const <String, dynamic>{},
            onIssue: (i) => onIssue?.call(
              EasyIssue(
                path: "'items' + '[' + entry.key.toString() + ']'." + i.path,
                code: i.code,
                message: i.message,
              ),
            ),
            runValidate: false,
          );
        })();
      }).toList();
    })(),
    first: (() {
      final _v = json['first'];
      if (_v == null) return null;
      if (_v is Map) {
        return itemFromJsonSafe(
          Map<String, dynamic>.from(_v as Map),
          onIssue: (i) => onIssue?.call(
            EasyIssue(
              path: 'first' + '.' + i.path,
              code: i.code,
              message: i.message,
            ),
          ),
          runValidate: false,
        );
      }
      return null;
    })(),
    total: (() {
      final v = json['total'];
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return p;
      }
      return 0;
    })(),
  ))(_report);
}

class ItemPageJson {
  const ItemPageJson();

  static ItemPage fromJson(Map<String, dynamic> json) {
    return itemPageFromJson(json);
  }

  static ItemPage fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return itemPageFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return itemPageValidate(json);
  }
}

List<ItemPage> itemPageFromJsonList(List<dynamic> json) =>
    json.map((e) => itemPageFromJson(e as Map<String, dynamic>)).toList();

List<ItemPage> itemPageFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => itemPageFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> itemPageToJsonList(List<ItemPage> items) =>
    items.map((e) => itemPageToJson(e)).toList();
