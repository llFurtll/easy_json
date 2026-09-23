// Confere que cada saída mostrada no README.md é a saída real do pacote.
// Os modelos estão em models/readme_models.dart, idênticos aos do README.
import 'dart:convert';

import 'package:dart_easy_json/easy_json.dart';
import 'package:test/test.dart';

import 'models/readme_models.dart';
import 'models/readme_models.easy.dart';

List<String> _strs(Iterable<EasyIssue> issues) => issues.map((i) => '$i').toList();

void main() {
  test('Quick start', () {
    final user = User.fromJson({'name': 'Ana', 'age': 30});
    expect(user.toJson(), {'name': 'Ana', 'age': 30});
  });

  test('Safe parsing', () {
    final issues = <EasyIssue>[];
    final product = Product.fromJsonSafe(
      {'name': 'TV', 'price': 'cheap'},
      onIssue: issues.add,
    );
    expect(product.name, 'TV');
    expect(product.price, 0.0);
    expect(product.stock, 0);
    expect(_strs(issues), [
      '[min_length] name: Must have at least 3 characters.',
      '[type_mismatch] price: Expected number.',
      '[missing_required] stock: Missing required field.',
    ]);
  });

  test('Standalone validation', () {
    expect(ProductJson.validate({'name': 'TV', 'price': 'cheap'}), hasLength(3));
  });

  test('Validation rules', () {
    final valid = {
      'username': 'ana_99',
      'email': 'ana@example.com',
      'age': 30,
      'birthDate': '1995-05-10T00:00:00Z',
      'luckyNumber': 8,
    };
    expect(accountValidate(valid), isEmpty);

    final issues = accountValidate({
      'username': 'An',
      'email': 'ana@',
      'age': 15,
      'birthDate': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
      'luckyNumber': 7,
    });
    expect(
      issues.map((i) => (i.path, i.code)),
      containsAll([
        ('username', 'min_length'),
        ('username', 'regex_mismatch'),
        ('email', 'invalid_email'),
        ('age', 'min_value'),
        ('birthDate', 'must_be_past'),
        ('luckyNumber', 'custom_validation_failed'),
      ]),
    );
  });

  test('Map<int, V> works without @EasyMapKey, safe mode included', () {
    expect(intKeyedFromJson({'names': {'1': 'a'}}).names, {1: 'a'});
    expect(intKeyedFromJsonSafe({'names': {'1': 'a'}}).names, {1: 'a'});
    expect(intKeyedToJson(IntKeyed(names: {1: 'a'})), {
      'names': {'1': 'a'},
    });

    final issues = <EasyIssue>[];
    final model = intKeyedFromJsonSafe({'names': {'1': 'a', 'x': 'b'}}, onIssue: issues.add);
    expect(model.names, {1: 'a'});
    expect(issues.map((i) => i.code), contains('key_type_mismatch'));
  });

  test('Strict mode', () {
    expect(
      () => signUpFromJson({'age': 'forty', 'email': 'ana@'}),
      throwsA(
        isA<EasyValidationException>().having((e) => '$e', 'toString', '''
EasyValidationException: 3 issue(s) found
  [missing_required] name: Missing required field.
  [type_mismatch] age: Expected int.
  [invalid_email] email: Invalid email.'''),
      ),
    );
  });

  test('Working with lists', () {
    final users = userFromJsonList([
      {'name': 'Ana', 'age': 30},
      {'name': 'Bia', 'age': 25},
    ]);
    expect(users.map((u) => u.name), ['Ana', 'Bia']);

    final reported = <String>[];
    userFromJsonSafeList(
      [
        {'name': 'Ana', 'age': 30},
        {'name': 'Bia', 'age': 'x'},
      ],
      onIssue: (index, issue) => reported.add('item $index: $issue'),
    );
    expect(reported, ['item 1: [type_mismatch] age: Expected int.']);

    expect(userToJsonList(users), [
      {'name': 'Ana', 'age': 30},
      {'name': 'Bia', 'age': 25},
    ]);
  });

  test('Generic classes', () {
    final page = pageResponseFromJson(
      {
        'items': [
          {'name': 'Ana', 'age': 30},
        ],
        'total': 1,
      },
      (item) => User.fromJson(item as Map<String, dynamic>),
    );
    expect(page.items.first.name, 'Ana');
    expect(page.total, 1);
    expect(page.toJson((user) => user.toJson()), {
      'items': [
        {'name': 'Ana', 'age': 30},
      ],
      'total': 1,
    });
  });

  test('Unions', () {
    final posts = [
      {'type': 'text', 'content': 'Hello'},
      {'type': 'video', 'url': 'https://youtu.be/x'},
      {'type': 'poll'},
    ].map(postFromJson).toList();
    expect(posts.map((p) => p.runtimeType), [TextPost, VideoPost, UnknownPost]);
  });

  test('Annotation reference (Order)', () {
    final order = orderFromJson({
      '_id': 'A-1',
      'customer_name': 'Ana',
      'shipping': {
        'address': {'city': 'Curitiba'},
      },
      'created_at': 1700000000000,
      'quantities': {'10': 2, '20': 1},
    });
    expect(order.id, 'A-1');
    expect(order.customerName, 'Ana');
    expect(order.city, 'Curitiba');
    expect(order.createdAt, DateTime.utc(2023, 11, 14, 22, 13, 20));
    expect(order.quantities, {10: 2, 20: 1});
    expect(order.selected, isFalse);

    final json = order.toJson();
    expect(json, {
      '_id': 'A-1',
      'customer_name': 'Ana',
      'created_at': 1700000000000,
      'quantities': {'10': 2, '20': 1},
      'shipping': {
        'address': {'city': 'Curitiba'},
      },
    });
    // toJson produz JSON de verdade (chaves String) e faz ida e volta.
    expect(orderFromJson(jsonDecode(jsonEncode(json))).city, 'Curitiba');
  });

  test('Inheritance', () {
    expect(UserModel(emailAddress: 'a@b.com').toJson(), {'email_address': 'a@b.com'});
  });

  test('Read-only and write-only models', () {
    expect(loginResponseFromJson({'token': 'abc'}).token, 'abc');
    expect(LoginRequest(user: 'ana', password: '123').toJson(), {
      'user': 'ana',
      'password': '123',
    });
  });
}
