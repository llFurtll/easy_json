// Matriz de testes: cada tipo suportado (puro, nullable, em List/Set/Map)
// contra as propriedades que o pacote promete:
//
//  1. Ida e volta: validate(J) é vazio e toJson(fromJson(J)) — passando por
//     jsonEncode/jsonDecode — devolve J (idem para fromJsonSafe, sem issues).
//  2. Lixo em qualquer campo: nada lança; nenhuma issue duplicada; e o
//     fromJsonSafe reporta exatamente as mesmas (path, code) que o validate.
//
// As falhas são reunidas num relatório único para facilitar o diagnóstico.
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dart_easy_json/easy_json.dart';
import 'package:test/test.dart';

import 'models/matrix_models.easy.dart';

typedef _Json = Map<String, dynamic>;

class _Model {
  _Model(
    this.name, {
    required this.fromJson,
    required this.fromJsonSafe,
    required this.validate,
    required this.toJson,
    required this.samples,
  });

  final String name;
  final Object Function(_Json) fromJson;
  final Object Function(_Json, {void Function(EasyIssue)? onIssue, bool runValidate})
      fromJsonSafe;
  final List<EasyIssue> Function(_Json) validate;
  final _Json Function(Object) toJson;

  /// JSONs canônicos (no formato que o próprio toJson produz).
  final List<_Json> samples;
}

const _iso = '2024-01-02T03:04:05.000Z';
const _uri = 'https://a.dev/p?q=1';
const _big = '123456789012345678901234567890';
const _bytes = 'AQID'; // [1, 2, 3]

final _models = [
  _Model(
    'Scalars',
    fromJson: scalarsFromJson,
    fromJsonSafe: scalarsFromJsonSafe,
    validate: scalarsValidate,
    toJson: (o) => scalarsToJson(o as dynamic),
    samples: [
      {
        'i': 7, 'iN': 7, 'd': 2.5, 'dN': 2.5, 'n': 3, 'nN': 3, 'b': true, 'bN': true,
        's': 'x', 'sN': 'x', 'dt': _iso, 'dtN': _iso, 'u': _uri, 'uN': _uri,
        'du': 1500000, 'duN': 1500000, 'bi': _big, 'biN': _big,
        'by': _bytes, 'byN': _bytes, 'c': 'green', 'cN': 'green',
        'o': {'n': 1}, 'oN': {'n': 1},
      },
      // nullables ausentes
      {
        'i': 7, 'd': 2.5, 'n': 3, 'b': true, 's': 'x', 'dt': _iso, 'u': _uri,
        'du': 1500000, 'bi': _big, 'by': _bytes, 'c': 'green', 'o': {'n': 1},
      },
    ],
  ),
  _Model(
    'Lists',
    fromJson: listsFromJson,
    fromJsonSafe: listsFromJsonSafe,
    validate: listsValidate,
    toJson: (o) => listsToJson(o as dynamic),
    samples: [
      {
        'i': [7, 8], 'd': [2.5], 'n': [3, 4.5], 'b': [true, false], 's': ['x', 'y'],
        'dt': [_iso], 'u': [_uri], 'du': [1500000], 'bi': [_big], 'by': [_bytes],
        'c': ['green', 'red'], 'o': [{'n': 1}, {'n': 2}], 'iN': [1, null, 3],
        'nullableList': [1],
      },
      {
        'i': <Object?>[], 'd': <Object?>[], 'n': <Object?>[], 'b': <Object?>[],
        's': <Object?>[], 'dt': <Object?>[], 'u': <Object?>[], 'du': <Object?>[],
        'bi': <Object?>[], 'by': <Object?>[], 'c': <Object?>[], 'o': <Object?>[],
        'iN': <Object?>[],
      },
    ],
  ),
  _Model(
    'Sets',
    fromJson: setsFromJson,
    fromJsonSafe: setsFromJsonSafe,
    validate: setsValidate,
    toJson: (o) => setsToJson(o as dynamic),
    samples: [
      {
        'i': [1, 2], 'd': [2.5], 's': ['x'], 'dt': [_iso], 'u': [_uri],
        'du': [1], 'bi': [_big], 'c': ['red'], 'nullableSet': [1],
      },
    ],
  ),
  _Model(
    'Maps',
    fromJson: mapsFromJson,
    fromJsonSafe: mapsFromJsonSafe,
    validate: mapsValidate,
    toJson: (o) => mapsToJson(o as dynamic),
    samples: [
      {
        'i': {'a': 1}, 'd': {'a': 2.5}, 'b': {'a': true}, 's': {'a': 'x'},
        'dt': {'a': _iso}, 'u': {'a': _uri}, 'du': {'a': 5}, 'bi': {'a': _big},
        'by': {'a': _bytes}, 'c': {'a': 'red'}, 'o': {'a': {'n': 1}},
        'ik': {'10': 'x'}, 'iN': {'a': 1, 'b': null}, 'nullableMap': {'a': 1},
      },
    ],
  ),
  _Model(
    'Nested',
    fromJson: nestedFromJson,
    fromJsonSafe: nestedFromJsonSafe,
    validate: nestedValidate,
    toJson: (o) => nestedToJson(o as dynamic),
    samples: [
      {
        'li': [[1, 2], <Object?>[]], 'lin': [[1], null], 'ls': [['a', 'b']],
        'sl': [[2.5]], 'ml': {'a': [1, 2]}, 'lm': [{'a': 1}],
        'mm': {'x': {'1': 'red'}}, 'lo': [[{'n': 1}]], 'ldt': [[_iso, null]],
        'deep': [[[true]]],
      },
      {
        'li': <Object?>[], 'lin': <Object?>[], 'ls': <Object?>[], 'sl': <Object?>[],
        'ml': <String, Object?>{}, 'lm': <Object?>[], 'mm': <String, Object?>{},
        'lo': <Object?>[], 'ldt': <Object?>[],
      },
    ],
  ),
];

