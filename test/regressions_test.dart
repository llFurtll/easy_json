import 'dart:convert';

import 'package:dart_easy_json/easy_json.dart';
import 'package:test/test.dart';

import 'models/test_models.dart';
import 'models/test_models.easy.dart';
import 'models/types.dart';

/// Bugs encontrados ao validar os exemplos do README contra o pacote real.
void main() {
  group('double fields', () {
    test('a non-numeric String is reported instead of silently becoming 0.0', () {
      final issues = <EasyIssue>[];
      final p = productFromJsonSafe(
        {'id': 1, 'price': 'cheap', 'name': 'TV'},
        onIssue: issues.add,
      );
      expect(p.price, 0.0);
      expect(issues.map((i) => (i.path, i.code)), contains(('price', 'type_mismatch')));
    });

    test('a numeric String is still accepted', () {
      expect(productValidate({'id': 1, 'price': '9.90', 'name': 'TV'}), isEmpty);
      expect(productFromJsonSafe({'id': 1, 'price': '9.90', 'name': 'TV'}).price, 9.9);
    });

    test('@EasyValidate min/max are applied to double fields', () {
      expect(rangeModelValidate({'score': 50}), isEmpty);
      expect(rangeModelValidate({'score': '50'}), isEmpty);
      expect(
        rangeModelValidate({'score': -1}).map((i) => i.code),
        ['min_value'],
      );
      expect(
        rangeModelValidate({'score': 100.5}).map((i) => i.code),
        ['max_value'],
      );
    });
  });

  group('@EasyPath', () {
    test('toJson writes the value back at the nested path (round trip)', () {
      final model = PathModel(count: 3, userName: 'ana');
      final json = pathModelToJson(model);
      expect(json, {
        'meta': {
          'count': 3,
          'info': {'user_name': 'ana'},
        },
      });

      final back = pathModelFromJson(json);
      expect(back.count, 3);
      expect(back.userName, 'ana');
    });
  });

  group('Maps with non-String keys', () {
    test('toJson turns int keys into Strings so jsonEncode works', () {
      final order = Order(
        orderId: 'A1',
        createdAt: DateTime.fromMillisecondsSinceEpoch(1000),
        buyerRole: TmRole.admin,
        shipping: const Address(street: 'S', number: 1),
        items: {7: const Product(id: 7, price: 1.5, name: 'T')},
        quantities: {'7': 2},
        notes: const [],
        tags: const {},
        statusHistory: const {},
        scores: const {},
      );

      final json = orderToJson(order);
      expect((json['items'] as Map).keys, ['7']);

      final back = orderFromJson(jsonDecode(jsonEncode(json)) as Map<String, dynamic>);
      expect(back.items[7]?.name, 'T');
    });
  });
}
