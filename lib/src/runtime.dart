// lib/src/runtime.dart
library;

/// Coerções básicas usadas no SAFE e no fast parse.
/// Todas são "permissivas" e nunca lançam exceção.

int? asIntOrNull(Object? v) {
  if (v == null) return null;
  if (v is int) return v;
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v);
  return null;
}

int asInt(Object? v, {int fallback = 0}) => asIntOrNull(v) ?? fallback;

double? asDoubleOrNull(Object? v) {
  if (v == null) return null;
  if (v is double) return v;
  if (v is num) return v.toDouble();
  if (v is String) return double.tryParse(v);
  return null;
}

double asDouble(Object? v, {double fallback = 0.0}) => asDoubleOrNull(v) ?? fallback;

bool? asBoolOrNull(Object? v) {
  if (v == null) return null;
  if (v is bool) return v;
  if (v is String) {
    final s = v.toLowerCase().trim();
    if (s == 'true' || s == '1') return true;
    if (s == 'false' || s == '0') return false;
  }
  if (v is num) return v != 0;
  return null;
}

bool asBool(Object? v, {bool fallback = false}) => asBoolOrNull(v) ?? fallback;

String? asStringOrNull(Object? v) => v?.toString();

String asString(Object? v, {String fallback = ''}) => asStringOrNull(v) ?? fallback;

/// DateTime helpers
DateTime? parseDateTimeOrNull(Object? v) {
  if (v == null) return null;
  if (v is DateTime) return v;
  if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
  if (v is num) return DateTime.fromMillisecondsSinceEpoch(v.toInt());
  if (v is String) {
    try { return DateTime.parse(v); } catch (_) {}
  }
  return null;
}

DateTime parseDateTime(Object? v, {DateTime? fallback}) =>
    parseDateTimeOrNull(v) ?? (fallback ?? DateTime.fromMillisecondsSinceEpoch(0));

/// Enums
T enumByNameOr<T extends Enum>(List<T> values, Object? v, T fallback) {
  final s = v?.toString();
  if (s == null) return fallback;
  for (final e in values) {
    if (e.name == s) return e;
  }
  return fallback;
}

/// Map key coercion
int? coerceKeyIntOrNull(Object? k) {
  if (k is int) return k;
  if (k is num) return k.toInt();
  if (k is String) return int.tryParse(k);
  return null;
}

String coerceKeyString(Object? k) => k is String ? k : k.toString();

/// Iteradores com índice (para List/Set/Map) — economizam código gerado
typedef ListItemMapper<T> = T Function(int index, Object? raw);
List<T>? mapListOrNull<T>(Object? raw, ListItemMapper<T> f) {
  if (raw is! List) return null;
  final out = <T>[];
  for (var i = 0; i < raw.length; i++) {
    out.add(f(i, raw[i]));
  }
  return out;
}

typedef SetItemMapper<T> = T Function(int index, Object? raw);
Set<T>? mapSetOrNull<T>(Object? raw, SetItemMapper<T> f) {
  if (raw is! List) return null;
  final out = <T>{};
  for (var i = 0; i < raw.length; i++) {
    out.add(f(i, raw[i]));
  }
  return out;
}

typedef MapEntryMapper<K, V> = MapEntry<K, V>? Function(Object key, Object? value);

Map<K, V>? mapMapOrNull<K, V>(Object? raw, MapEntryMapper<K, V> f) {
  if (raw is! Map) return null;
  final m = Map<dynamic, dynamic>.from(raw);
  final out = <K, V>{};
  for (final e in m.entries) {
    final mapped = f(e.key, e.value);
    if (mapped != null) out[mapped.key] = mapped.value;
  }
  return out;
}
