import 'package:dart_easy_json/easy_json.dart';
import 'package:test/test.dart';

import 'models/generic_models.easy.dart';
import 'models/test_models.dart';
import 'models/test_models.easy.dart';

Address _address(Object? json) => Address.fromJson(json as Map<String, dynamic>);

void main() {
  group('Generic class with T field (ApiResponse<T>)', () {
    final json = {
      'data': {'street': 'Rua A', 'number': 10},
      'statusCode': 200,
    };

    test('fromJson uses the converter for T', () {
      final r = apiResponseFromJson(json, _address);
      expect(r, isA<ApiResponse<Address>>());
      expect(r.data.street, 'Rua A');
      expect(r.data.number, 10);
      expect(r.statusCode, 200);
      expect(r.message, isNull);
    });

    test('works with a primitive T', () {
      final r = apiResponseFromJson<int>(
        {'data': 42, 'statusCode': 200},
        (d) => d as int,
      );
      expect(r.data, 42);
    });

    test('toJson (mixin) uses the converter for T', () {
      final r = apiResponseFromJson(json, _address);
      final out = r.toJson((a) => a.toJson());
      expect(out, {
        'data': {'street': 'Rua A', 'number': 10},
        'statusCode': 200,
      });
    });

    test('companion class exposes generic static methods', () {
      final r = ApiResponseJson.fromJson<Address>(json, _address);
      expect(r.data.street, 'Rua A');
    });

    test('list helpers thread the converter through', () {
      final list = apiResponseFromJsonList([json, json], _address);
      expect(list, hasLength(2));
      expect(list[1].data.number, 10);

      final back = apiResponseToJsonList(list, (a) => a.toJson());
      expect(back[0]['data'], {'street': 'Rua A', 'number': 10});
    });

    test('validate reports a missing T field', () {
      final issues = apiResponseValidate({'statusCode': 200});
      expect(issues.map((i) => (i.path, i.code)), contains(('data', 'missing_required')));
    });
  });

  group('Generic class with List<T> and T? (PageResponse<T>)', () {
    final json = {
      'items': [
        {'street': 'A', 'number': 1},
        {'street': 'B', 'number': 2},
      ],
      'total': 2,
      'highlight': {'street': 'B', 'number': 2},
    };

    test('fromJson parses every item with the converter', () {
      final p = pageResponseFromJson(json, _address);
      expect(p.items.map((a) => a.street), ['A', 'B']);
      expect(p.total, 2);
      expect(p.highlight?.street, 'B');
    });

    test('nullable T? stays null without calling the converter', () {
      var calls = 0;
      final p = pageResponseFromJson({'items': [], 'total': 0}, (d) {
        calls++;
        return _address(d);
      });
      expect(p.highlight, isNull);
      expect(p.items, isEmpty);
      expect(calls, 0);
    });

    test('toJson round-trips List<T> and T?', () {
      final p = pageResponseFromJson(json, _address);
      expect(p.toJson((a) => a.toJson()), json);
    });

    test('fromJsonSafe reports a failing converter on T? and falls back to null', () {
      final issues = <EasyIssue>[];
      final p = pageResponseFromJsonSafe(
        {'items': [], 'total': 0, 'highlight': 'not a map'},
        _address,
        onIssue: issues.add,
      );
      expect(p.highlight, isNull);
      expect(issues.map((i) => (i.path, i.code)), contains(('highlight', 'type_mismatch')));
    });

    test('validate flags a non-list value for List<T>', () {
      final issues = pageResponseValidate({'items': 'nope', 'total': 1});
      expect(issues.map((i) => (i.path, i.code)), contains(('items', 'type_mismatch')));
    });
  });

  group('Multiple type parameters with a bound (Pair<A, B extends Object>)', () {
    test('each type parameter gets its own converter', () {
      final p = pairFromJson<String, int>(
        {'first': 'x', 'second': 7},
        (d) => d as String,
        (d) => d as int,
      );
      expect(p.first, 'x');
      expect(p.second, 7);
      expect(p.toJson((a) => a, (b) => b), {'first': 'x', 'second': 7});
    });
  });

  group('Set<T>, Map<String, T>, List<List<T>> (Box<T>)', () {
    final json = {
      'tags': [1, 2],
      'byKey': {'a': 3},
      'grid': [
        [4, 5],
        [6],
      ],
      'maybe': 7,
    };

    test('fromJson / toJson round trip with the converters', () {
      final b = boxFromJson<int>(json, (o) => o as int);
      expect(b.tags, {1, 2});
      expect(b.byKey, {'a': 3});
      expect(b.grid, [
        [4, 5],
        [6],
      ]);
      expect(b.maybe, 7);
      expect(b.toJson((i) => i), json);
    });

    test('fromJsonSafe reports bad structure with the nested path', () {
      final issues = <EasyIssue>[];
      final b = boxFromJsonSafe<int>(
        {'tags': [], 'byKey': {}, 'grid': [5, [1]]},
        (o) => o as int,
        onIssue: issues.add,
      );
      expect(b.grid, [<int>[], [1]]);
      expect(issues.map((i) => (i.path, i.code)), [('grid[0]', 'type_mismatch')]);
    });
  });

  group('Generic @EasyJson class as a field (Holder)', () {
    final json = <String, dynamic>{
      'box': {
        'tags': [
          {'n': 1},
        ],
        'byKey': {
          'a': {'n': 2},
        },
        'grid': [
          [
            {'n': 3},
          ],
        ],
      },
      'nums': {
        'tags': [1],
        'byKey': <String, dynamic>{},
        'grid': [
          [1, 2],
        ],
      },
      'many': [
        {
          'tags': ['x'],
          'byKey': {'k': 'v'},
          'grid': <dynamic>[],
        },
      ],
      'named': {
        'z': {'tags': <dynamic>[], 'byKey': <String, dynamic>{}, 'grid': <dynamic>[]},
      },
    };

    test('the generator passes the converters (fromJson / toJson)', () {
      final h = holderFromJson(json);
      expect(h.box.grid.single.single.n, 3);
      expect(h.nums?.grid.single, [1, 2]);
      expect(h.many.single.byKey, {'k': 'v'});
      expect(h.toJson(), json);
    });

    test('fromJsonSafe and validate agree on valid input', () {
      final issues = <EasyIssue>[];
      expect(holderFromJsonSafe(json, onIssue: issues.add).toJson(), json);
      expect(issues, isEmpty);
      expect(holderValidate(json), isEmpty);
    });

    test('junk: never throws, validate looks inside T, safe == validate', () {
      final junk = <String, dynamic>{
        'box': {
          'tags': [5],
          'byKey': [],
          'grid': [
            ['x'],
          ],
        },
        'nums': {
          'tags': ['a'],
          'byKey': <String, dynamic>{},
          'grid': <dynamic>[],
        },
        'many': 3,
        'named': {'z': 'q'},
      };
      final issues = <EasyIssue>[];
      final h = holderFromJsonSafe(junk, onIssue: issues.add);
      expect(h.many, isEmpty);
      final validated = holderValidate(junk).map((i) => (i.path, i.code)).toSet();
      expect(validated, {
        ('box.tags[0]', 'type_mismatch'),
        ('box.byKey', 'type_mismatch'),
        ('box.grid[0][0]', 'type_mismatch'),
        ('nums.tags[0]', 'type_mismatch'),
        ('many', 'type_mismatch'),
        ('named.z', 'type_mismatch'),
      });
      expect(issues.map((i) => (i.path, i.code)).toSet(), validated);
    });

    test('@EasyValidate rules inside T are checked (and strict mode sees them)', () {
      final issues = holderValidate({
        ...json,
        'box': {
          'tags': [
            {'n': -1},
          ],
          'byKey': <String, dynamic>{},
          'grid': <dynamic>[],
        },
      });
      expect(issues.map((i) => (i.path, i.code)), [('box.tags[0].n', 'min_value')]);
    });

    test('generic class inside a generic class (Wrapper<T>)', () {
      final w = wrapperFromJson<int>({
        'inner': {
          'tags': [1],
          'byKey': {'a': 2},
          'grid': [
            [3],
          ],
        },
      }, (o) => o as int);
      expect(w.inner.grid.single.single, 3);
      expect(w.toJson((i) => i)['inner'], {
        'tags': [1],
        'byKey': {'a': 2},
        'grid': [
          [3],
        ],
      });
    });
  });

  group('Fields inherited from a generic superclass (ItemPage)', () {
    test('use the type argument of the subclass', () {
      final json = {
        'items': [
          {'n': 1},
        ],
        'first': {'n': 1},
        'total': 1,
      };
      final p = itemPageFromJson(json);
      expect(p.items.single.n, 1);
      expect(p.first?.n, 1);
      expect(p.toJson(), json);
    });

    test('validate looks inside the inherited items', () {
      final issues = itemPageValidate({
        'items': [
          {'n': 'x'},
        ],
        'total': 1,
      });
      expect(issues.map((i) => (i.path, i.code)), [('items[0].n', 'type_mismatch')]);
    });
  });
}
