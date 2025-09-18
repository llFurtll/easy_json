const kListSafeTpl = """
(() {
  final _v = {VALUE};
  if (_v is! List) return {FALLBACK};
  final _list = _v;
  return _list.asMap().entries.map<{ITEM_T}>((entry) {
    final idx = entry.key;
    final elem = entry.value;
    return {ITEM_PARSE};
  }).toList();
})()
""";

const kListFastTpl = r"""
({VALUE} as List?)
  ?.asMap().entries.map<{ITEM_T}>((entry){final i=entry.key; final e=entry.value; return {ITEM_PARSE};}).toList()
""";

const kSetSafeTpl = r"""
(() {
  final _v = {VALUE};
  if (_v is! List) return {FALLBACK};
  final _list = _v;
  return _list.asMap().entries.map<{ITEM_T}>((entry) {
    final i = entry.key;
    final e = entry.value;
    return {ITEM_PARSE};
  }).toSet();
})()
""";

const kSetFastTpl = r"""
({VALUE} as List?)
  ?.asMap().entries.map<{ITEM_T}>((entry){final i=entry.key; final e=entry.value; return {ITEM_PARSE};}).toSet()
""";

const kMapSafeTpl = r"""
(() {
  final _v = {VALUE};
  if (_v is! Map) return {FALLBACK};
  final _mapRaw = Map<dynamic,dynamic>.from(_v as Map);
  final _out = <{K_T}, {V_T}>{};
  for (final entry in _mapRaw.entries) {
    final k = {KEY_PARSE};
    if (k == null) { {ON_ISSUE_KEY}; continue; }
    final v = {VAL_PARSE};
    _out[k] = v;
  }
  return _out;
})()
""";

const kMapFastTpl = """
(Map<dynamic,dynamic>.from({VALUE} as Map))
  .entries
  .fold(<{K_T}, {V_T}>{}, (acc, entry) {
    final k = {KEY_PARSE_FAST};
    final v = {VAL_PARSE};
    acc[k] = v;
    return acc;
  })
""";
