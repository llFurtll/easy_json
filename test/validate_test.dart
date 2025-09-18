// test/validate_test.dart
import 'package:easy_json/easy_json.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_json/generated/test_models.easy.dart';

void main() {
  group('Validate', () {
    test('aponta campos obrigatórios e type mismatch', () {
      final json = {
        // sem orderId
        "createdAt": "2024-01-01", // errado: conversor espera int no fromJson (mas validate aceita string? -> mismatch DateTime)
        "buyerRole": 10,           // errado, deveria ser String
        "shipping": "x",           // errado, deveria Map
        "items": [],               // errado, deveria Map
        "quantities": {"a": "x"},  // valores errados
        "notes": "x",              // errado, deveria List
        "tags": {},                // errado, deveria List
        "statusHistory": {"d":"z"},// err
        "scores": {"a": "b"},      // conversor aceita -> sem issue de tipo no value (opcional)
      };

      final issues = orderValidate(json);

      expect(issues.any((i) => i.path == 'orderId' && i.code == 'missing_required'), isTrue);
      expect(issues.any((i) => i.path == 'buyerRole' && i.code == 'type_mismatch'), isTrue);
      expect(issues.any((i) => i.path == 'shipping' && i.code == 'type_mismatch'), isTrue);
      expect(issues.any((i) => i.path == 'items' && i.code == 'type_mismatch'), isTrue);
      expect(issues.any((i) => i.path == 'notes' && i.code == 'type_mismatch'), isTrue);
      expect(issues.any((i) => i.path == 'tags' && i.code == 'type_mismatch'), isTrue);
      expect(issues.any((i) => i.path.startsWith('statusHistory')), isTrue);
    });

    test('runValidate false evita dupla validação em filhos', () {
      final json = {
        "orderId": "x",
        "createdAt": 0,
        "buyerRole": "admin",
        "shipping": {"street": 10, "number": "abc"},
        "items": {},
        "quantities": {},
        "notes": [],
        "tags": [],
        "statusHistory": {},
        "scores": {},
      };

      final forwarded = <EasyIssue>[];
      final _ = orderFromJsonSafe(json, onIssue: forwarded.add); // runValidate = true (default)

      // Deve ter issues por conta de shipping.street/number, mas cada uma só uma vez
      final shippingIssues = forwarded.where((i) => i.path.startsWith('shipping.')).toList();
      // nenhum path duplicado
      final unique = shippingIssues.map((e) => e.path).toSet();
      expect(unique.length, shippingIssues.length);
    });
  });
}
