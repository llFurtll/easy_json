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