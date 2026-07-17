import 'package:dart_easy_json/easy_json.dart';
import 'models/test_models.dart';
import 'package:test/test.dart';

void main() {
  group('Novas Funcionalidades', () {
    group('@EasyIgnore', () {
      test('deve ignorar o campo na serialização (toJson)', () {
        final model = IgnoreModel(visible: 'hello', secret: 'my_secret');
        final json = model.toJson();

        expect(json, containsPair('visible', 'hello'));
        expect(
          json.containsKey('secret'),
          isFalse,
          reason: 'O campo secret deve ser ignorado',
        );
      });

      test('deve ignorar o campo na desserialização (fromJson)', () {
        final json = {'visible': 'world', 'secret': 'hacker_value'};
        final model = IgnoreModel.fromJson(json);

        expect(model.visible, 'world');
        // Como foi ignorado no fromJson, ele deve assumir o valor padrão do construtor
        expect(model.secret, 'default_secret');
      });

      test(
        'fromJsonSafe: deve ignorar campo e não reportar erro mesmo se json tiver tipo errado',
        () {
          final issues = <EasyIssue>[];
          final json = {
            'visible': 'seen',
            'secret':
                12345, // Tipo errado (int em vez de String), mas deve ser ignorado
          };

          final model = IgnoreModel.fromJsonSafe(json, onIssue: issues.add);

          expect(model.visible, 'seen');
          expect(model.secret, 'default_secret');
          expect(issues, isEmpty, reason: 'Não deve validar campos ignorados');
        },
      );
    });

    group('@EasyPath', () {
      test('deve ler valores de caminhos aninhados', () {
        final json = {
          'meta': {
            'count': 42,
            'info': {'user_name': 'dash_dev'},
          },
        };

        final model = PathModel.fromJson(json);

        expect(model.count, 42);
        expect(model.userName, 'dash_dev');
      });

      test(
        'deve tratar caminhos inexistentes ou nulos com segurança (usando defaults)',
        () {
          // JSON incompleto
          final json = {
            'meta': {
              // 'count' faltando
              'info': null, // 'info' nulo quebra o caminho para user_name
            },
          };

          final model = PathModel.fromJson(json);

          expect(model.count, 0, reason: 'Deve usar o default de int (0)');
          expect(
            model.userName,
            '',
            reason: 'Deve usar o default de String ("")',
          );
        },
      );

      test(
        'fromJsonSafe: deve reportar erro se caminho aninhado estiver faltando (missing_required)',
        () {
          final issues = <EasyIssue>[];
          final json = {
            'meta': {
              // 'count' faltando
              'info': {
                // 'user_name' faltando
              },
            },
          };

          final model = PathModel.fromJsonSafe(json, onIssue: issues.add);

          expect(model.count, 0);
          expect(model.userName, '');

          final paths = issues.map((i) => i.path).toList();
          expect(paths, containsAll(['meta.count', 'meta.info.user_name']));
          expect(issues.map((i) => i.code), everyElement('missing_required'));
        },
      );

      test(
        'fromJsonSafe: deve reportar erro de tipo em caminho aninhado (type_mismatch)',
        () {
          final issues = <EasyIssue>[];
          final json = {
            'meta': {
              'count': 'not_an_int',
              'info': {
                'user_name': 12345, // not a string
              },
            },
          };

          final model = PathModel.fromJsonSafe(json, onIssue: issues.add);

          expect(model.count, 0);
          expect(model.userName, '');

          final paths = issues.map((i) => i.path).toList();
          expect(paths, containsAll(['meta.count', 'meta.info.user_name']));
          expect(issues.map((i) => i.code), everyElement('type_mismatch'));
        },
      );

      test('fromJsonSafe: não deve reportar erros se tudo estiver correto', () {
        final issues = <EasyIssue>[];
        final json = {
          'meta': {
            'count': 100,
            'info': {'user_name': 'ok_user'},
          },
        };

        final model = PathModel.fromJsonSafe(json, onIssue: issues.add);

        expect(model.count, 100);
        expect(model.userName, 'ok_user');
        expect(issues, isEmpty);
      });
    });
  });
}
