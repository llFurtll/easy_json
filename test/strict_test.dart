import 'package:dart_easy_json/easy_json.dart';
import 'package:test/test.dart';

import 'models/test_models.dart';
import 'models/test_models.easy.dart';

/// Roda [body] e devolve a EasyValidationException lançada (falha se não lançar).
EasyValidationException _thrown(void Function() body) {
  try {
    body();
  } on EasyValidationException catch (e) {
    return e;
  }
  fail('Expected an EasyValidationException');
}

void main() {
  group('@EasyJson(strict: true)', () {
    test('valid payload parses normally', () {
      final u = strictUserFromJson({'name': 'Ana', 'age': 30, 'email': 'ana@x.com'});
      expect(u.name, 'Ana');
      expect(u.age, 30);
      expect(u.email, 'ana@x.com');
    });

    test('throws EasyValidationException with every issue, not a TypeError', () {
      final e = _thrown(
        () => strictUserFromJson({'age': 'forty', 'email': 'not-an-email'}),
      );
      expect(
        e.issues.map((i) => (i.path, i.code)),
        containsAll([
          ('name', 'missing_required'),
          ('age', 'type_mismatch'),
          ('email', 'invalid_email'),
        ]),
      );
    });

    test('toString lists the issues', () {
      final e = _thrown(() => strictUserFromJson({'age': 1}));
      expect(e.toString(), contains('[missing_required] name'));
    });

    test('non-strict classes keep the lenient fromJson', () {
      // Address não é strict: campo faltando vira o default, sem exceção.
      expect(addressFromJson({}).street, '');
    });

    test('reports nested object and list item paths', () {
      final e = _thrown(
        () => strictOrderFromJson({
          'id': 'o1',
          'shipping': {'street': 'Rua A', 'number': 'ten'},
          'products': [
            {'id': 1, 'price': 9.9, 'name': 'ok'},
            {'id': 'two', 'price': 1.0, 'name': 'bad'},
          ],
        }),
      );
      expect(
        e.issues.map((i) => i.path),
        containsAll(['shipping.number', 'products[1].id']),
      );
    });

    test('works together with generics', () {
      final env = strictEnvelopeFromJson(
        {'payload': 5, 'version': 'v1'},
        (d) => d as int,
      );
      expect(env.payload, 5);

      final e = _thrown(() => strictEnvelopeFromJson({'payload': 5}, (d) => d as int));
      expect(e.issues.map((i) => (i.path, i.code)), contains(('version', 'missing_required')));
    });

    test('strict union validates the discriminator before dispatching', () {
      final s = shapeFromJson({'kind': 'circle', 'radius': 2.0});
      expect(s, isA<Circle>());
      expect((s as Circle).radius, 2.0);

      final e = _thrown(() => shapeFromJson({'kind': 'triangle'}));
      expect(e.issues.map((i) => i.code), contains('unknown_union_type'));
    });
  });
}
