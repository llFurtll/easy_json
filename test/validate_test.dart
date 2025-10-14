// test/validate_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:dart_easy_json/generated/test_models.easy.dart';

void main() {
  group('ValidationModel validations', () {
    // Testes para 'username' (minLength, maxLength)
    test('username should fail if too short', () {
      final json = {
        'username': 'ab',
        'age': 25,
        'tags': ['a'],
        'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
        'dateOfBirth': '2000-01-01T00:00:00.000Z',
      };
      final issues = validationModelValidate(json);
      expect(
          issues.any((i) => i.path == 'username' && i.code == 'min_length'), isTrue);
    });

    test('username should fail if too long', () {
      final json = {
        'username': 'abcdefghijklm',
        'age': 25,
        'tags': ['a'],
        'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
        'dateOfBirth': '2000-01-01T00:00:00.000Z',
      };
      final issues = validationModelValidate(json);
      expect(
          issues.any((i) => i.path == 'username' && i.code == 'max_length'), isTrue);
    });

    test('username should pass if within length limits', () {
      final json = {
        'username': 'validuser',
        'age': 25,
        'tags': ['a'],
        'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
        'dateOfBirth': '2000-01-01T00:00:00.000Z',
      };
      final issues = validationModelValidate(json);
      expect(issues.any((i) => i.path == 'username'), isFalse);
    });

    // Testes para 'age' (min, max)
    test('age should fail if below minimum', () {
      final json = {
        'username': 'test',
        'age': 17,
        'tags': ['a'],
        'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
        'dateOfBirth': '2000-01-01T00:00:00.000Z',
      };
      final issues = validationModelValidate(json);
      expect(issues.any((i) => i.path == 'age' && i.code == 'min_value'), isTrue);
    });

    test('age should fail if above maximum', () {
      final json = {
        'username': 'test',
        'age': 100,
        'tags': ['a'],
        'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
        'dateOfBirth': '2000-01-01T00:00:00.000Z',
      };
      final issues = validationModelValidate(json);
      expect(issues.any((i) => i.path == 'age' && i.code == 'max_value'), isTrue);
    });

    test('age should pass if within range', () {
      final json = {
        'username': 'test',
        'age': 30,
        'tags': ['a'],
        'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
        'dateOfBirth': '2000-01-01T00:00:00.000Z',
      };
      final issues = validationModelValidate(json);
      expect(issues.any((i) => i.path == 'age'), isFalse);
    });

    // Testes para 'email' (regex)
    test('email should fail if regex does not match', () {
      final json = {
        'username': 'test',
        'age': 30,
        'email': 'invalid-email',
        'tags': ['a'],
        'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
        'dateOfBirth': '2000-01-01T00:00:00.000Z',
      };
      final issues = validationModelValidate(json);
      expect(
          issues.any((i) => i.path == 'email' && i.code == 'regex_mismatch'),
          isTrue);
    });

    test('email should pass if regex matches', () {
      final json = {
        'username': 'test',
        'age': 30,
        'email': 'test@example.com',
        'tags': ['a'],
        'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
        'dateOfBirth': '2000-01-01T00:00:00.000Z',
      };
      final issues = validationModelValidate(json);
      expect(issues.any((i) => i.path == 'email'), isFalse);
    });

    test('email should be optional and pass if null', () {
      final json = {
        'username': 'test',
        'age': 30,
        'tags': ['a'],
        'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
        'dateOfBirth': '2000-01-01T00:00:00.000Z',
      };
      final issues = validationModelValidate(json);
      expect(issues.any((i) => i.path == 'email'), isFalse);
    });

    // Testes para 'tags' (minLength, maxLength for List)
    test('tags list should fail if too short', () {
      final json = {
        'username': 'test',
        'age': 30,
        'tags': [],
        'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
        'dateOfBirth': '2000-01-01T00:00:00.000Z',
      };
      final issues = validationModelValidate(json);
      expect(issues.any((i) => i.path == 'tags' && i.code == 'min_length'), isTrue);
    });

    test('tags list should fail if too long', () {
      final json = {
        'username': 'test',
        'age': 30,
        'tags': ['a', 'b', 'c', 'd'],
        'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
        'dateOfBirth': '2000-01-01T00:00:00.000Z',
      };
      final issues = validationModelValidate(json);
      expect(issues.any((i) => i.path == 'tags' && i.code == 'max_length'), isTrue);
    });

    test('tags list should pass if within size limits', () {
      final json = {
        'username': 'test',
        'age': 30,
        'tags': ['a', 'b'],
        'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
        'dateOfBirth': '2000-01-01T00:00:00.000Z',
      };
      final issues = validationModelValidate(json);
      expect(issues.any((i) => i.path == 'tags'), isFalse);
    });

    // Testes para 'format' (url, uuid)
    group('format validation', () {
      test('websiteUrl should fail for invalid URL', () {
        final json = {
          'username': 'test',
          'age': 30,
          'tags': ['a'],
          'websiteUrl': 'not-a-url',
          'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
          'dateOfBirth': '2000-01-01T00:00:00.000Z',
        };
        final issues = validationModelValidate(json);
        expect(issues.any((i) => i.path == 'websiteUrl' && i.code == 'invalid_url'), isTrue);
      });

      test('websiteUrl should pass for valid URL', () {
        final json = {
          'username': 'test',
          'age': 30,
          'tags': ['a'],
          'websiteUrl': 'https://example.com',
          'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
          'dateOfBirth': '2000-01-01T00:00:00.000Z',
        };
        final issues = validationModelValidate(json);
        expect(issues.any((i) => i.path == 'websiteUrl'), isFalse);
      });

      test('uniqueId should fail for invalid UUID', () {
        final json = {
          'username': 'test',
          'age': 30,
          'tags': ['a'],
          'uniqueId': 'not-a-uuid',
          'dateOfBirth': '2000-01-01T00:00:00.000Z',
        };
        final issues = validationModelValidate(json);
        expect(issues.any((i) => i.path == 'uniqueId' && i.code == 'invalid_uuid'), isTrue);
      });

      test('uniqueId should pass for valid UUID', () {
        final json = {
          'username': 'test',
          'age': 30,
          'tags': ['a'],
          'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
          'dateOfBirth': '2000-01-01T00:00:00.000Z',
        };
        final issues = validationModelValidate(json);
        expect(issues.any((i) => i.path == 'uniqueId'), isFalse);
      });
    });

    // Testes para 'past' e 'future' (DateTime)
    group('DateTime validation', () {
      test('dateOfBirth should fail if in the future', () {
        final futureDate = DateTime.now().add(const Duration(days: 1)).toIso8601String();
        final json = {
          'username': 'test',
          'age': 30,
          'tags': ['a'],
          'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
          'dateOfBirth': futureDate,
        };
        final issues = validationModelValidate(json);
        expect(issues.any((i) => i.path == 'dateOfBirth' && i.code == 'must_be_past'), isTrue);
      });

      test('dateOfBirth should pass if in the past', () {
        final pastDate = DateTime.now().subtract(const Duration(days: 1)).toIso8601String();
        final json = {
          'username': 'test',
          'age': 30,
          'tags': ['a'],
          'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
          'dateOfBirth': pastDate,
        };
        final issues = validationModelValidate(json);
        expect(issues.any((i) => i.path == 'dateOfBirth'), isFalse);
      });

      test('nextAppointment should fail if in the past', () {
        final pastDate = DateTime.now().subtract(const Duration(days: 1)).toIso8601String();
        final json = {
          'username': 'test',
          'age': 30,
          'tags': ['a'],
          'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
          'dateOfBirth': '2000-01-01T00:00:00.000Z',
          'nextAppointment': pastDate,
        };
        final issues = validationModelValidate(json);
        expect(issues.any((i) => i.path == 'nextAppointment' && i.code == 'must_be_future'), isTrue);
      });

      test('nextAppointment should pass if in the future', () {
        final futureDate = DateTime.now().add(const Duration(days: 1)).toIso8601String();
        final json = {
          'username': 'test',
          'age': 30,
          'tags': ['a'],
          'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
          'dateOfBirth': '2000-01-01T00:00:00.000Z',
          'nextAppointment': futureDate,
        };
        final issues = validationModelValidate(json);
        expect(issues.any((i) => i.path == 'nextAppointment'), isFalse);
      });
    });

    // Testes para validação 'custom'
    group('Custom validation', () {
      test('age should fail custom validation if not positive', () {
        final json = {
          'username': 'test',
          'age': -5, // Valor inválido para a função customizada 'isPositive'
          'tags': ['a'],
          'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
          'dateOfBirth': '2000-01-01T00:00:00.000Z',
        };
        final issues = validationModelValidate(json);
        expect(
            issues.any((i) =>
                i.path == 'age' && i.code == 'custom_validation_failed'),
            isTrue);
      });

      test('age should pass custom validation if positive', () {
        final json = {
          'username': 'test',
          'age': 25, // Valor válido para 'isPositive' e para min/max
          'tags': ['a'],
          'uniqueId': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
          'dateOfBirth': '2000-01-01T00:00:00.000Z',
        };
        final issues = validationModelValidate(json);
        // Verifica que NENHUMA issue de validação customizada foi gerada para 'age'
        expect(
            issues.any((i) => i.path == 'age' && i.code == 'custom_validation_failed'),
            isFalse);
      });
    });
  });
}