/// Cópias de [base] com [junk] no primeiro item/valor de cada nível de
/// coleção dentro de `base[key]` (ex.: `grid[0]`, `grid[0][0]`).
Iterable<(String, _Json)> _inner(_Json base, String key, Object? junk) sync* {
  Object? replaceAt(Object? v, int depth) {
    if (depth == 0) return junk;
    if (v is List && v.isNotEmpty) return [replaceAt(v.first, depth - 1), ...v.skip(1)];
    if (v is Map && v.isNotEmpty) {
      final k = v.keys.first;
      return {...v, k: replaceAt(v[k], depth - 1)};
    }
    return null;
  }

  var v = base[key];
  for (var depth = 1; (v is List && v.isNotEmpty) || (v is Map && v.isNotEmpty); depth++) {
    yield ('$key${'[0]' * depth}=${_show(junk)}', {...base, key: replaceAt(base[key], depth)});
    v = v is List ? v.first : (v as Map).values.first;
  }
}

/// Valores inválidos jogados em cada campo. `_missing` = remover a chave.
const _missing = #missing;
final _junk = <Object?>[
  _missing,
  null,
  'garbage',
  -5,
  3.7,
  true,
  <Object?>[],
  <String, Object?>{},
  [1, 'x', null],
  {'n': 'x'},
];

Object? _norm(Object? json) => jsonDecode(jsonEncode(json));
const _eq = DeepCollectionEquality();
String _show(Object? v) => v == _missing ? '<missing>' : jsonEncode(v);

/// Chaves de campos nullable em cada modelo (as demais são não-nullable).
const _nullableKeys = {
  'Scalars': {'iN', 'dN', 'nN', 'bN', 'sN', 'dtN', 'uN', 'duN', 'biN', 'byN', 'cN', 'oN'},
  'Lists': {'nullableList'},
  'Sets': {'nullableSet'},
  'Maps': {'nullableMap'},
  'Nested': {'deep'},
};

