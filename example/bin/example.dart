// example/bin/main.dart
import 'package:example/generated/models.easy.dart';

void main() {
  final badJson = {
    "orderId": 123, // deveria ser string
    "createdAt": 1715790000000, // epoch ms (ok, converter de campo cuida)
    "buyerRole": "superuser", // inválido -> cai no enumFallback = guest
    "shipping": {
      "street": "Main St",
      "number": "12" // inválido -> issue e fallback 0
    },
    "items": {
      "1": {"id": 1, "price": "9.9", "name": "T-shirt"}, // price string -> fallback 0.0
      "x": {"id": 2, "price": 20.0, "name": "Jeans"}      // chave 'x' inválida para int -> descartado + issue
    },
    "quantities": {
      "1": "2",    // inválido -> itemFallback 0
      "2": 3       // ok
    },
    "notes": ["ok", 123, null, "another"], // 123/null -> fallback '' no SAFE
    "tags": ["summer", 10, "sale", "sale"], // 10 -> '' no SAFE; Set remove duplicados
    "statusHistory": {
      "2024-05-01": "paid",
      "2024-05-02": "shipped",
      "2024/05/03": "invalid" // enum inválido -> fallback do enum do campo (primeiro valor) + issue
    },
    "scores": {
      "alice": "10",
      "bob": 7.9,
      "carol": "x" // vira 0 pelo valueFromJson
    }
  };

  final order = orderFromJsonSafe(
    badJson,
    onIssue: (i) => print("[${i.code}] ${i.path}: ${i.message}"),
  );

  print("\n=== OBJETO GERADO (SAFE) ===");
  print(order.toJson()); // já aplica os toJson (inclui conversores e normalizações)
}
