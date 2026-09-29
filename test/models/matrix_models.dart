// Modelos da matriz de testes (test/matrix_test.dart): cada tipo suportado,
// puro e nullable, e dentro de List / Set / Map.
import 'dart:typed_data';

import 'package:dart_easy_json/easy_json.dart';

import 'matrix_models.easy.dart';

enum Color { red, green }

@EasyJson()
class Inner with InnerSerializer {
  final int n;
  Inner({required this.n});
}

@EasyJson()
class Scalars with ScalarsSerializer {
  final int i;
  final int? iN;
  final double d;
  final double? dN;
  final num n;
  final num? nN;
  final bool b;
  final bool? bN;
  final String s;
  final String? sN;
  final DateTime dt;
  final DateTime? dtN;
  final Uri u;
  final Uri? uN;
  final Duration du;
  final Duration? duN;
  final BigInt bi;
  final BigInt? biN;
  final Uint8List by;
  final Uint8List? byN;
  final Color c;
  final Color? cN;
  final Inner o;
  final Inner? oN;

  Scalars({
    required this.i,
    this.iN,
    required this.d,
    this.dN,
    required this.n,
    this.nN,
    required this.b,
    this.bN,
    required this.s,
    this.sN,
    required this.dt,
    this.dtN,
    required this.u,
    this.uN,
    required this.du,
    this.duN,
    required this.bi,
    this.biN,
    required this.by,
    this.byN,
    required this.c,
    this.cN,
    required this.o,
    this.oN,
  });
}

@EasyJson()
class Lists with ListsSerializer {
  final List<int> i;
  final List<double> d;
  final List<num> n;
  final List<bool> b;
  final List<String> s;
  final List<DateTime> dt;
  final List<Uri> u;
  final List<Duration> du;
  final List<BigInt> bi;
  final List<Uint8List> by;
  final List<Color> c;
  final List<Inner> o;
  final List<int?> iN;
  final List<int>? nullableList;

  Lists({
    required this.i,
    required this.d,
    required this.n,
    required this.b,
    required this.s,
    required this.dt,
    required this.u,
    required this.du,
    required this.bi,
    required this.by,
    required this.c,
    required this.o,
    required this.iN,
    this.nullableList,
  });
}

@EasyJson()
class Sets with SetsSerializer {
  final Set<int> i;
  final Set<double> d;
  final Set<String> s;
  final Set<DateTime> dt;
  final Set<Uri> u;
  final Set<Duration> du;
  final Set<BigInt> bi;
  final Set<Color> c;
  final Set<int>? nullableSet;

  Sets({
    required this.i,
    required this.d,
    required this.s,
    required this.dt,
    required this.u,
    required this.du,
    required this.bi,
    required this.c,
    this.nullableSet,
  });
}

@EasyJson()
class Maps with MapsSerializer {
  final Map<String, int> i;
  final Map<String, double> d;
  final Map<String, bool> b;
  final Map<String, String> s;
  final Map<String, DateTime> dt;
  final Map<String, Uri> u;
  final Map<String, Duration> du;
  final Map<String, BigInt> bi;
  final Map<String, Uint8List> by;
  final Map<String, Color> c;
  final Map<String, Inner> o;
  final Map<int, String> ik;
  final Map<String, int?> iN;
  final Map<String, int>? nullableMap;

  Maps({
    required this.i,
    required this.d,
    required this.b,
    required this.s,
    required this.dt,
    required this.u,
    required this.du,
    required this.bi,
    required this.by,
    required this.c,
    required this.o,
    required this.ik,
    required this.iN,
    this.nullableMap,
  });
}

/// Um `@EasyKey(fallback:)` por tipo que suporta fallback, e `itemFallback`.
@EasyJson()
class Fallbacks with FallbacksSerializer {
  @EasyKey(fallback: -1)
  final int i;
  @EasyKey(fallback: 1)
  final double d;
  @EasyKey(fallback: 2)
  final num n;
  @EasyKey(fallback: true)
  final bool b;
  @EasyKey(fallback: r'R$ 0,00')
  final String s;
  @EasyKey(fallback: '2020-01-01T00:00:00.000Z')
  final DateTime dt;
  @EasyKey(fallback: 'https://fallback.dev')
  final Uri u;
  @EasyKey(fallback: 42)
  final Duration du;
  @EasyKey(fallback: '99')
  final BigInt bi;
  @EasyKey(fallback: 'AQID')
  final Uint8List by;
  @EasyKey(fallback: 'https://nullable.dev')
  final Uri? uN;

  @EasyKey(itemFallback: 0)
  final List<int> li;
  @EasyKey(itemFallback: 1000)
  final List<DateTime> ldt;
  @EasyKey(itemFallback: 'https://item.dev')
  final Map<String, Uri> mu;

  Fallbacks({
    required this.i,
    required this.d,
    required this.n,
    required this.b,
    required this.s,
    required this.dt,
    required this.u,
    required this.du,
    required this.bi,
    required this.by,
    this.uN,
    required this.li,
    required this.ldt,
    required this.mu,
  });
}

/// Coleções dentro de coleções (e nullables em cada nível).
@EasyJson()
class Nested with NestedSerializer {
  final List<List<int>> li;
  final List<List<int>?> lin;
  final List<Set<String>> ls;
  final Set<List<double>> sl;
  final Map<String, List<int>> ml;
  final List<Map<String, int>> lm;
  final Map<String, Map<int, Color>> mm;
  final List<List<Inner>> lo;
  final List<List<DateTime?>> ldt;
  final List<List<List<bool>>>? deep;

  Nested({
    required this.li,
    required this.lin,
    required this.ls,
    required this.sl,
    required this.ml,
    required this.lm,
    required this.mm,
    required this.lo,
    required this.ldt,
    this.deep,
  });
}
