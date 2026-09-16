import 'package:dart_easy_json/easy_json.dart';
import 'package:test/test.dart';

import 'models/test_models.dart';
import 'models/test_models.easy.dart';

void main() {
  group('Uri / Duration / BigInt', () {
    final validJson = {
      'homepage': 'https://example.com',
      'timeout': 5000000, // 5s in microseconds
      'bigId': '123456789012345678901234567890',
    };

    test('fromJson parses Uri/Duration/BigInt', () {
      final m = NativeTypesModel.fromJson(validJson);
      expect(m.homepage, Uri.parse('https://example.com'));
      expect(m.repository, isNull);
      expect(m.timeout, const Duration(microseconds: 5000000));
      expect(m.extra, isNull);
      expect(m.bigId, BigInt.parse('123456789012345678901234567890'));
      expect(m.bigOptional, isNull);
    });

    test('toJson serializes back to String/int/String', () {
      final m = NativeTypesModel.fromJson({
        ...validJson,
        'repository': 'https://github.com/llFurtll/easy_json',
        'extra': 42,
        'bigOptional': '99',
      });
      final json = m.toJson();
      expect(json['homepage'], 'https://example.com');
      expect(json['repository'], 'https://github.com/llFurtll/easy_json');
      expect(json['timeout'], 5000000);
      expect(json['extra'], 42);
      expect(json['bigId'], '123456789012345678901234567890');
      expect(json['bigOptional'], '99');
    });

    test('fromJsonSafe falls back on wrong type without throwing', () {
      final issues = <EasyIssue>[];
      final m = NativeTypesModel.fromJsonSafe({
        'homepage': 123, // wrong type
        'timeout': true, // not num/numeric String
        'bigId': false, // not String/int/num
      }, onIssue: issues.add);

      expect(m.homepage, Uri());
      expect(m.timeout, Duration.zero);
      expect(m.bigId, BigInt.zero);
      expect(issues.map((i) => i.code), containsAll(['type_mismatch', 'type_mismatch', 'type_mismatch']));
    });

    test('fromJsonSafe reports invalid_uri / invalid_bigint for malformed strings', () {
      final issues = <EasyIssue>[];
      NativeTypesModel.fromJsonSafe({
        'homepage': 'http://[::1', // unterminated IPv6 host, fails Uri.tryParse
        'timeout': 5000000,
        'bigId': 'not-a-number',
      }, onIssue: issues.add);

      expect(issues.map((i) => i.code), containsAll(['invalid_uri', 'invalid_bigint']));
    });

    test('fromJsonSafe accepts a plain int for BigInt', () {
      final m = NativeTypesModel.fromJsonSafe({
        ...validJson,
        'bigId': 42,
      });
      expect(m.bigId, BigInt.from(42));
    });

    test('fromJsonSafe accepts a numeric String for Duration', () {
      final m = NativeTypesModel.fromJsonSafe({
        ...validJson,
        'timeout': '2500000',
      });
      expect(m.timeout, const Duration(microseconds: 2500000));
    });

    test('validate reports issues for the same malformed payload', () {
      final issues = nativeTypesModelValidate({
        'homepage': 123,
        'timeout': 'nope',
        'bigId': true,
      });
      expect(issues, isNotEmpty);
      expect(issues.every((i) => i.code == 'type_mismatch'), isTrue);
    });
  });

  group('List helpers', () {
    final jsonList = [
      {
        'homepage': 'https://a.example.com',
        'timeout': 1000000,
        'bigId': '1',
      },
      {
        'homepage': 'https://b.example.com',
        'timeout': 2000000,
        'bigId': '2',
      },
    ];

    test('xFromJsonList parses every item', () {
      final list = nativeTypesModelFromJsonList(jsonList);
      expect(list, hasLength(2));
      expect(list[0].homepage, Uri.parse('https://a.example.com'));
      expect(list[1].bigId, BigInt.two);
    });

    test('xToJsonList serializes every item', () {
      final list = nativeTypesModelFromJsonList(jsonList);
      final back = nativeTypesModelToJsonList(list);
      expect(back, hasLength(2));
      expect(back[0]['homepage'], 'https://a.example.com');
      expect(back[1]['bigId'], '2');
    });

    test('xFromJsonSafeList reports (index, issue) for bad entries', () {
      final withBadEntry = [
        jsonList[0],
        {'homepage': 42, 'timeout': 'bad', 'bigId': false},
      ];
      final reported = <int>[];
      final list = nativeTypesModelFromJsonSafeList(
        withBadEntry,
        onIssue: (index, issue) => reported.add(index),
      );
      expect(list, hasLength(2));
      expect(reported, everyElement(equals(1)));
      expect(reported, isNotEmpty);
    });
  });
}
