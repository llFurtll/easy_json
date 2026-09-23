import 'package:dart_easy_json/easy_json.dart';
import 'package:test/test.dart';

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
}
