import 'package:flutter_test/flutter_test.dart';

import 'package:dart_easy_json/generated/test_models.easy.dart'; // Order etc.

void main() {
  group('DateTime safe', () {
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
  });
}
