import 'package:flutter_test/flutter_test.dart';

import 'package:easy_json/generated/test_models.easy.dart';
import 'package:easy_json/src/easy_issue.dart';

void main() {
  group('Coleções (List/Set/Map) - safe', () {
    test('List<String> coage itens inválidos e marca índices', () {
      final issues = <EasyIssue>[];
      final o = orderFromJsonSafe({
        'orderId': 'A',
        'createdAt': '2024-01-01T00:00:00Z',
        'buyerRole': 'viewer',
        'items': {},
        'quantities': {},
        'notes': ['ok', 123, null], // [0]=ok, [1]/[2] inválidos
        'tags': [],
        'statusHistory': {},
      }, onIssue: issues.add);

      expect(o.notes, isA<List<String>>());
      expect(issues.map((e) => e.path), contains('notes[1]'));
      expect(issues.map((e) => e.path), contains('notes[2]'));
    });

    test('Set<String> coage itens inválidos e mantém unicidade', () {
      final issues = <EasyIssue>[];
      final o = orderFromJsonSafe({
        'orderId': 'A',
        'createdAt': '2024-01-01T00:00:00Z',
        'buyerRole': 'viewer',
        'items': {},
        'quantities': {},
        'notes': [],
        'tags': ['a', 'a', 1], // 'a' duplicado + inteiro inválido
        'statusHistory': {},
      }, onIssue: issues.add);

      expect(o.tags.length, 1); // só 'a'
      expect(issues.map((e) => e.path), contains('tags[2]'));
    });

    test('Map<int, Product> coage chave string numérica e marca chave inválida', () {
      final issues = <EasyIssue>[];
      final o = orderFromJsonSafe({
        'orderId': 'A',
        'createdAt': '2024-01-01T00:00:00Z',
        'buyerRole': 'viewer',
        'items': {
          '1': {'id': 'p1'},
          'x': {'id': 'p2'}, // chave inválida
        },
        'quantities': {},
        'notes': [],
        'tags': [],
        'statusHistory': {},
      }, onIssue: issues.add);

      expect(o.items.containsKey(1), isTrue);
      expect(issues.any((i) => i.path == 'items.x' && i.code == 'key_type_mismatch'), isTrue);
    });

    test('Map<String, int> marca valor inválido por chave', () {
      final issues = <EasyIssue>[];
      final o = orderFromJsonSafe({
        'orderId': 'A',
        'createdAt': '2024-01-01T00:00:00Z',
        'buyerRole': 'viewer',
        'items': {},
        'quantities': {'ok': 1, 'bad': 'nope'},
        'notes': [],
        'tags': [],
        'statusHistory': {},
      }, onIssue: issues.add);

      expect(o.quantities['ok'], 1);
      expect(issues.any((i) => i.path == 'quantities.bad' && i.code == 'type_mismatch'), isTrue);
    });
  });
}
