import 'package:dart_easy_json/easy_json.dart';
import 'models/test_models.dart';
import 'package:test/test.dart';

void main() {
  group('Herança de Classes (Inheritance)', () {
    test(
      'deve serializar campos da classe pai e da classe filha corretamente',
      () {
        final model = InheritedModel(
          baseId: 'id-123',
          baseName: 'My Base Name',
          childValue: 42,
        );

        final json = model.toJson();

        // Campo herdado, mas com o nome alterado pelo CaseStyle.snake da classe filha
        expect(json, containsPair('base_id', 'id-123'));

        // Campo herdado e sobrescrito com @EasyKey na classe filha
        expect(json, containsPair('custom_base_name', 'My Base Name'));

        // Campo da própria classe filha (CaseStyle.snake aplicado)
        expect(json, containsPair('child_value', 42));
      },
    );

    test('deve desserializar json para campos herdados e sobrescritos', () {
      final json = {
        'base_id': 'id-999',
        'custom_base_name': 'Overridden Name',
        'child_value': 100,
      };

      final model = InheritedModel.fromJson(json);

      expect(model.baseId, 'id-999');
      expect(model.baseName, 'Overridden Name');
      expect(model.childValue, 100);
    });

    test(
      'fromJsonSafe: deve aplicar validações e defaults nos campos herdados',
      () {
        final issues = <EasyIssue>[];
        final json = {
          'base_id':
              12345, // tipo incorreto, deve gerar issue e usar fallback (string vazia)
          'custom_base_name': 'Safe Name',
          'child_value': 'not_an_int', // tipo incorreto
        };

        final model = InheritedModel.fromJsonSafe(json, onIssue: issues.add);

        expect(model.baseId, ''); // fallback de String
        expect(model.baseName, 'Safe Name');
        expect(model.childValue, 0); // fallback de int

        final issuePaths = issues.map((i) => i.path).toList();
        expect(issuePaths, containsAll(['base_id', 'child_value']));
      },
    );
  });
}
