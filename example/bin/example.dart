import 'dart:convert';
import 'package:easy_json/easy_json.dart';
import 'package:example/dolar_rate.dart';
import 'package:example/generated/dolar_rate.easy.dart';
import 'package:http/http.dart' as http;

Future<List<DollarRate>> fetchDollarRates() async {
  final uri = Uri.parse('https://dolarapi.com/v1/dolares');
  final res = await http.get(uri);

  if (res.statusCode != 200) {
    throw Exception('Falha ao carregar: ${res.statusCode}');
  }

  final raw = jsonDecode(res.body);
  if (raw is! List) {
    throw Exception('Resposta inesperada (não é uma lista)');
  }

  final issues = <EasyIssue>[];
  final rates = raw.map((e) {
    final map = Map<String, dynamic>.from(e as Map);
    // Usamos o SAFE para não quebrar se vier tipo trocado
    return dollarRateFromJsonSafe(map, onIssue: issues.add);
  }).toList();

  if (issues.isNotEmpty) {
    // apenas para depuração
    for (final i in issues) {
      // Ex.: "compra", "venta", etc.
      print('[issue] ${i.path} - ${i.code} - ${i.message}');
    }
  }

  return rates;
}

void main() async {
  try {
    final rates = await fetchDollarRates();

    // imprime um resumo bonitinho
    for (final r in rates) {
      print(
        '${r.name.padRight(24)} | '
        'buy: ${r.buy.toStringAsFixed(2).padLeft(8)} | '
        'sell: ${r.sell.toStringAsFixed(2).padLeft(8)} | '
        'updated: ${r.updatedAt.toIso8601String()}',
      );
    }
  } catch (e) {
    print('Erro: $e');
  }
}
