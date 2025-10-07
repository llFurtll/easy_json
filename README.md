# Easy JSON

Uma poderosa ferramenta de geração de código para serialização e desserialização JSON em Dart. Focada em segurança, performance e facilidade de uso, ela cria métodos `fromJson`, `toJson`, `validate` e `fromJsonSafe` com validação robusta, fallbacks configuráveis e rastreamento de issues.

## Principais Funcionalidades

*   **Geração Automática**: Cria todo o boilerplate de serialização para você.
*   **Segurança de Tipos**: Valida os tipos de dados do JSON antes da desserialização.
*   **Desserialização Segura**: Oferece um método `fromJsonSafe` que nunca lança exceções, usando fallbacks e reportando problemas.
*   **Validação Detalhada**: Gera um método `validate` que retorna uma lista de problemas (`EasyIssue`) encontrados no JSON, sem precisar instanciar o objeto.
*   **Altamente Customizável**: Suporte para `caseStyle`, nomes de chaves customizados, conversores, fallbacks por campo e muito mais.

## Instalação

Adicione as dependências ao seu arquivo `pubspec.yaml`:

```yaml
dependencies:
  dart_easy_json: ^0.2.0 # Verifique a versão mais recente no pub.dev

dev_dependencies:
  build_runner: ^2.4.0
```

## Uso Básico

1.  **Anote sua classe** com `@EasyJson` e adicione o `mixin` correspondente para ter o método `toJson()` diretamente na sua instância.

```dart
import 'package:dart_easy_json/easy_json.dart';

// Importe o arquivo que será gerado
import 'package:meu_projeto/generated/user.easy.dart';

@EasyJson(caseStyle: CaseStyle.snake, includeIfNull: false)
class User with UserSerializer {
  final String userName;
  final DateTime createdAt;

  @EasyKey(name: 'e_mail')
  final String? email;

  // Construtor e factory para conveniência
  const User({required this.userName, required this.createdAt, this.email});
  factory User.fromJson(Map<String, dynamic> json) => userFromJson(json);
}
```

2.  **Execute o gerador de código** na raiz do seu projeto:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Isso irá gerar um arquivo `user.easy.dart` (o nome pode variar) com os seguintes métodos:

*   `userFromJson(Map<String, dynamic> json)`: Conversão rápida, mas pode lançar erros.
*   `userToJson(User instance)`: Serializa o objeto para um mapa.
*   `userValidate(Map<String, dynamic> json)`: Valida o mapa e retorna uma lista de `EasyIssue`.
*   `userFromJsonSafe(...)`: Conversão segura que nunca falha e reporta problemas.

## Configurando a Geração de Código (`build.yaml`)

Por padrão, os arquivos são gerados ao lado dos arquivos de origem com a extensão `.easy.dart`. Para organizar melhor seu projeto, você pode especificar um diretório de saída customizado.

Crie um arquivo `build.yaml` na raiz do seu projeto e configure a saída para um diretório como `lib/generated`:

```yaml
# build.yaml
targets:
  $default:
    builders:
      dart_easy_json:easy_json_builder:
        options:
          build_extensions:
            # Mapeia entrada (lib/models/user.dart) para saída (lib/generated/models/user.easy.dart)
            "^lib/{{}}.dart": "lib/generated/{{}}.easy.dart"
```

Com essa configuração, o `build_runner` colocará todos os arquivos gerados dentro de `lib/generated`, preservando a estrutura de pastas original. Lembre-se de ajustar os `import`s nos seus arquivos de modelo para apontar para o novo local.

## Tratamento de Erros com `EasyIssue`

O método `fromJsonSafe` é a forma mais robusta de desserializar dados, pois ele captura todos os problemas sem interromper a execução.

```dart
class EasyIssue {
  final String path;   // ex: "address.number", "tags[2]"
  final String code;   // ex: "type_mismatch", "missing_required"
  final String message;
}
```

Exemplo de uso:

```dart
final issues = <EasyIssue>[];
final user = User.fromJsonSafe(json, onIssue: issues.add);

for (final i in issues) print('${i.path} - ${i.code}');
// Saída:
// e_mail - type_mismatch
// user_name - missing_required
```

## Regras rápidas

* **Case Style**
  `@EasyJson(caseStyle: CaseStyle.snake)` → `userName` ↔ `user_name`.
  `@EasyKey(name: 'e_mail')` sobrescreve o nome do campo.

* **Enum**

  * `fromJson`: `Enum.values.byName(...)` (string inválida → **erro**).
  * `fromJsonSafe`: aceita **string** ou **índice**; se inválido usa `fallback` (`@EasyKey(enumFallbackName: 'guest')`) e gera `EasyIssue`.

* **DateTime**

  * `fromJson`: normalmente espera `String ISO` (ou seu converter).
  * `fromJsonSafe`: aceita `String ISO`, `int/num epoch(ms)`, `DateTime`; senão, fallback `DateTime(0)` + `EasyIssue`.

* **Coleções (List/Set/Map)**

  * `fromJsonSafe`: coage itens/valores inválidos para fallback, **marca o índice/chave** em `path`.
  * `Set`: itens inválidos são **descartados** (mantém unicidade).

* **Fallbacks per-field**
  `@EasyKey(fallback: '0')`, `@EasyKey(itemFallback: "''")`, etc.
  (Se não definir, o gerador escolhe um valor padrão seguro.)

---

## Conversores custom (rápido)

```dart
class TmDateMs {
  static DateTime fromJson(Object? v) => DateTime.fromMillisecondsSinceEpoch(v as int);
  static Object toJson(DateTime v) => v.millisecondsSinceEpoch;
} 

@EasyJson()
class Order {
  @EasyKey(convertFromJson: TmDateMs.fromJson, convertToJson: TmDateMs.toJson)
  final DateTime createdAt;
}
```

---

## Validação Isolada

Se você precisa apenas validar um payload JSON sem o custo de criar o objeto, use o método `validate`:

```dart
final problems = orderValidate(json);
if (problems.isNotEmpty) print(problems.first.message);
```

---

## Exemplo completo (rápido)

```dart
final issues = <EasyIssue>[];
final order = orderFromJsonSafe(json, onIssue: issues.add);
print(order.toJson());
print(issues.map((e) => '${e.path}: ${e.code}').toList());
```