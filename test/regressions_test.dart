import 'dart:convert';

import 'package:dart_easy_json/easy_json.dart';
import 'package:test/test.dart';

import 'models/matrix_models.dart' show Color;
import 'models/matrix_models.easy.dart';
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

  group('validate accepts what fromJsonSafe accepts (1.1.0 upgrade notes)', () {
    final base = {
      'i': 7, 'd': 2.5, 'n': 3, 'b': true, 's': 'x',
      'dt': '2024-01-02T03:04:05.000Z', 'u': 'https://a.dev', 'du': 1,
      'bi': '1', 'by': 'AQID', 'c': 'green', 'o': {'n': 1},
    };

    test('an integer string for an int', () {
      expect(scalarsValidate({...base, 'i': '5'}), isEmpty);
      expect(scalarsFromJsonSafe({...base, 'i': '5'}).i, 5);
    });

    test('an enum given by its index', () {
      expect(scalarsValidate({...base, 'c': 1}), isEmpty);
      expect(scalarsFromJsonSafe({...base, 'c': 1}).c, Color.green);
      expect(scalarsValidate({...base, 'c': 9}).map((i) => i.code), ['invalid_enum_index']);
    });

    test('an integer inside a List<double>', () {
      final lists = {
        'i': [], 'd': [3], 'n': [], 'b': [], 's': [], 'dt': [], 'u': [],
        'du': [], 'bi': [], 'by': [], 'c': [], 'o': [], 'iN': [],
      };
      expect(listsValidate(lists), isEmpty);
      expect(listsFromJsonSafe(lists).d, [3.0]);
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
