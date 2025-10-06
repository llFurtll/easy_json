import 'package:dart_easy_json/easy_json.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dart_easy_json/test_models.dart';
import 'package:dart_easy_json/generated/test_models.easy.dart';

void main() {
  group('User + caseStyle(snake) e @EasyKey(name)', () {
    test('toJson aplica snake_case e respeita override do name', () {
      final u = User(
        userName: 'Alice',
        createdAt: DateTime.parse('2024-01-02T03:04:05Z'),
        email: null, // includeIfNull: false => não serializa
      );

      final j = userToJson(u);

      // chaves derivadas do caseStyle
      expect(j.containsKey('user_name'), isTrue);
      expect(j.containsKey('created_at'), isTrue);

      // override manual
      expect(j.containsKey('e_mail'), isFalse); // email == null e includeIfNull=false

      // tipos plausíveis
      expect(j['user_name'], 'Alice');
      expect(j['created_at'], isA<String>()); // normalmente ISO-8601
    });

    test('fromJson lê snake_case corretamente (rápido)', () {
      final json = {
        'user_name': 'Bob',
        'created_at': '2025-03-04T10:20:30Z',
        'e_mail': 'bob@x.com',
      };

      final u = userFromJson(json);

      expect(u.userName, 'Bob');
      expect(u.createdAt, DateTime.parse('2025-03-04T10:20:30Z'));
      expect(u.email, 'bob@x.com');
    });

    test('fromJsonSafe: coage e reporta issues sem quebrar', () {
      final issues = <EasyIssue>[];

      final json = {
        // faltando 'user_name' (required) => issue
        'created_at': 1712345678901, // epoch ms -> deve ser aceito/coagido no safe
        'e_mail': 123,               // type mismatch => vira null + issue
      };

      final u = User.fromJsonSafe(json, onIssue: issues.add);

      // objeto criado com defaults/coerções
      expect(u.userName, isA<String>());
      expect(u.createdAt, isA<DateTime>());
      expect(u.email, isNull);

      // houve issues (missing_required + type_mismatch)
      expect(issues, isNotEmpty);
      final paths = issues.map((e) => e.path).toList();
      expect(paths, contains('user_name')); // faltou
      expect(paths, contains('e_mail'));    // type mismatch
    });
  });
}