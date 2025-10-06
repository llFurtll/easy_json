import 'package:dart_easy_json/easy_json.dart';
import 'package:example/generated/dolar_rate.easy.dart';

@EasyJson()
class DollarRate with DollarRateSerializer {
  @EasyKey(name: 'moneda')
  final String currency;

  @EasyKey(name: 'casa')
  final String house;

  @EasyKey(name: 'nombre')
  final String name;

  // A API às vezes manda int, às vezes double → o generator já trata num→double
  @EasyKey(name: 'compra')
  final double buy;

  @EasyKey(name: 'venta')
  final double sell;

  // A API retorna ISO-8601; o SAFE também aceita epoch se um dia mudar
  @EasyKey(name: 'fechaActualizacion')
  final DateTime updatedAt;

  DollarRate({
    required this.currency,
    required this.house,
    required this.name,
    required this.buy,
    required this.sell,
    required this.updatedAt,
  });
}
