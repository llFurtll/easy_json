import 'package:dart_easy_json/types.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dart_easy_json/generated/test_models.easy.dart';
import 'package:dart_easy_json/src/easy_issue.dart';

void main() {
  group('Enum safe', () {
    test('válido', () {
      final o = orderFromJsonSafe({
        'orderId': 'A',
        'createdAt': '2024-01-01T00:00:00Z',
        'buyerRole': 'editor',
        'items': {},
        'quantities': {},
        'notes': [],
        'tags': [],
        'statusHistory': {},
      });
      expect(o.buyerRole.toString(), contains('editor'));
    });

    test('inválido -> fallback + issue', () {
      final issues = <EasyIssue>[];
      final o = orderFromJsonSafe({
        'orderId': 'A',
        'createdAt': '2024-01-01T00:00:00Z',
        'buyerRole': 'nope',
        'items': {},
        'quantities': {},
        'notes': [],
        'tags': [],
        'statusHistory': {},
      }, onIssue: issues.add);

      expect(o.buyerRole, isNotNull);
      expect(issues.any((i) => i.path == 'buyerRole' && i.code == 'invalid_enum'), isTrue);
    });

    test('ausente -> missing_required', () {
      final issues = <EasyIssue>[];
      orderFromJsonSafe({
        'orderId': 'A',
        'createdAt': '2024-01-01T00:00:00Z',
        'items': {},
        'quantities': {},
        'notes': [],
        'tags': [],
        'statusHistory': {},
      }, onIssue: issues.add);

      expect(issues.any((i) => i.path == 'buyerRole' && i.code == 'missing_required'), isTrue);
    });

    test('Enum inválido -> fallback + issue', () {
      final issues = <EasyIssue>[];
      final o = orderFromJsonSafe({'buyerRole': 'edito'}, onIssue: issues.add);
      expect(o.buyerRole, TmRole.guest); // ou seu fallback configurado
      expect(issues.map((e)=>e.path), contains('buyerRole'));
      expect(issues.map((e)=>e.code), contains('invalid_enum'));
    });
  });
}
