import 'package:flutter_test/flutter_test.dart';

import 'package:dart_easy_json/generated/test_models.easy.dart'; // Order etc.
import 'package:dart_easy_json/src/easy_issue.dart';

void main() {
  group('DateTime safe', () {
    test('aceita ISO-8601 string', () {
      final o = orderFromJsonSafe({
        'orderId': 'A',
        'createdAt': '2024-01-02T03:04:05Z',
        'buyerRole': 'viewer',
        'items': {},
        'quantities': {},
        'notes': [],
        'tags': [],
        'statusHistory': {},
      });
      expect(o.createdAt.toUtc().toIso8601String(), '2024-01-02T03:04:05.000Z');
    });

    test('aceita epoch int (ms)', () {
      final o = orderFromJsonSafe({
        'orderId': 'A',
        'createdAt': 1704164645000, // 2024-01-02T03:04:05Z
        'buyerRole': 'viewer',
        'items': {},
        'quantities': {},
        'notes': [],
        'tags': [],
        'statusHistory': {},
      });
      expect(o.createdAt.toUtc().toIso8601String(), '2024-01-02T03:04:05.000Z');
    });

    test('aceita epoch num (ms)', () {
      final o = orderFromJsonSafe({
        'orderId': 'A',
        'createdAt': 1704164645000.0,
        'buyerRole': 'viewer',
        'items': {},
        'quantities': {},
        'notes': [],
        'tags': [],
        'statusHistory': {},
      });
      expect(o.createdAt.toUtc().toIso8601String(), '2024-01-02T03:04:05.000Z');
    });

    test('aceita DateTime direto (edge)', () {
      final dt = DateTime.utc(2024, 1, 2, 3, 4, 5);
      final o = orderFromJsonSafe({
        'orderId': 'A',
        'createdAt': dt,
        'buyerRole': 'viewer',
        'items': {},
        'quantities': {},
        'notes': [],
        'tags': [],
        'statusHistory': {},
      });
      expect(o.createdAt.toUtc(), dt);
    });

    test('tipo inválido -> fallback + issue (sem crash)', () {
      final issues = <EasyIssue>[];
      final o = orderFromJsonSafe({
        'orderId': 'A',
        'createdAt': {'nope': true},
        'buyerRole': 'viewer',
        'items': {},
        'quantities': {},
        'notes': [],
        'tags': [],
        'statusHistory': {},
      }, onIssue: issues.add);

      expect(o.createdAt, isA<DateTime>()); // fallback aplicado
      expect(issues.map((e) => e.path), contains('createdAt'));
    });
  });
}
