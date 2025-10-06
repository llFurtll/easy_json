// test/order_safe_test.dart
import 'package:dart_easy_json/easy_json.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dart_easy_json/test_models.dart';
import 'package:dart_easy_json/generated/test_models.easy.dart';

void main() {
  group('Order.fromJsonSafe', () {
    test('coage, aplica fallbacks e registra issues', () {
      final issues = <EasyIssue>[];

      final badJson = {
        "orderId": 123,                   // deveria ser String
        "createdAt": 1715790000000,       // epoch ms -> ok pelo converter
        "buyerRole": "superuser",         // inválido -> enumFallback guest
        "shipping": {
          "street": "Main",
          "number": "12",                 // inválido -> fallback 0
        },
        "items": {
          "1": {"id": 1, "price": "9.9", "name": "T-shirt"}, // price string -> fallback 0.0
          "x": {"id": 2, "price": 20.0, "name": "Jeans"},    // chave x inválida -> descartada + issue
        },
        "quantities": {
          "1": "2",  // inválido -> itemFallback 0
          "2": 3     // ok
        },
        "notes": ["ok", 123, null, "another"], // 123/null -> viram '' no SAFE
        "tags": ["summer", 10, "sale", "sale"], // 10 -> removed ; Set remove duplicatas
        "statusHistory": {
          "2024-05-01": "paid",
          "2024-05-02": "shipped",
          "2024/05/03": "invalid" // enum inválido -> fallback do enum
        },
        "scores": {
          "alice": "10",
          "bob": 7.9,
          "carol": "x" // vira 0 pelo valueFromJson
        }
      };

      final order = orderFromJsonSafe(
        badJson,
        onIssue: issues.add,
      );

      // Checks básicos de coação/fallback
      expect(order.orderId, isA<String>());           // coage para '' no SAFE
      expect(order.buyerRole, TmRole.guest);          // enumFallback
      expect(order.shipping.number, 0);               // fallback
      expect(order.items.containsKey(1), isTrue);     // "1" -> 1
      expect(order.items.containsKey(2), isFalse);    // "x" descartado
      expect(order.quantities['1'], 0);               // itemFallback
      expect(order.quantities['2'], 3);

      expect(order.notes.length, 4);
      expect(order.notes[0], 'ok');
      expect(order.notes[1], isA<String>());
      expect(order.tags.contains('summer'), isTrue);
      expect(order.tags.contains('10'), isFalse);        // 10 -> removed
      // Set remove duplicatas
      expect(order.tags.where((t) => t == 'sale').length, 1);

      expect(order.statusHistory['2024-05-01'], TmStatus.paid);
      expect(order.statusHistory['2024/05/03'], isNotNull);

      expect(order.scores['alice'], 10);
      expect(order.scores['bob'], 7);
      expect(order.scores['carol'], 0);

      // Issues esperadas (não precisa bater exatamente todos, mas alguns chaves)
      expect(
        issues.map((e) => e.path).toList(),
        containsAll([
          'orderId',
          'buyerRole',                 // enum inválido
          'shipping.number',
          'items.x',                   // key_type_mismatch
          'quantities.1',             // item inválido (virou 0)
          'notes[1]',
          'notes[2]',
          'tags[1]',
          'statusHistory.2024/05/03', // enum inválido
        ]),
      );
    });
  });
}
