# easy\_json

Geração de `fromJson/toJson/validate/*Safe` com validação, fallback e *issue tracking*.

## Instalação

```yaml
dependencies:
   easy_json:
    git:
      url: https://github.com/llFurtll/easy_json.git

dev_dependencies:
  build_runner: ^2.4.0
```

Gere os arquivos:

```bash
dart run build_runner build -d
```

---

## Como usar (rápido)

```dart
@EasyJson(caseStyle: CaseStyle.snake, includeIfNull: false)
class User with UserSerializer {
  final String userName;     // "user_name"
  final DateTime createdAt;  // "created_at"
  @EasyKey(name: 'e_mail')
  final String? email;       // "e_mail"
}
```

Gerado (nomes podem variar):

```dart
User userFromJson(Map<String,dynamic> json)
Map<String,dynamic> userToJson(User instance)
List<EasyIssue> userValidate(Map<String,dynamic> json)
User userFromJsonSafe(Map<String,dynamic> json, {onIssue, runValidate=true})
```

---

## O que cada método faz

* `fromJson`
  Conversão **rápida**. Lança erro em tipos inconsistentes (especialmente primitivos/enum/DateTime).
  Útil quando input é confiável.

* `toJson`
  Serializa respeitando `caseStyle` e `includeIfNull` (ou `@EasyKey(name)` por campo).

* `validate`
  Só analisa o `Map` (não instancia a classe).
  Retorna `List<EasyIssue>` com: `missing_required`, `type_mismatch`, `invalid_enum`, etc.

* `fromJsonSafe`
  Conversão **tolerante**. Nunca lança; aplica fallbacks e reporta problemas via `onIssue(EasyIssue)`.
  Por padrão roda `validate` antes (`runValidate:true`).

---

## EasyIssue (retorno de problemas)

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
final user = userFromJsonSafe(json, onIssue: issues.add);
for (final i in issues) print('${i.path} - ${i.code}');
```

---

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

## Validação isolada (sem instanciar)

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