void main() {
  test('explicit null in a non-nullable field is always reported', () {
    final problems = <String>[];
    for (final m in _models) {
      for (final key in m.samples.first.keys) {
        if (_nullableKeys[m.name]!.contains(key)) continue;
        final issues = m.validate({...m.samples.first, key: null});
        if (!issues.any((i) => i.path == key && i.code == 'null_not_allowed')) {
          problems.add('${m.name}.$key: validate gave $issues');
        }
      }
    }
    if (problems.isNotEmpty) fail(problems.join('\n'));
  });

  group('@EasyKey(fallback / itemFallback)', () {
    test('invalid values use the configured fallback', () {
      final f = fallbacksFromJsonSafe({
        'i': {}, 'd': {}, 'n': {}, 'b': {}, 's': {}, 'dt': {}, 'u': {}, 'du': {},
        'bi': {}, 'by': {}, 'uN': {},
        'li': [1, 'x'],
        'ldt': ['nope'],
        'mu': {'a': 5},
      });
      expect(f.i, -1);
      expect(f.d, 1.0);
      expect(f.n, 2);
      expect(f.b, isTrue);
      expect(f.s, r'R$ 0,00');
      expect(f.dt, DateTime.utc(2020));
      expect(f.u, Uri.parse('https://fallback.dev'));
      expect(f.du, const Duration(microseconds: 42));
      expect(f.bi, BigInt.from(99));
      expect(f.by, [1, 2, 3]);
      expect(f.uN, Uri.parse('https://nullable.dev'));
      expect(f.li, [1, 0]);
      expect(f.ldt, [DateTime.fromMillisecondsSinceEpoch(1000)]);
      expect(f.mu, {'a': Uri.parse('https://item.dev')});
    });

    test('missing / null values: non-nullable uses the fallback, nullable stays null', () {
      final f = fallbacksFromJsonSafe({'dt': null, 'u': null});
      expect(f.i, -1);
      expect(f.s, r'R$ 0,00');
      expect(f.dt, DateTime.utc(2020));
      expect(f.u, Uri.parse('https://fallback.dev'));
      expect(f.uN, isNull);
    });
  });

  for (final m in _models) {
    group(m.name, () {
      test('round trip (fromJson / fromJsonSafe / validate)', () {
        final problems = <String>[];
        for (final (idx, j) in m.samples.indexed) {
          String where(String what) => 'sample #$idx: $what';
          try {
            final v = m.validate(j);
            if (v.isNotEmpty) problems.add(where('validate reported $v'));
          } catch (e) {
            problems.add(where('validate threw $e'));
          }
          try {
            final out = _norm(m.toJson(m.fromJson(j)));
            if (!_eq.equals(out, j)) problems.add(where('fromJson->toJson gave $out'));
          } catch (e) {
            problems.add(where('fromJson/toJson threw $e'));
          }
          try {
            final issues = <EasyIssue>[];
            final out = _norm(m.toJson(m.fromJsonSafe(j, onIssue: issues.add)));
            if (issues.isNotEmpty) problems.add(where('fromJsonSafe reported $issues'));
            if (!_eq.equals(out, j)) problems.add(where('fromJsonSafe->toJson gave $out'));
          } catch (e) {
            problems.add(where('fromJsonSafe/toJson threw $e'));
          }
        }
        if (problems.isNotEmpty) fail(problems.join('\n'));
      });

      test('junk in every field: never throws, no duplicates, validate == safe', () {
        final problems = <String>[];
        final base = m.samples.first;
        // Cada caso troca um valor por lixo: o campo inteiro ou, em
        // coleções, o primeiro item/valor de cada nível (aninhados inclusos).
        final cases = [
          for (final key in base.keys)
            for (final junk in _junk) ...[
              (junk == _missing ? '$key' : '$key=${_show(junk)}', {
                ...base,
                key: junk,
              }..removeWhere((k, v) => k == key && v == _missing)),
              if (junk != _missing)
                for (final (path, j) in _inner(base, key, junk)) (path, j),
            ],
        ];
        for (final (where, j) in cases) {
          {

            List<EasyIssue> validated;
            try {
              validated = m.validate(j);
            } catch (e) {
              problems.add('$where: validate threw $e');
              continue;
            }

            final reported = <EasyIssue>[];
            try {
              m.fromJsonSafe(j, onIssue: reported.add);
            } catch (e) {
              problems.add('$where: fromJsonSafe threw $e');
              continue;
            }
            try {
              m.fromJsonSafe(j, runValidate: false);
            } catch (e) {
              problems.add('$where: fromJsonSafe(runValidate: false) threw $e');
            }

            final pairs = [for (final i in reported) '${i.path}|${i.code}'];
            final dups = pairs.where((p) => pairs.where((q) => q == p).length > 1).toSet();
            if (dups.isNotEmpty) problems.add('$where: duplicated issues $dups');

            final vSet = {for (final i in validated) '${i.path}|${i.code}'};
            final sSet = pairs.toSet();
            if (!_eq.equals(vSet, sSet)) {
              problems.add(
                '$where: validate=${vSet.toList()..sort()} safe=${sSet.toList()..sort()}',
              );
            }
          }
        }
        if (problems.isNotEmpty) {
          fail('${problems.length} problem(s):\n${problems.join('\n')}');
        }
      });
    });
  }
}
