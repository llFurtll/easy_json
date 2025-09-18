// test/roundtrip_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_json/test_models.dart';
import 'package:easy_json/generated/test_models.easy.dart';

void main() {
  test('toJson e roundtrip básico', () {
    final order = Order(
      orderId: 'A1',
      createdAt: DateTime.fromMillisecondsSinceEpoch(1000),
      buyerRole: TmRole.admin,
      shipping: const Address(street: 'S', number: 1),
      items: {
        1: const Product(id: 1, price: 9.9, name: 'T'),
      },
      quantities: {'1': 2},
      notes: ['a', 'b'],
      tags: {'x', 'y'},
      statusHistory: {'2024-05-01': TmStatus.paid},
      scores: {'alice': 10},
    );

    final json = orderToJson(order);
    // enums -> name
    expect(json['buyerRole'], 'admin');
    // converter de campo
    expect(json['createdAt'], 1000); // ms
    // objeto aninhado
    expect(json['shipping'], isA<Map>());
    // map<int, Product> vira Map<int, Map>
    expect((json['items'] as Map)['1'] ?? (json['items'] as Map)[1], isNotNull);

    // Re-parse rápido
    final o2 = orderFromJson(json);
    expect(o2.buyerRole, TmRole.admin);
    expect(o2.createdAt.millisecondsSinceEpoch, 1000);
  });
}
