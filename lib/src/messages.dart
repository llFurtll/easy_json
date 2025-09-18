// lib/src/messages.dart
library;

class EasyMessages {
  static String missingRequired(String path) =>
      'Campo obrigatório ausente.';

  static String typeMismatch(String path, String expected) =>
      'Esperado $expected.';

  static String invalidEnum(String path, String enumName, Object? got) =>
      "Valor '$got' não corresponde a $enumName.";

  static String nullNotAllowed(String path) =>
      'Valor nulo não permitido.';

  static String keyTypeMismatch(String path) =>
      'Chave incompatível com o tipo do mapa.';
}
