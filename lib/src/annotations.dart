// Arquivo: lib/src/annotations.dart

/// Marca uma classe para a geração de código de serialização JSON.
class EasyJson {
  /// O comportamento padrão para a inclusão de campos nulos no método toJson().
  /// Se `false` (padrão), campos com valor nulo serão omitidos do JSON.
  /// Pode ser sobreposto por `@EasyKey(includeIfNull: ...)`.
  final bool includeIfNull;

   /// Estilo de chave para campos sem `name` explícito.
  final CaseStyle? caseStyle;

  const EasyJson({
    this.includeIfNull = false,
    this.caseStyle,
  });
}

/// Anota um campo para configurar como ele será serializado.
class EasyKey {
  /// O nome da chave que este campo terá no JSON.
  final String? name;

  /// Sobrepõe o comportamento de `EasyJson.includeIfNull` para este campo.
  /// Se `true`, o campo será incluído no JSON mesmo se for nulo.
  /// Se `false`, o campo será omitido do JSON se for nulo.
  /// Se não for definido (nulo), o padrão da classe em @EasyJson será usado.
  final bool? includeIfNull;

  /// Fallback para o CAMPO quando houver erro em SAFE.
  /// Ex.: int -> 42, String -> 'n/a', bool -> true, double -> 3.14, DateTime -> '2024-01-01T00:00:00Z' (string ISO)
  final Object? fallback;

  /// Para LISTAS de primitivos/enum: fallback do ITEM quando houver erro em SAFE.
  /// Ex.: itemFallback: 0, '' etc.
  final Object? itemFallback;

  /// Para ENUMs: nome do valor (byName) a usar como fallback quando houver erro em SAFE.
  /// Ex.: enumFallback: 'viewer'
  final String? enumFallback;

  const EasyKey({
    this.name,
    this.includeIfNull,
    this.fallback,
    this.itemFallback,
    this.enumFallback,
  });
}

enum EasyMapKeyType { string, int }

/// Converte um campo inteiro OU os valores de um Map< K,V >.
/// - fromJson/toJson: aplicados ao CAMPO inteiro (ex.: DateTime <-> epoch)
/// - valueFromJson/valueToJson: aplicados a CADA VALOR de Map< K,V >
class EasyConvert {
  final Function? fromJson;
  final Function? toJson;

  final Function? valueFromJson;
  final Function? valueToJson;

  const EasyConvert({
    this.fromJson,
    this.toJson,
    this.valueFromJson,
    this.valueToJson,
  });
}


/// Define como coagir a CHAVE do Map< K,V >, quando o JSON vem com string/num.
///
/// Ex.: @EasyMapKey(type: EasyMapKeyType.int)
///   JSON: {"1": "Ana", "2":"Bia"}  => Map< int,String > {1:"Ana", 2:"Bia"}
class EasyMapKey {
  final EasyMapKeyType type;
  // (opcional futuramente) serializeAs: como serializar a chave na saída
  const EasyMapKey({required this.type});
}

/// Estilos de chave para o JSON gerado/lido quando o campo não tiver `@EasyKey(name: ...)`.
enum CaseStyle { none, snake, kebab, camel, pascal }

/// Formatos de string pré-definidos para validação.
enum EasyFormat {
  /// Um endereço de e-mail válido.
  email,
  /// Uma URL válida (http ou https).
  url,
  /// Um UUID (Universally Unique Identifier) válido.
  uuid,
}

/// Adiciona regras de validação customizadas para um campo, que serão
/// verificadas pelos métodos `validate` e `fromJsonSafe`.
class EasyValidate {
  /// Para `String`: comprimento mínimo.
  /// Para `List`/`Set`/`Map`: número mínimo de elementos.
  final int? minLength;

  /// Para `String`: comprimento máximo.
  /// Para `List`/`Set`/`Map`: número máximo de elementos.
  final int? maxLength;

  /// Para `String`: um padrão de expressão regular que o valor deve corresponder.
  final String? regex;

  /// Para `num` (`int`/`double`): o valor mínimo permitido (inclusivo).
  final num? min;

  /// Para `num` (`int`/`double`): o valor máximo permitido (inclusivo).
  final num? max;

  /// Para `String`: um formato pré-definido que o valor deve corresponder.
  final EasyFormat? format;

  /// Para `DateTime`: o valor deve ser uma data no passado.
  final bool? past;

  /// Para `DateTime`: o valor deve ser uma data no futuro.
  final bool? future;

  /// Uma função de validação customizada.
  /// A função deve ser estática ou de nível superior, receber um argumento
  /// do tipo do campo e retornar `bool`.
  final Function? custom;

  const EasyValidate({
    this.minLength,
    this.maxLength,
    this.regex,
    this.min,
    this.max,
    this.format,
    this.past,
    this.future,
    this.custom,
  });
}