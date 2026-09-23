// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// EasyJsonGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// EasyJsonGenerator
// **************************************************************************

// ignore_for_file: type=lint, unused_import, unnecessary_cast, unused_local_variable, duplicate_import
import 'matrix_models.dart';
import 'matrix_models.dart';
import 'matrix_models.easy.dart';

import 'package:dart_easy_json/runtime.dart';

import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_easy_json/runtime.dart' as ej;

Inner innerFromJson(Map<String, dynamic> json) {
  return Inner(n: (json['n'] as int?) ?? 0);
}

Map<String, dynamic> innerToJson(Inner instance) {
  return <String, dynamic>{'n': instance.n};
}

mixin InnerSerializer {
  Map<String, dynamic> toJson() {
    return innerToJson(this as Inner);
  }
}

List<EasyIssue> innerValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('n')) {
    issues.add(
      EasyIssue(
        path: 'n',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('n') && json['n'] == null) {
    issues.add(
      EasyIssue(
        path: 'n',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('n')) {
    final v = json['n'];
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(path: 'n', code: 'type_mismatch', message: 'Expected int.'),
        );
      } else {
        final v = _n;
      }
    }
  }
  return issues;
}

Inner innerFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in innerValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Inner(
    n: (() {
      final v = json['n'];
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return p;
      }
      return 0;
    })(),
  ))(_report);
}

class InnerJson {
  const InnerJson();

  static Inner fromJson(Map<String, dynamic> json) {
    return innerFromJson(json);
  }

  static Inner fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return innerFromJsonSafe(json, onIssue: onIssue, runValidate: runValidate);
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return innerValidate(json);
  }
}

List<Inner> innerFromJsonList(List<dynamic> json) =>
    json.map((e) => innerFromJson(e as Map<String, dynamic>)).toList();

List<Inner> innerFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => innerFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> innerToJsonList(List<Inner> items) =>
    items.map((e) => innerToJson(e)).toList();

Scalars scalarsFromJson(Map<String, dynamic> json) {
  return Scalars(
    i: (json['i'] as int?) ?? 0,
    iN: json['iN'] as int?,
    d: (json['d'] as num?)?.toDouble() ?? 0.0,
    dN: (json['dN'] as num?)?.toDouble(),
    n: json['n'] as num,
    nN: json['nN'] as num?,
    b: (json['b'] as bool?) ?? false,
    bN: json['bN'] as bool?,
    s: (json['s'] as String?) ?? '',
    sN: json['sN'] as String?,
    dt: ej.parseDateTime(json['dt']),
    dtN: ej.parseDateTimeOrNull(json['dtN']),
    u: Uri.parse(json['u'] as String),
    uN: (json['uN'] as String?) != null
        ? Uri.parse(json['uN'] as String)
        : null,
    du: Duration(microseconds: (json['du'] as num).toInt()),
    duN: (json['duN'] as num?) != null
        ? Duration(microseconds: (json['duN'] as num).toInt())
        : null,
    bi: BigInt.parse(json['bi'] as String),
    biN: (json['biN'] as String?) != null
        ? BigInt.parse(json['biN'] as String)
        : null,
    by: base64Decode(json['by'] as String),
    byN: (json['byN'] as String?) != null
        ? base64Decode(json['byN'] as String)
        : null,
    c: Color.values.byName(json['c'] as String),
    cN: (json['cN'] == null ? null : Color.values.byName(json['cN'] as String)),
    o: innerFromJson(json['o'] as Map<String, dynamic>),
    oN: json['oN'] == null
        ? null
        : innerFromJson(json['oN'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> scalarsToJson(Scalars instance) {
  return <String, dynamic>{
    'i': instance.i,
    if (instance.iN != null) 'iN': instance.iN,
    'd': instance.d,
    if (instance.dN != null) 'dN': instance.dN,
    'n': instance.n,
    if (instance.nN != null) 'nN': instance.nN,
    'b': instance.b,
    if (instance.bN != null) 'bN': instance.bN,
    's': instance.s,
    if (instance.sN != null) 'sN': instance.sN,
    'dt': instance.dt.toIso8601String(),
    if (instance.dtN != null) 'dtN': instance.dtN?.toIso8601String(),
    'u': instance.u.toString(),
    if (instance.uN != null) 'uN': instance.uN?.toString(),
    'du': instance.du.inMicroseconds,
    if (instance.duN != null) 'duN': instance.duN?.inMicroseconds,
    'bi': instance.bi.toString(),
    if (instance.biN != null) 'biN': instance.biN?.toString(),
    'by': base64Encode(instance.by),
    if (instance.byN != null)
      'byN': (instance.byN != null ? base64Encode(instance.byN!) : null),
    'c': instance.c.name,
    if (instance.cN != null) 'cN': (instance.cN?.name),
    'o': instance.o.toJson(),
    if (instance.oN != null) 'oN': instance.oN?.toJson(),
  };
}

mixin ScalarsSerializer {
  Map<String, dynamic> toJson() {
    return scalarsToJson(this as Scalars);
  }
}

List<EasyIssue> scalarsValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('i')) {
    issues.add(
      EasyIssue(
        path: 'i',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('i') && json['i'] == null) {
    issues.add(
      EasyIssue(
        path: 'i',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('i')) {
    final v = json['i'];
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(path: 'i', code: 'type_mismatch', message: 'Expected int.'),
        );
      } else {
        final v = _n;
      }
    }
  }
  if (json.containsKey('iN')) {
    final v = json['iN'];
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'iN',
            code: 'type_mismatch',
            message: 'Expected int.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  if (!json.containsKey('d')) {
    issues.add(
      EasyIssue(
        path: 'd',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('d') && json['d'] == null) {
    issues.add(
      EasyIssue(
        path: 'd',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('d')) {
    final v = json['d'];
    if (v != null) {
      final _n = v is num
          ? v.toDouble()
          : (v is String ? double.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'd',
            code: 'type_mismatch',
            message: 'Expected number.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  if (json.containsKey('dN')) {
    final v = json['dN'];
    if (v != null) {
      final _n = v is num
          ? v.toDouble()
          : (v is String ? double.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'dN',
            code: 'type_mismatch',
            message: 'Expected number.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  if (!json.containsKey('n')) {
    issues.add(
      EasyIssue(
        path: 'n',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('n') && json['n'] == null) {
    issues.add(
      EasyIssue(
        path: 'n',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('n')) {
    final v = json['n'];
    if (v != null) {
      final _n = ej.decodeNum(v);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'n',
            code: 'type_mismatch',
            message: 'Expected number.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  if (json.containsKey('nN')) {
    final v = json['nN'];
    if (v != null) {
      final _n = ej.decodeNum(v);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'nN',
            code: 'type_mismatch',
            message: 'Expected number.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  if (!json.containsKey('b')) {
    issues.add(
      EasyIssue(
        path: 'b',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('b') && json['b'] == null) {
    issues.add(
      EasyIssue(
        path: 'b',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('b')) {
    final v = json['b'];
    if (v != null && v is! bool) {
      issues.add(
        EasyIssue(path: 'b', code: 'type_mismatch', message: 'Expected bool.'),
      );
    } else if (v != null) {}
  }
  if (json.containsKey('bN')) {
    final v = json['bN'];
    if (v != null && v is! bool) {
      issues.add(
        EasyIssue(path: 'bN', code: 'type_mismatch', message: 'Expected bool.'),
      );
    } else if (v != null) {}
  }
  if (!json.containsKey('s')) {
    issues.add(
      EasyIssue(
        path: 's',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('s') && json['s'] == null) {
    issues.add(
      EasyIssue(
        path: 's',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('s')) {
    final v = json['s'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 's',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  if (json.containsKey('sN')) {
    final v = json['sN'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'sN',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  if (!json.containsKey('dt')) {
    issues.add(
      EasyIssue(
        path: 'dt',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('dt') && json['dt'] == null) {
    issues.add(
      EasyIssue(
        path: 'dt',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('dt')) {
    final v = json['dt'];
    if (v != null && v is! String && v is! num && v is! DateTime) {
      issues.add(
        EasyIssue(
          path: 'dt',
          code: 'type_mismatch',
          message: 'Expected String (ISO), num or DateTime.',
        ),
      );
    } else if (v is String) {
      if (DateTime.tryParse(v) == null) {
        issues.add(
          EasyIssue(
            path: 'dt',
            code: 'type_mismatch',
            message: 'Invalid ISO format.',
          ),
        );
      } else {
        final dt = DateTime.parse(v);
      }
    }
  }
  if (json.containsKey('dtN')) {
    final v = json['dtN'];
    if (v != null && v is! String && v is! num && v is! DateTime) {
      issues.add(
        EasyIssue(
          path: 'dtN',
          code: 'type_mismatch',
          message: 'Expected String (ISO), num or DateTime.',
        ),
      );
    } else if (v is String) {
      if (DateTime.tryParse(v) == null) {
        issues.add(
          EasyIssue(
            path: 'dtN',
            code: 'type_mismatch',
            message: 'Invalid ISO format.',
          ),
        );
      } else {
        final dt = DateTime.parse(v);
      }
    }
  }
  if (!json.containsKey('u')) {
    issues.add(
      EasyIssue(
        path: 'u',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('u') && json['u'] == null) {
    issues.add(
      EasyIssue(
        path: 'u',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('u')) {
    final v = json['u'];
    if (v is! String) {
      issues.add(
        EasyIssue(
          path: 'u',
          code: 'type_mismatch',
          message: 'Expected String (URI).',
        ),
      );
    } else if (Uri.tryParse(v) == null) {
      issues.add(
        EasyIssue(path: 'u', code: 'invalid_uri', message: 'Invalid URI.'),
      );
    }
  }
  if (json.containsKey('uN')) {
    final v = json['uN'];
    if (v is! String) {
      issues.add(
        EasyIssue(
          path: 'uN',
          code: 'type_mismatch',
          message: 'Expected String (URI).',
        ),
      );
    } else if (Uri.tryParse(v) == null) {
      issues.add(
        EasyIssue(path: 'uN', code: 'invalid_uri', message: 'Invalid URI.'),
      );
    }
  }
  if (!json.containsKey('du')) {
    issues.add(
      EasyIssue(
        path: 'du',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('du') && json['du'] == null) {
    issues.add(
      EasyIssue(
        path: 'du',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('du')) {
    final v = json['du'];
    if (v is! num && !(v is String && int.tryParse(v) != null)) {
      issues.add(
        EasyIssue(
          path: 'du',
          code: 'type_mismatch',
          message: 'Expected number of microseconds.',
        ),
      );
    }
  }
  if (json.containsKey('duN')) {
    final v = json['duN'];
    if (v is! num && !(v is String && int.tryParse(v) != null)) {
      issues.add(
        EasyIssue(
          path: 'duN',
          code: 'type_mismatch',
          message: 'Expected number of microseconds.',
        ),
      );
    }
  }
  if (!json.containsKey('bi')) {
    issues.add(
      EasyIssue(
        path: 'bi',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('bi') && json['bi'] == null) {
    issues.add(
      EasyIssue(
        path: 'bi',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('bi')) {
    final v = json['bi'];
    if (v is String) {
      if (BigInt.tryParse(v) == null) {
        issues.add(
          EasyIssue(
            path: 'bi',
            code: 'invalid_bigint',
            message: 'Invalid integer string.',
          ),
        );
      }
    } else if (v is! num) {
      issues.add(
        EasyIssue(
          path: 'bi',
          code: 'type_mismatch',
          message: 'Expected String (integer) or int.',
        ),
      );
    }
  }
  if (json.containsKey('biN')) {
    final v = json['biN'];
    if (v is String) {
      if (BigInt.tryParse(v) == null) {
        issues.add(
          EasyIssue(
            path: 'biN',
            code: 'invalid_bigint',
            message: 'Invalid integer string.',
          ),
        );
      }
    } else if (v is! num) {
      issues.add(
        EasyIssue(
          path: 'biN',
          code: 'type_mismatch',
          message: 'Expected String (integer) or int.',
        ),
      );
    }
  }
  if (!json.containsKey('by')) {
    issues.add(
      EasyIssue(
        path: 'by',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('by') && json['by'] == null) {
    issues.add(
      EasyIssue(
        path: 'by',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('by')) {
    final v = json['by'];
    if (v is! String) {
      issues.add(
        EasyIssue(
          path: 'by',
          code: 'type_mismatch',
          message: 'Expected String (Base64).',
        ),
      );
    } else {
      try {
        base64Decode(v);
      } catch (_) {
        issues.add(
          EasyIssue(
            path: 'by',
            code: 'invalid_base64',
            message: 'Invalid Base64 string.',
          ),
        );
      }
    }
  }
  if (json.containsKey('byN')) {
    final v = json['byN'];
    if (v is! String) {
      issues.add(
        EasyIssue(
          path: 'byN',
          code: 'type_mismatch',
          message: 'Expected String (Base64).',
        ),
      );
    } else {
      try {
        base64Decode(v);
      } catch (_) {
        issues.add(
          EasyIssue(
            path: 'byN',
            code: 'invalid_base64',
            message: 'Invalid Base64 string.',
          ),
        );
      }
    }
  }
  if (!json.containsKey('c')) {
    issues.add(
      EasyIssue(
        path: 'c',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('c') && json['c'] == null) {
    issues.add(
      EasyIssue(
        path: 'c',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('c')) {
    final v = json['c'];
    if (v is int) {
      if (v < 0 || v >= Color.values.length) {
        issues.add(
          EasyIssue(
            path: 'c',
            code: 'invalid_enum_index',
            message: 'Enum index out of range.',
          ),
        );
      }
    } else if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'c',
          code: 'type_mismatch',
          message: 'Expected String with the enum name.',
        ),
      );
    } else if (v != null) {
      final ok = Color.values.any((e) => e.name == v);
      if (!ok) {
        issues.add(
          EasyIssue(
            path: 'c',
            code: 'invalid_enum',
            message: "Value '$v' does not match Color.",
          ),
        );
      }
    }
  }
  if (json.containsKey('cN')) {
    final v = json['cN'];
    if (v is int) {
      if (v < 0 || v >= Color.values.length) {
        issues.add(
          EasyIssue(
            path: 'cN',
            code: 'invalid_enum_index',
            message: 'Enum index out of range.',
          ),
        );
      }
    } else if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'cN',
          code: 'type_mismatch',
          message: 'Expected String with the enum name.',
        ),
      );
    } else if (v != null) {
      final ok = Color.values.any((e) => e.name == v);
      if (!ok) {
        issues.add(
          EasyIssue(
            path: 'cN',
            code: 'invalid_enum',
            message: "Value '$v' does not match Color.",
          ),
        );
      }
    }
  }
  if (!json.containsKey('o')) {
    issues.add(
      EasyIssue(
        path: 'o',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('o') && json['o'] == null) {
    issues.add(
      EasyIssue(
        path: 'o',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('o')) {
    final v = json['o'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(
          path: 'o',
          code: 'type_mismatch',
          message: 'Expected Map for Inner.',
        ),
      );
    } else if (v is Map) {
      final child = innerValidate(Map<String, dynamic>.from(v));
      for (final ci in child) {
        issues.add(
          EasyIssue(
            path: 'o' + '.' + ci.path,
            code: ci.code,
            message: ci.message,
          ),
        );
      }
    }
  }
  if (json.containsKey('oN')) {
    final v = json['oN'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(
          path: 'oN',
          code: 'type_mismatch',
          message: 'Expected Map for Inner.',
        ),
      );
    } else if (v is Map) {
      final child = innerValidate(Map<String, dynamic>.from(v));
      for (final ci in child) {
        issues.add(
          EasyIssue(
            path: 'oN' + '.' + ci.path,
            code: ci.code,
            message: ci.message,
          ),
        );
      }
    }
  }
  return issues;
}

Scalars scalarsFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in scalarsValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Scalars(
    i: (() {
      final v = json['i'];
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return p;
      }
      return 0;
    })(),
    iN: (() {
      final v = json['iN'];
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return p;
      }
      return null;
    })(),
    d: (() {
      final v = json['d'];
      if (v is num) return v.toDouble();
      if (v is String) {
        final p = double.tryParse(v);
        if (p != null) return p;
      }
      return 0.0;
    })(),
    dN: (() {
      final v = json['dN'];
      if (v is num) return v.toDouble();
      if (v is String) {
        final p = double.tryParse(v);
        if (p != null) return p;
      }
      return null;
    })(),
    n: (() {
      final v = ej.decodeNum(json['n']);
      return v ?? 0;
    })(),
    nN: (() {
      final v = ej.decodeNum(json['nN']);
      return v ?? null;
    })(),
    b: (() {
      final v = json['b'];
      return (v is bool) ? v : false;
    })(),
    bN: (() {
      final v = json['bN'];
      return (v is bool) ? v : null;
    })(),
    s: (() {
      final v = json['s'];
      return (v is String) ? v : '';
    })(),
    sN: (() {
      final v = json['sN'];
      return (v is String) ? v : null;
    })(),
    dt: (() {
      final v = json['dt'];
      if (v == null) return DateTime.fromMillisecondsSinceEpoch(0);
      if (v is DateTime) return v;
      if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
      if (v is num) return DateTime.fromMillisecondsSinceEpoch(v.toInt());
      if (v is String) {
        try {
          return DateTime.parse(v);
        } catch (_) {
          onIssue?.call(
            EasyIssue(
              path: 'dt',
              code: 'type_mismatch',
              message: 'Invalid DateTime format.',
            ),
          );
          return DateTime.fromMillisecondsSinceEpoch(0);
        }
      }
      onIssue?.call(
        EasyIssue(
          path: 'dt',
          code: 'type_mismatch',
          message: 'Expected String/epoch/DateTime.',
        ),
      );
      return DateTime.fromMillisecondsSinceEpoch(0);
    })(),
    dtN: (() {
      final v = json['dtN'];
      if (v == null) return null;
      if (v is DateTime) return v;
      if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
      if (v is num) return DateTime.fromMillisecondsSinceEpoch(v.toInt());
      if (v is String) {
        try {
          return DateTime.parse(v);
        } catch (_) {
          onIssue?.call(
            EasyIssue(
              path: 'dtN',
              code: 'type_mismatch',
              message: 'Invalid DateTime format.',
            ),
          );
          return null;
        }
      }
      onIssue?.call(
        EasyIssue(
          path: 'dtN',
          code: 'type_mismatch',
          message: 'Expected String/epoch/DateTime.',
        ),
      );
      return null;
    })(),
    u: (() {
      final v = json['u'];
      if (v == null) return Uri();
      if (v is String) {
        final u = Uri.tryParse(v);
        if (u != null) return u;
        onIssue?.call(
          EasyIssue(path: 'u', code: 'invalid_uri', message: 'Invalid URI.'),
        );
        return Uri();
      }
      onIssue?.call(
        EasyIssue(
          path: 'u',
          code: 'type_mismatch',
          message: 'Expected String (URI).',
        ),
      );
      return Uri();
    })(),
    uN: (() {
      final v = json['uN'];
      if (v == null) return null;
      if (v is String) {
        final u = Uri.tryParse(v);
        if (u != null) return u;
        onIssue?.call(
          EasyIssue(path: 'uN', code: 'invalid_uri', message: 'Invalid URI.'),
        );
        return null;
      }
      onIssue?.call(
        EasyIssue(
          path: 'uN',
          code: 'type_mismatch',
          message: 'Expected String (URI).',
        ),
      );
      return null;
    })(),
    du: (() {
      final v = json['du'];
      if (v == null) return Duration.zero;
      if (v is num) return Duration(microseconds: v.toInt());
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return Duration(microseconds: p);
      }
      onIssue?.call(
        EasyIssue(
          path: 'du',
          code: 'type_mismatch',
          message: 'Expected number of microseconds.',
        ),
      );
      return Duration.zero;
    })(),
    duN: (() {
      final v = json['duN'];
      if (v == null) return null;
      if (v is num) return Duration(microseconds: v.toInt());
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return Duration(microseconds: p);
      }
      onIssue?.call(
        EasyIssue(
          path: 'duN',
          code: 'type_mismatch',
          message: 'Expected number of microseconds.',
        ),
      );
      return null;
    })(),
    bi: (() {
      final v = json['bi'];
      if (v == null) return BigInt.zero;
      if (v is String) {
        final b = BigInt.tryParse(v);
        if (b != null) return b;
        onIssue?.call(
          EasyIssue(
            path: 'bi',
            code: 'invalid_bigint',
            message: 'Invalid integer string.',
          ),
        );
        return BigInt.zero;
      }
      if (v is int) return BigInt.from(v);
      if (v is num) return BigInt.from(v.toInt());
      onIssue?.call(
        EasyIssue(
          path: 'bi',
          code: 'type_mismatch',
          message: 'Expected String (integer) or int.',
        ),
      );
      return BigInt.zero;
    })(),
    biN: (() {
      final v = json['biN'];
      if (v == null) return null;
      if (v is String) {
        final b = BigInt.tryParse(v);
        if (b != null) return b;
        onIssue?.call(
          EasyIssue(
            path: 'biN',
            code: 'invalid_bigint',
            message: 'Invalid integer string.',
          ),
        );
        return null;
      }
      if (v is int) return BigInt.from(v);
      if (v is num) return BigInt.from(v.toInt());
      onIssue?.call(
        EasyIssue(
          path: 'biN',
          code: 'type_mismatch',
          message: 'Expected String (integer) or int.',
        ),
      );
      return null;
    })(),
    by: (() {
      final v = json['by'];
      if (v == null) return Uint8List(0);
      if (v is String) {
        try {
          return base64Decode(v);
        } catch (_) {
          onIssue?.call(
            EasyIssue(
              path: 'by',
              code: 'invalid_base64',
              message: 'Invalid Base64 string.',
            ),
          );
          return Uint8List(0);
        }
      }
      onIssue?.call(
        EasyIssue(
          path: 'by',
          code: 'type_mismatch',
          message: 'Expected String (Base64).',
        ),
      );
      return Uint8List(0);
    })(),
    byN: (() {
      final v = json['byN'];
      if (v == null) return null;
      if (v is String) {
        try {
          return base64Decode(v);
        } catch (_) {
          onIssue?.call(
            EasyIssue(
              path: 'byN',
              code: 'invalid_base64',
              message: 'Invalid Base64 string.',
            ),
          );
          return null;
        }
      }
      onIssue?.call(
        EasyIssue(
          path: 'byN',
          code: 'type_mismatch',
          message: 'Expected String (Base64).',
        ),
      );
      return null;
    })(),
    c: (() {
      final v = json['c'];
      if (v == null) return Color.values.first;

      // String pelo .name (tolerante a espaços/case)
      if (v is String) {
        final s = v.trim();
        for (final e in Color.values) {
          if (e.name == s || e.name.toLowerCase() == s.toLowerCase()) return e;
        }
        onIssue?.call(
          EasyIssue(
            path: 'c',
            code: 'invalid_enum',
            message: "Value '$v' does not match Color.",
          ),
        );
        return Color.values.first;
      }

      // Índice numérico
      if (v is int) {
        if (v >= 0 && v < Color.values.length) return Color.values[v];
        onIssue?.call(
          EasyIssue(
            path: 'c',
            code: 'invalid_enum_index',
            message: 'Enum index out of range.',
          ),
        );
        return Color.values.first;
      }

      onIssue?.call(
        EasyIssue(
          path: 'c',
          code: 'type_mismatch',
          message: 'Expected String with enum name or int index.',
        ),
      );
      return Color.values.first;
    })(),
    cN: (() {
      final v = json['cN'];
      if (v == null) return null;

      // String pelo .name (tolerante a espaços/case)
      if (v is String) {
        final s = v.trim();
        for (final e in Color.values) {
          if (e.name == s || e.name.toLowerCase() == s.toLowerCase()) return e;
        }
        onIssue?.call(
          EasyIssue(
            path: 'cN',
            code: 'invalid_enum',
            message: "Value '$v' does not match Color.",
          ),
        );
        return Color.values.first;
      }

      // Índice numérico
      if (v is int) {
        if (v >= 0 && v < Color.values.length) return Color.values[v];
        onIssue?.call(
          EasyIssue(
            path: 'cN',
            code: 'invalid_enum_index',
            message: 'Enum index out of range.',
          ),
        );
        return Color.values.first;
      }

      onIssue?.call(
        EasyIssue(
          path: 'cN',
          code: 'type_mismatch',
          message: 'Expected String with enum name or int index.',
        ),
      );
      return null;
    })(),
    o: (() {
      final _v = json['o'];
      if (_v == null)
        return innerFromJsonSafe(
          const <String, dynamic>{},
          onIssue: (i) => onIssue?.call(
            EasyIssue(
              path: 'o' + '.' + i.path,
              code: i.code,
              message: i.message,
            ),
          ),
          runValidate: false,
        );
      if (_v is Map) {
        return innerFromJsonSafe(
          Map<String, dynamic>.from(_v as Map),
          onIssue: (i) => onIssue?.call(
            EasyIssue(
              path: 'o' + '.' + i.path,
              code: i.code,
              message: i.message,
            ),
          ),
          runValidate: false,
        );
      }
      return innerFromJsonSafe(
        const <String, dynamic>{},
        onIssue: (i) => onIssue?.call(
          EasyIssue(path: 'o' + '.' + i.path, code: i.code, message: i.message),
        ),
        runValidate: false,
      );
    })(),
    oN: (() {
      final _v = json['oN'];
      if (_v == null) return null;
      if (_v is Map) {
        return innerFromJsonSafe(
          Map<String, dynamic>.from(_v as Map),
          onIssue: (i) => onIssue?.call(
            EasyIssue(
              path: 'oN' + '.' + i.path,
              code: i.code,
              message: i.message,
            ),
          ),
          runValidate: false,
        );
      }
      return null;
    })(),
  ))(_report);
}

class ScalarsJson {
  const ScalarsJson();

  static Scalars fromJson(Map<String, dynamic> json) {
    return scalarsFromJson(json);
  }

  static Scalars fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return scalarsFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return scalarsValidate(json);
  }
}

List<Scalars> scalarsFromJsonList(List<dynamic> json) =>
    json.map((e) => scalarsFromJson(e as Map<String, dynamic>)).toList();

List<Scalars> scalarsFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => scalarsFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> scalarsToJsonList(List<Scalars> items) =>
    items.map((e) => scalarsToJson(e)).toList();

Lists listsFromJson(Map<String, dynamic> json) {
  return Lists(
    i:
        ((json['i'] as List?)?.asMap().entries.map<int>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (e as int?) ?? 0;
        }).toList()) ??
        const <int>[],
    d:
        ((json['d'] as List?)?.asMap().entries.map<double>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (e as num?)?.toDouble() ?? 0.0;
        }).toList()) ??
        const <double>[],
    n:
        ((json['n'] as List?)?.asMap().entries.map<num>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (ej.decodeNum(e) ??
              (throw FormatException('Invalid num value.')));
        }).toList()) ??
        const <num>[],
    b:
        ((json['b'] as List?)?.asMap().entries.map<bool>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (e as bool?) ?? false;
        }).toList()) ??
        const <bool>[],
    s:
        ((json['s'] as List?)?.asMap().entries.map<String>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (e as String?) ?? '';
        }).toList()) ??
        const <String>[],
    dt:
        ((json['dt'] as List?)?.asMap().entries.map<DateTime>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (ej.decodeDateTime(e) ??
              (throw FormatException('Invalid DateTime value.')));
        }).toList()) ??
        const <DateTime>[],
    u:
        ((json['u'] as List?)?.asMap().entries.map<Uri>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (ej.decodeUri(e) ??
              (throw FormatException('Invalid Uri value.')));
        }).toList()) ??
        const <Uri>[],
    du:
        ((json['du'] as List?)?.asMap().entries.map<Duration>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (ej.decodeDuration(e) ??
              (throw FormatException('Invalid Duration value.')));
        }).toList()) ??
        const <Duration>[],
    bi:
        ((json['bi'] as List?)?.asMap().entries.map<BigInt>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (ej.decodeBigInt(e) ??
              (throw FormatException('Invalid BigInt value.')));
        }).toList()) ??
        const <BigInt>[],
    by:
        ((json['by'] as List?)?.asMap().entries.map<Uint8List>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (ej.decodeBytes(e) ??
              (throw FormatException('Invalid Uint8List value.')));
        }).toList()) ??
        const <Uint8List>[],
    c:
        ((json['c'] as List?)?.asMap().entries.map<Color>((entry) {
          final i = entry.key;
          final e = entry.value;
          return Color.values.byName(e as String);
        }).toList()) ??
        const <Color>[],
    o:
        ((json['o'] as List?)?.asMap().entries.map<Inner>((entry) {
          final i = entry.key;
          final e = entry.value;
          return innerFromJson(Map<String, dynamic>.from(e as Map));
        }).toList()) ??
        const <Inner>[],
    iN:
        ((json['iN'] as List?)?.asMap().entries.map<int?>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (e as int?);
        }).toList()) ??
        const <int?>[],
    nullableList: (json['nullableList'] as List?)?.asMap().entries.map<int>((
      entry,
    ) {
      final i = entry.key;
      final e = entry.value;
      return (e as int?) ?? 0;
    }).toList(),
  );
}

Map<String, dynamic> listsToJson(Lists instance) {
  return <String, dynamic>{
    'i': instance.i,
    'd': instance.d,
    'n': instance.n.map((e) => e).toList(),
    'b': instance.b,
    's': instance.s,
    'dt': instance.dt.map((e) => e.toIso8601String()).toList(),
    'u': instance.u.map((e) => e.toString()).toList(),
    'du': instance.du.map((e) => e.inMicroseconds).toList(),
    'bi': instance.bi.map((e) => e.toString()).toList(),
    'by': instance.by.map((e) => base64Encode(e)).toList(),
    'c': instance.c.map((e) => e.name).toList(),
    'o': instance.o.map((e) => e.toJson()).toList(),
    'iN': instance.iN,
    if (instance.nullableList != null) 'nullableList': instance.nullableList,
  };
}

mixin ListsSerializer {
  Map<String, dynamic> toJson() {
    return listsToJson(this as Lists);
  }
}

List<EasyIssue> listsValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('i')) {
    issues.add(
      EasyIssue(
        path: 'i',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('i') && json['i'] == null) {
    issues.add(
      EasyIssue(
        path: 'i',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('i')) {
    final v = json['i'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(path: 'i', code: 'type_mismatch', message: 'Expected List.'),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'i' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! int) {
            issues.add(
              EasyIssue(
                path: 'i' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected int.',
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('d')) {
    issues.add(
      EasyIssue(
        path: 'd',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('d') && json['d'] == null) {
    issues.add(
      EasyIssue(
        path: 'd',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('d')) {
    final v = json['d'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(path: 'd', code: 'type_mismatch', message: 'Expected List.'),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'd' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! num) {
            issues.add(
              EasyIssue(
                path: 'd' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected double.',
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('n')) {
    issues.add(
      EasyIssue(
        path: 'n',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('n') && json['n'] == null) {
    issues.add(
      EasyIssue(
        path: 'n',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('n')) {
    final v = json['n'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(path: 'n', code: 'type_mismatch', message: 'Expected List.'),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'n' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (ej.decodeNum(e) == null) {
            issues.add(
              EasyIssue(
                path: 'n' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected number.',
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('b')) {
    issues.add(
      EasyIssue(
        path: 'b',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('b') && json['b'] == null) {
    issues.add(
      EasyIssue(
        path: 'b',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('b')) {
    final v = json['b'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(path: 'b', code: 'type_mismatch', message: 'Expected List.'),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'b' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! bool) {
            issues.add(
              EasyIssue(
                path: 'b' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected bool.',
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('s')) {
    issues.add(
      EasyIssue(
        path: 's',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('s') && json['s'] == null) {
    issues.add(
      EasyIssue(
        path: 's',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('s')) {
    final v = json['s'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(path: 's', code: 'type_mismatch', message: 'Expected List.'),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 's' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! String) {
            issues.add(
              EasyIssue(
                path: 's' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected String.',
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('dt')) {
    issues.add(
      EasyIssue(
        path: 'dt',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('dt') && json['dt'] == null) {
    issues.add(
      EasyIssue(
        path: 'dt',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('dt')) {
    final v = json['dt'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(path: 'dt', code: 'type_mismatch', message: 'Expected List.'),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'dt' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (ej.decodeDateTime(e) == null) {
            issues.add(
              EasyIssue(
                path: 'dt' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected ISO-8601 String or epoch milliseconds.',
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('u')) {
    issues.add(
      EasyIssue(
        path: 'u',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('u') && json['u'] == null) {
    issues.add(
      EasyIssue(
        path: 'u',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('u')) {
    final v = json['u'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(path: 'u', code: 'type_mismatch', message: 'Expected List.'),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'u' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (ej.decodeUri(e) == null) {
            issues.add(
              (e is String
                  ? EasyIssue(
                      path: 'u' + '[' + i.toString() + ']',
                      code: 'invalid_uri',
                      message: 'Invalid URI.',
                    )
                  : EasyIssue(
                      path: 'u' + '[' + i.toString() + ']',
                      code: 'type_mismatch',
                      message: 'Expected String (URI).',
                    )),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('du')) {
    issues.add(
      EasyIssue(
        path: 'du',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('du') && json['du'] == null) {
    issues.add(
      EasyIssue(
        path: 'du',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('du')) {
    final v = json['du'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(path: 'du', code: 'type_mismatch', message: 'Expected List.'),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'du' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (ej.decodeDuration(e) == null) {
            issues.add(
              EasyIssue(
                path: 'du' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected number of microseconds.',
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('bi')) {
    issues.add(
      EasyIssue(
        path: 'bi',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('bi') && json['bi'] == null) {
    issues.add(
      EasyIssue(
        path: 'bi',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('bi')) {
    final v = json['bi'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(path: 'bi', code: 'type_mismatch', message: 'Expected List.'),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'bi' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (ej.decodeBigInt(e) == null) {
            issues.add(
              (e is String
                  ? EasyIssue(
                      path: 'bi' + '[' + i.toString() + ']',
                      code: 'invalid_bigint',
                      message: 'Invalid integer string.',
                    )
                  : EasyIssue(
                      path: 'bi' + '[' + i.toString() + ']',
                      code: 'type_mismatch',
                      message: 'Expected String (integer) or int.',
                    )),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('by')) {
    issues.add(
      EasyIssue(
        path: 'by',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('by') && json['by'] == null) {
    issues.add(
      EasyIssue(
        path: 'by',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('by')) {
    final v = json['by'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(path: 'by', code: 'type_mismatch', message: 'Expected List.'),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'by' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (ej.decodeBytes(e) == null) {
            issues.add(
              (e is String
                  ? EasyIssue(
                      path: 'by' + '[' + i.toString() + ']',
                      code: 'invalid_base64',
                      message: 'Invalid Base64 string.',
                    )
                  : EasyIssue(
                      path: 'by' + '[' + i.toString() + ']',
                      code: 'type_mismatch',
                      message: 'Expected String (Base64).',
                    )),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('c')) {
    issues.add(
      EasyIssue(
        path: 'c',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('c') && json['c'] == null) {
    issues.add(
      EasyIssue(
        path: 'c',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('c')) {
    final v = json['c'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(path: 'c', code: 'type_mismatch', message: 'Expected List.'),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'c' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! String) {
            issues.add(
              EasyIssue(
                path: 'c' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected String with enum name.',
              ),
            );
          } else {
            final ok = Color.values.any((x) => x.name == e);
            if (!ok) {
              issues.add(
                EasyIssue(
                  path: 'c' + '[' + i.toString() + ']',
                  code: 'invalid_enum',
                  message: "Value '$e' does not match Color.",
                ),
              );
            }
          }
        }
      }
    }
  }
  if (!json.containsKey('o')) {
    issues.add(
      EasyIssue(
        path: 'o',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('o') && json['o'] == null) {
    issues.add(
      EasyIssue(
        path: 'o',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('o')) {
    final v = json['o'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(path: 'o', code: 'type_mismatch', message: 'Expected List.'),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'o' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! Map) {
            issues.add(
              EasyIssue(
                path: 'o' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected Map for Inner.',
              ),
            );
          } else {
            final child = innerValidate(Map<String, dynamic>.from(e as Map));
            for (final ci in child) {
              issues.add(
                EasyIssue(
                  path: 'o' + '[' + i.toString() + '].' + ci.path,
                  code: ci.code,
                  message: ci.message,
                ),
              );
            }
          }
        }
      }
    }
  }
  if (!json.containsKey('iN')) {
    issues.add(
      EasyIssue(
        path: 'iN',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('iN') && json['iN'] == null) {
    issues.add(
      EasyIssue(
        path: 'iN',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('iN')) {
    final v = json['iN'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(path: 'iN', code: 'type_mismatch', message: 'Expected List.'),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
        } else {
          if (e is! int) {
            issues.add(
              EasyIssue(
                path: 'iN' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected int.',
              ),
            );
          }
        }
      }
    }
  }
  if (json.containsKey('nullableList')) {
    final v = json['nullableList'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'nullableList',
          code: 'type_mismatch',
          message: 'Expected List.',
        ),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'nullableList' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! int) {
            issues.add(
              EasyIssue(
                path: 'nullableList' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected int.',
              ),
            );
          }
        }
      }
    }
  }
  return issues;
}

Lists listsFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in listsValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Lists(
    i: (() {
      final _v = json['i'];
      if (_v is! List) return const <int>[];
      final _list = _v;
      return _list.asMap().entries.map<int>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'i' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return 0;
          }
          if (v is int) return v;
          onIssue?.call(
            EasyIssue(
              path: 'i' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Expected int.',
            ),
          );
          return 0;
        })();
      }).toList();
    })(),
    d: (() {
      final _v = json['d'];
      if (_v is! List) return const <double>[];
      final _list = _v;
      return _list.asMap().entries.map<double>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'd' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return 0.0;
          }
          if (v is num) return v.toDouble();
          onIssue?.call(
            EasyIssue(
              path: 'd' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Expected number (int/double).',
            ),
          );
          return 0.0;
        })();
      }).toList();
    })(),
    n: (() {
      final _v = json['n'];
      if (_v is! List) return const <num>[];
      final _list = _v;
      return _list.asMap().entries.map<num>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'n' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return 0;
          }
          final r = ej.decodeNum(v);
          if (r != null) return r;
          onIssue?.call(
            EasyIssue(
              path: 'n' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Expected number.',
            ),
          );
          return 0;
        })();
      }).toList();
    })(),
    b: (() {
      final _v = json['b'];
      if (_v is! List) return const <bool>[];
      final _list = _v;
      return _list.asMap().entries.map<bool>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'b' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return false;
          }
          if (v is bool) return v;
          onIssue?.call(
            EasyIssue(
              path: 'b' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Expected bool.',
            ),
          );
          return false;
        })();
      }).toList();
    })(),
    s: (() {
      final _v = json['s'];
      if (_v is! List) return const <String>[];
      final _list = _v;
      return _list.asMap().entries.map<String>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 's' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return '';
          }
          if (v is String) return v;
          onIssue?.call(
            EasyIssue(
              path: 's' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Expected String.',
            ),
          );
          return '';
        })();
      }).toList();
    })(),
    dt: (() {
      final _v = json['dt'];
      if (_v is! List) return const <DateTime>[];
      final _list = _v;
      return _list.asMap().entries.map<DateTime>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'dt' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return DateTime.fromMillisecondsSinceEpoch(0);
          }
          final r = ej.decodeDateTime(v);
          if (r != null) return r;
          onIssue?.call(
            EasyIssue(
              path: 'dt' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Expected ISO-8601 String or epoch milliseconds.',
            ),
          );
          return DateTime.fromMillisecondsSinceEpoch(0);
        })();
      }).toList();
    })(),
    u: (() {
      final _v = json['u'];
      if (_v is! List) return const <Uri>[];
      final _list = _v;
      return _list.asMap().entries.map<Uri>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'u' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return Uri();
          }
          final r = ej.decodeUri(v);
          if (r != null) return r;
          onIssue?.call(
            (v is String
                ? EasyIssue(
                    path: 'u' + '[' + entry.key.toString() + ']',
                    code: 'invalid_uri',
                    message: 'Invalid URI.',
                  )
                : EasyIssue(
                    path: 'u' + '[' + entry.key.toString() + ']',
                    code: 'type_mismatch',
                    message: 'Expected String (URI).',
                  )),
          );
          return Uri();
        })();
      }).toList();
    })(),
    du: (() {
      final _v = json['du'];
      if (_v is! List) return const <Duration>[];
      final _list = _v;
      return _list.asMap().entries.map<Duration>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'du' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return Duration.zero;
          }
          final r = ej.decodeDuration(v);
          if (r != null) return r;
          onIssue?.call(
            EasyIssue(
              path: 'du' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Expected number of microseconds.',
            ),
          );
          return Duration.zero;
        })();
      }).toList();
    })(),
    bi: (() {
      final _v = json['bi'];
      if (_v is! List) return const <BigInt>[];
      final _list = _v;
      return _list.asMap().entries.map<BigInt>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'bi' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return BigInt.zero;
          }
          final r = ej.decodeBigInt(v);
          if (r != null) return r;
          onIssue?.call(
            (v is String
                ? EasyIssue(
                    path: 'bi' + '[' + entry.key.toString() + ']',
                    code: 'invalid_bigint',
                    message: 'Invalid integer string.',
                  )
                : EasyIssue(
                    path: 'bi' + '[' + entry.key.toString() + ']',
                    code: 'type_mismatch',
                    message: 'Expected String (integer) or int.',
                  )),
          );
          return BigInt.zero;
        })();
      }).toList();
    })(),
    by: (() {
      final _v = json['by'];
      if (_v is! List) return const <Uint8List>[];
      final _list = _v;
      return _list.asMap().entries.map<Uint8List>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'by' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return Uint8List(0);
          }
          final r = ej.decodeBytes(v);
          if (r != null) return r;
          onIssue?.call(
            (v is String
                ? EasyIssue(
                    path: 'by' + '[' + entry.key.toString() + ']',
                    code: 'invalid_base64',
                    message: 'Invalid Base64 string.',
                  )
                : EasyIssue(
                    path: 'by' + '[' + entry.key.toString() + ']',
                    code: 'type_mismatch',
                    message: 'Expected String (Base64).',
                  )),
          );
          return Uint8List(0);
        })();
      }).toList();
    })(),
    c: (() {
      final _v = json['c'];
      if (_v is! List) return const <Color>[];
      final _list = _v;
      return _list.asMap().entries.map<Color>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final v = entry.value;
          if (v == null) return Color.values.first;
          if (v is String) {
            for (final e in Color.values) {
              if (e.name == v) return e;
            }
            onIssue?.call(
              EasyIssue(
                path: 'c' + '[' + entry.key.toString() + ']',
                code: 'invalid_enum',
                message: "Value '$v' does not match Color.",
              ),
            );
            return Color.values.first;
          }
          onIssue?.call(
            EasyIssue(
              path: 'c' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Expected String with enum name.',
            ),
          );
          return Color.values.first;
        })();
      }).toList();
    })(),
    o: (() {
      final _v = json['o'];
      if (_v is! List) return const <Inner>[];
      final _list = _v;
      return _list.asMap().entries.map<Inner>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final _v = entry.value;
          if (_v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'o' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return innerFromJsonSafe(
              const <String, dynamic>{},
              onIssue: (i) => onIssue?.call(
                EasyIssue(
                  path: 'o' + '[' + entry.key.toString() + ']' + '.' + i.path,
                  code: i.code,
                  message: i.message,
                ),
              ),
              runValidate: false,
            );
          }
          if (_v is Map) {
            return innerFromJsonSafe(
              Map<String, dynamic>.from(_v as Map),
              onIssue: (i) => onIssue?.call(
                EasyIssue(
                  path: 'o' + '[' + entry.key.toString() + ']' + '.' + i.path,
                  code: i.code,
                  message: i.message,
                ),
              ),
              runValidate: false,
            );
          }
          onIssue?.call(
            EasyIssue(
              path: 'o' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Expected Map for Inner.',
            ),
          );
          return innerFromJsonSafe(
            const <String, dynamic>{},
            onIssue: (i) => onIssue?.call(
              EasyIssue(
                path: "'o' + '[' + entry.key.toString() + ']'." + i.path,
                code: i.code,
                message: i.message,
              ),
            ),
            runValidate: false,
          );
        })();
      }).toList();
    })(),
    iN: (() {
      final _v = json['iN'];
      if (_v is! List) return const <int?>[];
      final _list = _v;
      return _list.asMap().entries.map<int?>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final v = entry.value;
          if (v == null) {
            return null;
          }
          if (v is int) return v;
          onIssue?.call(
            EasyIssue(
              path: 'iN' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Expected int.',
            ),
          );
          return null;
        })();
      }).toList();
    })(),
    nullableList: (() {
      final _v = json['nullableList'];
      if (_v is! List) return null;
      final _list = _v;
      return _list.asMap().entries.map<int>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'nullableList' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return 0;
          }
          if (v is int) return v;
          onIssue?.call(
            EasyIssue(
              path: 'nullableList' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Expected int.',
            ),
          );
          return 0;
        })();
      }).toList();
    })(),
  ))(_report);
}

class ListsJson {
  const ListsJson();

  static Lists fromJson(Map<String, dynamic> json) {
    return listsFromJson(json);
  }

  static Lists fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return listsFromJsonSafe(json, onIssue: onIssue, runValidate: runValidate);
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return listsValidate(json);
  }
}

List<Lists> listsFromJsonList(List<dynamic> json) =>
    json.map((e) => listsFromJson(e as Map<String, dynamic>)).toList();

List<Lists> listsFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => listsFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> listsToJsonList(List<Lists> items) =>
    items.map((e) => listsToJson(e)).toList();

Sets setsFromJson(Map<String, dynamic> json) {
  return Sets(
    i:
        ((json['i'] as List?)?.asMap().entries.map<int>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (e as int?) ?? 0;
        }).toSet()) ??
        const <int>{},
    d:
        ((json['d'] as List?)?.asMap().entries.map<double>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (e as num?)?.toDouble() ?? 0.0;
        }).toSet()) ??
        const <double>{},
    s:
        ((json['s'] as List?)?.asMap().entries.map<String>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (e as String?) ?? '';
        }).toSet()) ??
        const <String>{},
    dt:
        ((json['dt'] as List?)?.asMap().entries.map<DateTime>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (ej.decodeDateTime(e) ??
              (throw FormatException('Invalid DateTime value.')));
        }).toSet()) ??
        const <DateTime>{},
    u:
        ((json['u'] as List?)?.asMap().entries.map<Uri>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (ej.decodeUri(e) ??
              (throw FormatException('Invalid Uri value.')));
        }).toSet()) ??
        const <Uri>{},
    du:
        ((json['du'] as List?)?.asMap().entries.map<Duration>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (ej.decodeDuration(e) ??
              (throw FormatException('Invalid Duration value.')));
        }).toSet()) ??
        const <Duration>{},
    bi:
        ((json['bi'] as List?)?.asMap().entries.map<BigInt>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (ej.decodeBigInt(e) ??
              (throw FormatException('Invalid BigInt value.')));
        }).toSet()) ??
        const <BigInt>{},
    c:
        ((json['c'] as List?)?.asMap().entries.map<Color>((entry) {
          final i = entry.key;
          final e = entry.value;
          return Color.values.byName(e as String);
        }).toSet()) ??
        const <Color>{},
  );
}

Map<String, dynamic> setsToJson(Sets instance) {
  return <String, dynamic>{
    'i': instance.i.toList(),
    'd': instance.d.toList(),
    's': instance.s.toList(),
    'dt': instance.dt.map((e) => e.toIso8601String()).toList(),
    'u': instance.u.map((e) => e.toString()).toList(),
    'du': instance.du.map((e) => e.inMicroseconds).toList(),
    'bi': instance.bi.map((e) => e.toString()).toList(),
    'c': instance.c.map((e) => e.name).toList(),
  };
}

mixin SetsSerializer {
  Map<String, dynamic> toJson() {
    return setsToJson(this as Sets);
  }
}

List<EasyIssue> setsValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('i')) {
    issues.add(
      EasyIssue(
        path: 'i',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('i') && json['i'] == null) {
    issues.add(
      EasyIssue(
        path: 'i',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('i')) {
    final v = json['i'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'i',
          code: 'type_mismatch',
          message: 'Expected List for Set.',
        ),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'i' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! int) {
            issues.add(
              EasyIssue(
                path: 'i' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected int.',
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('d')) {
    issues.add(
      EasyIssue(
        path: 'd',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('d') && json['d'] == null) {
    issues.add(
      EasyIssue(
        path: 'd',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('d')) {
    final v = json['d'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'd',
          code: 'type_mismatch',
          message: 'Expected List for Set.',
        ),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'd' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! num) {
            issues.add(
              EasyIssue(
                path: 'd' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected double.',
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('s')) {
    issues.add(
      EasyIssue(
        path: 's',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('s') && json['s'] == null) {
    issues.add(
      EasyIssue(
        path: 's',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('s')) {
    final v = json['s'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 's',
          code: 'type_mismatch',
          message: 'Expected List for Set.',
        ),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 's' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! String) {
            issues.add(
              EasyIssue(
                path: 's' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected String.',
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('dt')) {
    issues.add(
      EasyIssue(
        path: 'dt',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('dt') && json['dt'] == null) {
    issues.add(
      EasyIssue(
        path: 'dt',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('dt')) {
    final v = json['dt'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'dt',
          code: 'type_mismatch',
          message: 'Expected List for Set.',
        ),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'dt' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (ej.decodeDateTime(e) == null) {
            issues.add(
              EasyIssue(
                path: 'dt' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected ISO-8601 String or epoch milliseconds.',
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('u')) {
    issues.add(
      EasyIssue(
        path: 'u',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('u') && json['u'] == null) {
    issues.add(
      EasyIssue(
        path: 'u',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('u')) {
    final v = json['u'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'u',
          code: 'type_mismatch',
          message: 'Expected List for Set.',
        ),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'u' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (ej.decodeUri(e) == null) {
            issues.add(
              (e is String
                  ? EasyIssue(
                      path: 'u' + '[' + i.toString() + ']',
                      code: 'invalid_uri',
                      message: 'Invalid URI.',
                    )
                  : EasyIssue(
                      path: 'u' + '[' + i.toString() + ']',
                      code: 'type_mismatch',
                      message: 'Expected String (URI).',
                    )),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('du')) {
    issues.add(
      EasyIssue(
        path: 'du',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('du') && json['du'] == null) {
    issues.add(
      EasyIssue(
        path: 'du',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('du')) {
    final v = json['du'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'du',
          code: 'type_mismatch',
          message: 'Expected List for Set.',
        ),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'du' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (ej.decodeDuration(e) == null) {
            issues.add(
              EasyIssue(
                path: 'du' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected number of microseconds.',
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('bi')) {
    issues.add(
      EasyIssue(
        path: 'bi',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('bi') && json['bi'] == null) {
    issues.add(
      EasyIssue(
        path: 'bi',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('bi')) {
    final v = json['bi'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'bi',
          code: 'type_mismatch',
          message: 'Expected List for Set.',
        ),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'bi' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (ej.decodeBigInt(e) == null) {
            issues.add(
              (e is String
                  ? EasyIssue(
                      path: 'bi' + '[' + i.toString() + ']',
                      code: 'invalid_bigint',
                      message: 'Invalid integer string.',
                    )
                  : EasyIssue(
                      path: 'bi' + '[' + i.toString() + ']',
                      code: 'type_mismatch',
                      message: 'Expected String (integer) or int.',
                    )),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('c')) {
    issues.add(
      EasyIssue(
        path: 'c',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('c') && json['c'] == null) {
    issues.add(
      EasyIssue(
        path: 'c',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('c')) {
    final v = json['c'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'c',
          code: 'type_mismatch',
          message: 'Expected List for Set.',
        ),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'c' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! String) {
            issues.add(
              EasyIssue(
                path: 'c' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected String with enum name.',
              ),
            );
          } else {
            final ok = Color.values.any((x) => x.name == e);
            if (!ok) {
              issues.add(
                EasyIssue(
                  path: 'c' + '[' + i.toString() + ']',
                  code: 'invalid_enum',
                  message: "Value '$e' does not match Color.",
                ),
              );
            }
          }
        }
      }
    }
  }
  return issues;
}

Sets setsFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in setsValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Sets(
    i: (() {
      final _v = json['i'];
      if (_v is! List) return const <int>{};
      final _list = _v;
      return _list
          .asMap()
          .entries
          .map<int?>((entry) {
            return (() {
              final vv = entry.value;
              if (vv == null) {
                onIssue?.call(
                  EasyIssue(
                    path: 'i' + '[' + entry.key.toString() + ']',
                    code: 'null_not_allowed',
                    message: 'Null value not allowed.',
                  ),
                );
                return null;
              }
              if (vv is int) return vv;
              onIssue?.call(
                EasyIssue(
                  path: 'i' + '[' + entry.key.toString() + ']',
                  code: 'type_mismatch',
                  message: 'Expected int.',
                ),
              );
              return null;
            })();
          })
          .where((x) => x != null)
          .cast<int>()
          .toSet();
    })(),
    d: (() {
      final _v = json['d'];
      if (_v is! List) return const <double>{};
      final _list = _v;
      return _list
          .asMap()
          .entries
          .map<double?>((entry) {
            return (() {
              final vv = entry.value;
              if (vv == null) {
                onIssue?.call(
                  EasyIssue(
                    path: 'd' + '[' + entry.key.toString() + ']',
                    code: 'null_not_allowed',
                    message: 'Null value not allowed.',
                  ),
                );
                return null;
              }
              if (vv is num) return vv.toDouble();
              onIssue?.call(
                EasyIssue(
                  path: 'd' + '[' + entry.key.toString() + ']',
                  code: 'type_mismatch',
                  message: 'Expected number.',
                ),
              );
              return null;
            })();
          })
          .where((x) => x != null)
          .cast<double>()
          .toSet();
    })(),
    s: (() {
      final _v = json['s'];
      if (_v is! List) return const <String>{};
      final _list = _v;
      return _list
          .asMap()
          .entries
          .map<String?>((entry) {
            return (() {
              final vv = entry.value;
              if (vv == null) {
                onIssue?.call(
                  EasyIssue(
                    path: 's' + '[' + entry.key.toString() + ']',
                    code: 'null_not_allowed',
                    message: 'Null value not allowed.',
                  ),
                );
                return null;
              }
              if (vv is String) return vv;
              onIssue?.call(
                EasyIssue(
                  path: 's' + '[' + entry.key.toString() + ']',
                  code: 'type_mismatch',
                  message: 'Expected String.',
                ),
              );
              return null;
            })();
          })
          .where((x) => x != null)
          .cast<String>()
          .toSet();
    })(),
    dt: (() {
      final _v = json['dt'];
      if (_v is! List) return const <DateTime>{};
      final _list = _v;
      return _list
          .asMap()
          .entries
          .map<DateTime?>((entry) {
            return (() {
              final vv = entry.value;
              if (vv == null) {
                onIssue?.call(
                  EasyIssue(
                    path: 'dt' + '[' + entry.key.toString() + ']',
                    code: 'null_not_allowed',
                    message: 'Null value not allowed.',
                  ),
                );
                return null;
              }
              if (vv == null) return null;
              final r = ej.decodeDateTime(vv);
              if (r != null) return r;
              onIssue?.call(
                EasyIssue(
                  path: 'dt' + '[' + entry.key.toString() + ']',
                  code: 'type_mismatch',
                  message: 'Expected ISO-8601 String or epoch milliseconds.',
                ),
              );
              return null;
            })();
          })
          .where((x) => x != null)
          .cast<DateTime>()
          .toSet();
    })(),
    u: (() {
      final _v = json['u'];
      if (_v is! List) return const <Uri>{};
      final _list = _v;
      return _list
          .asMap()
          .entries
          .map<Uri?>((entry) {
            return (() {
              final vv = entry.value;
              if (vv == null) {
                onIssue?.call(
                  EasyIssue(
                    path: 'u' + '[' + entry.key.toString() + ']',
                    code: 'null_not_allowed',
                    message: 'Null value not allowed.',
                  ),
                );
                return null;
              }
              if (vv == null) return null;
              final r = ej.decodeUri(vv);
              if (r != null) return r;
              onIssue?.call(
                (vv is String
                    ? EasyIssue(
                        path: 'u' + '[' + entry.key.toString() + ']',
                        code: 'invalid_uri',
                        message: 'Invalid URI.',
                      )
                    : EasyIssue(
                        path: 'u' + '[' + entry.key.toString() + ']',
                        code: 'type_mismatch',
                        message: 'Expected String (URI).',
                      )),
              );
              return null;
            })();
          })
          .where((x) => x != null)
          .cast<Uri>()
          .toSet();
    })(),
    du: (() {
      final _v = json['du'];
      if (_v is! List) return const <Duration>{};
      final _list = _v;
      return _list
          .asMap()
          .entries
          .map<Duration?>((entry) {
            return (() {
              final vv = entry.value;
              if (vv == null) {
                onIssue?.call(
                  EasyIssue(
                    path: 'du' + '[' + entry.key.toString() + ']',
                    code: 'null_not_allowed',
                    message: 'Null value not allowed.',
                  ),
                );
                return null;
              }
              if (vv == null) return null;
              final r = ej.decodeDuration(vv);
              if (r != null) return r;
              onIssue?.call(
                EasyIssue(
                  path: 'du' + '[' + entry.key.toString() + ']',
                  code: 'type_mismatch',
                  message: 'Expected number of microseconds.',
                ),
              );
              return null;
            })();
          })
          .where((x) => x != null)
          .cast<Duration>()
          .toSet();
    })(),
    bi: (() {
      final _v = json['bi'];
      if (_v is! List) return const <BigInt>{};
      final _list = _v;
      return _list
          .asMap()
          .entries
          .map<BigInt?>((entry) {
            return (() {
              final vv = entry.value;
              if (vv == null) {
                onIssue?.call(
                  EasyIssue(
                    path: 'bi' + '[' + entry.key.toString() + ']',
                    code: 'null_not_allowed',
                    message: 'Null value not allowed.',
                  ),
                );
                return null;
              }
              if (vv == null) return null;
              final r = ej.decodeBigInt(vv);
              if (r != null) return r;
              onIssue?.call(
                (vv is String
                    ? EasyIssue(
                        path: 'bi' + '[' + entry.key.toString() + ']',
                        code: 'invalid_bigint',
                        message: 'Invalid integer string.',
                      )
                    : EasyIssue(
                        path: 'bi' + '[' + entry.key.toString() + ']',
                        code: 'type_mismatch',
                        message: 'Expected String (integer) or int.',
                      )),
              );
              return null;
            })();
          })
          .where((x) => x != null)
          .cast<BigInt>()
          .toSet();
    })(),
    c: (() {
      final _v = json['c'];
      if (_v is! List) return const <Color>{};
      final _list = _v;
      return _list
          .asMap()
          .entries
          .map<Color?>((entry) {
            return (() {
              final vv = entry.value;
              if (vv == null) {
                onIssue?.call(
                  EasyIssue(
                    path: 'c' + '[' + entry.key.toString() + ']',
                    code: 'null_not_allowed',
                    message: 'Null value not allowed.',
                  ),
                );
                return null;
              }
              if (vv is String) {
                final match = Color.values.where((x) => x.name == vv);
                if (match.isNotEmpty) return match.first;
                onIssue?.call(
                  EasyIssue(
                    path: 'c' + '[' + entry.key.toString() + ']',
                    code: 'invalid_enum',
                    message: "Value '$vv' does not match Color.",
                  ),
                );
                return null;
              }
              if (vv is int) {
                if (vv >= 0 && vv < Color.values.length)
                  return Color.values[vv];
                onIssue?.call(
                  EasyIssue(
                    path: 'c' + '[' + entry.key.toString() + ']',
                    code: 'invalid_enum_index',
                    message: 'Enum index out of range.',
                  ),
                );
                return null;
              }
              onIssue?.call(
                EasyIssue(
                  path: 'c' + '[' + entry.key.toString() + ']',
                  code: 'type_mismatch',
                  message: 'Expected String with the enum name.',
                ),
              );
              return null;
            })();
          })
          .where((x) => x != null)
          .cast<Color>()
          .toSet();
    })(),
  ))(_report);
}

class SetsJson {
  const SetsJson();

  static Sets fromJson(Map<String, dynamic> json) {
    return setsFromJson(json);
  }

  static Sets fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return setsFromJsonSafe(json, onIssue: onIssue, runValidate: runValidate);
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return setsValidate(json);
  }
}

List<Sets> setsFromJsonList(List<dynamic> json) =>
    json.map((e) => setsFromJson(e as Map<String, dynamic>)).toList();

List<Sets> setsFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => setsFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> setsToJsonList(List<Sets> items) =>
    items.map((e) => setsToJson(e)).toList();

Maps mapsFromJson(Map<String, dynamic> json) {
  return Maps(
    i: (Map<dynamic, dynamic>.from(json['i'] as Map)).entries.fold(
      <String, int>{},
      (acc, entry) {
        final k = (entry.key is String
            ? (entry.key as String)
            : entry.key.toString());
        final v = (entry.value as int?) ?? 0;
        acc[k] = v;
        return acc;
      },
    ),
    d: (Map<dynamic, dynamic>.from(json['d'] as Map)).entries.fold(
      <String, double>{},
      (acc, entry) {
        final k = (entry.key is String
            ? (entry.key as String)
            : entry.key.toString());
        final v = (entry.value as num?)?.toDouble() ?? 0.0;
        acc[k] = v;
        return acc;
      },
    ),
    b: (Map<dynamic, dynamic>.from(json['b'] as Map)).entries.fold(
      <String, bool>{},
      (acc, entry) {
        final k = (entry.key is String
            ? (entry.key as String)
            : entry.key.toString());
        final v = (entry.value as bool?) ?? false;
        acc[k] = v;
        return acc;
      },
    ),
    s: (Map<dynamic, dynamic>.from(json['s'] as Map)).entries.fold(
      <String, String>{},
      (acc, entry) {
        final k = (entry.key is String
            ? (entry.key as String)
            : entry.key.toString());
        final v = (entry.value as String?) ?? '';
        acc[k] = v;
        return acc;
      },
    ),
    dt: (Map<dynamic, dynamic>.from(json['dt'] as Map)).entries.fold(
      <String, DateTime>{},
      (acc, entry) {
        final k = (entry.key is String
            ? (entry.key as String)
            : entry.key.toString());
        final v =
            (ej.decodeDateTime(entry.value) ??
            (throw FormatException('Invalid DateTime value.')));
        acc[k] = v;
        return acc;
      },
    ),
    u: (Map<dynamic, dynamic>.from(json['u'] as Map)).entries.fold(
      <String, Uri>{},
      (acc, entry) {
        final k = (entry.key is String
            ? (entry.key as String)
            : entry.key.toString());
        final v =
            (ej.decodeUri(entry.value) ??
            (throw FormatException('Invalid Uri value.')));
        acc[k] = v;
        return acc;
      },
    ),
    du: (Map<dynamic, dynamic>.from(json['du'] as Map)).entries.fold(
      <String, Duration>{},
      (acc, entry) {
        final k = (entry.key is String
            ? (entry.key as String)
            : entry.key.toString());
        final v =
            (ej.decodeDuration(entry.value) ??
            (throw FormatException('Invalid Duration value.')));
        acc[k] = v;
        return acc;
      },
    ),
    bi: (Map<dynamic, dynamic>.from(json['bi'] as Map)).entries.fold(
      <String, BigInt>{},
      (acc, entry) {
        final k = (entry.key is String
            ? (entry.key as String)
            : entry.key.toString());
        final v =
            (ej.decodeBigInt(entry.value) ??
            (throw FormatException('Invalid BigInt value.')));
        acc[k] = v;
        return acc;
      },
    ),
    by: (Map<dynamic, dynamic>.from(json['by'] as Map)).entries.fold(
      <String, Uint8List>{},
      (acc, entry) {
        final k = (entry.key is String
            ? (entry.key as String)
            : entry.key.toString());
        final v =
            (ej.decodeBytes(entry.value) ??
            (throw FormatException('Invalid Uint8List value.')));
        acc[k] = v;
        return acc;
      },
    ),
    c: (Map<dynamic, dynamic>.from(json['c'] as Map)).entries.fold(
      <String, Color>{},
      (acc, entry) {
        final k = (entry.key is String
            ? (entry.key as String)
            : entry.key.toString());
        final v = Color.values.byName(entry.value as String);
        acc[k] = v;
        return acc;
      },
    ),
    o: (Map<dynamic, dynamic>.from(json['o'] as Map)).entries.fold(
      <String, Inner>{},
      (acc, entry) {
        final k = (entry.key is String
            ? (entry.key as String)
            : entry.key.toString());
        final v = innerFromJson(Map<String, dynamic>.from(entry.value as Map));
        acc[k] = v;
        return acc;
      },
    ),
    ik: (Map<dynamic, dynamic>.from(json['ik'] as Map)).entries.fold(
      <int, String>{},
      (acc, entry) {
        final k = (entry.key is int
            ? (entry.key as int)
            : (entry.key is num
                  ? (entry.key as num).toInt()
                  : int.parse(entry.key as String)));
        final v = (entry.value as String?) ?? '';
        acc[k] = v;
        return acc;
      },
    ),
    iN: (Map<dynamic, dynamic>.from(json['iN'] as Map)).entries.fold(
      <String, int?>{},
      (acc, entry) {
        final k = (entry.key is String
            ? (entry.key as String)
            : entry.key.toString());
        final v = (entry.value as int?);
        acc[k] = v;
        return acc;
      },
    ),
  );
}

Map<String, dynamic> mapsToJson(Maps instance) {
  return <String, dynamic>{
    'i': instance.i,
    'd': instance.d,
    'b': instance.b,
    's': instance.s,
    'dt': instance.dt.map((k, v) => MapEntry(k, v.toIso8601String())),
    'u': instance.u.map((k, v) => MapEntry(k, v.toString())),
    'du': instance.du.map((k, v) => MapEntry(k, v.inMicroseconds)),
    'bi': instance.bi.map((k, v) => MapEntry(k, v.toString())),
    'by': instance.by.map((k, v) => MapEntry(k, base64Encode(v))),
    'c': instance.c.map((k, v) => MapEntry(k, v.name)),
    'o': instance.o.map((k, v) => MapEntry(k, v.toJson())),
    'ik': instance.ik.map((k, v) => MapEntry(k.toString(), v)),
    'iN': instance.iN,
  };
}

mixin MapsSerializer {
  Map<String, dynamic> toJson() {
    return mapsToJson(this as Maps);
  }
}

List<EasyIssue> mapsValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('i')) {
    issues.add(
      EasyIssue(
        path: 'i',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('i') && json['i'] == null) {
    issues.add(
      EasyIssue(
        path: 'i',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('i')) {
    final v = json['i'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(path: 'i', code: 'type_mismatch', message: 'Expected Map.'),
      );
    } else if (v is Map) {
      for (final e in v.entries) {
        final val = e.value;
        if (val == null) {
          issues.add(
            EasyIssue(
              path: 'i' + '.' + e.key.toString(),
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else if (val is! int) {
          issues.add(
            EasyIssue(
              path: 'i' + '.' + e.key.toString(),
              code: 'type_mismatch',
              message: 'Expected int.',
            ),
          );
        }
      }
    }
  }
  if (!json.containsKey('d')) {
    issues.add(
      EasyIssue(
        path: 'd',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('d') && json['d'] == null) {
    issues.add(
      EasyIssue(
        path: 'd',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('d')) {
    final v = json['d'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(path: 'd', code: 'type_mismatch', message: 'Expected Map.'),
      );
    } else if (v is Map) {
      for (final e in v.entries) {
        final val = e.value;
        if (val == null) {
          issues.add(
            EasyIssue(
              path: 'd' + '.' + e.key.toString(),
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else if (val is! num) {
          issues.add(
            EasyIssue(
              path: 'd' + '.' + e.key.toString(),
              code: 'type_mismatch',
              message: 'Expected double.',
            ),
          );
        }
      }
    }
  }
  if (!json.containsKey('b')) {
    issues.add(
      EasyIssue(
        path: 'b',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('b') && json['b'] == null) {
    issues.add(
      EasyIssue(
        path: 'b',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('b')) {
    final v = json['b'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(path: 'b', code: 'type_mismatch', message: 'Expected Map.'),
      );
    } else if (v is Map) {
      for (final e in v.entries) {
        final val = e.value;
        if (val == null) {
          issues.add(
            EasyIssue(
              path: 'b' + '.' + e.key.toString(),
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else if (val is! bool) {
          issues.add(
            EasyIssue(
              path: 'b' + '.' + e.key.toString(),
              code: 'type_mismatch',
              message: 'Expected bool.',
            ),
          );
        }
      }
    }
  }
  if (!json.containsKey('s')) {
    issues.add(
      EasyIssue(
        path: 's',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('s') && json['s'] == null) {
    issues.add(
      EasyIssue(
        path: 's',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('s')) {
    final v = json['s'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(path: 's', code: 'type_mismatch', message: 'Expected Map.'),
      );
    } else if (v is Map) {
      for (final e in v.entries) {
        final val = e.value;
        if (val == null) {
          issues.add(
            EasyIssue(
              path: 's' + '.' + e.key.toString(),
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else if (val is! String) {
          issues.add(
            EasyIssue(
              path: 's' + '.' + e.key.toString(),
              code: 'type_mismatch',
              message: 'Expected String.',
            ),
          );
        }
      }
    }
  }
  if (!json.containsKey('dt')) {
    issues.add(
      EasyIssue(
        path: 'dt',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('dt') && json['dt'] == null) {
    issues.add(
      EasyIssue(
        path: 'dt',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('dt')) {
    final v = json['dt'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(path: 'dt', code: 'type_mismatch', message: 'Expected Map.'),
      );
    } else if (v is Map) {
      for (final e in v.entries) {
        final val = e.value;
        if (val == null) {
          issues.add(
            EasyIssue(
              path: 'dt' + '.' + e.key.toString(),
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else if (val != null) {
          if (ej.decodeDateTime(val) == null) {
            issues.add(
              EasyIssue(
                path: 'dt' + '.' + e.key.toString(),
                code: 'type_mismatch',
                message: 'Expected ISO-8601 String or epoch milliseconds.',
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('u')) {
    issues.add(
      EasyIssue(
        path: 'u',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('u') && json['u'] == null) {
    issues.add(
      EasyIssue(
        path: 'u',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('u')) {
    final v = json['u'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(path: 'u', code: 'type_mismatch', message: 'Expected Map.'),
      );
    } else if (v is Map) {
      for (final e in v.entries) {
        final val = e.value;
        if (val == null) {
          issues.add(
            EasyIssue(
              path: 'u' + '.' + e.key.toString(),
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else if (val != null) {
          if (ej.decodeUri(val) == null) {
            issues.add(
              (val is String
                  ? EasyIssue(
                      path: 'u' + '.' + e.key.toString(),
                      code: 'invalid_uri',
                      message: 'Invalid URI.',
                    )
                  : EasyIssue(
                      path: 'u' + '.' + e.key.toString(),
                      code: 'type_mismatch',
                      message: 'Expected String (URI).',
                    )),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('du')) {
    issues.add(
      EasyIssue(
        path: 'du',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('du') && json['du'] == null) {
    issues.add(
      EasyIssue(
        path: 'du',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('du')) {
    final v = json['du'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(path: 'du', code: 'type_mismatch', message: 'Expected Map.'),
      );
    } else if (v is Map) {
      for (final e in v.entries) {
        final val = e.value;
        if (val == null) {
          issues.add(
            EasyIssue(
              path: 'du' + '.' + e.key.toString(),
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else if (val != null) {
          if (ej.decodeDuration(val) == null) {
            issues.add(
              EasyIssue(
                path: 'du' + '.' + e.key.toString(),
                code: 'type_mismatch',
                message: 'Expected number of microseconds.',
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('bi')) {
    issues.add(
      EasyIssue(
        path: 'bi',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('bi') && json['bi'] == null) {
    issues.add(
      EasyIssue(
        path: 'bi',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('bi')) {
    final v = json['bi'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(path: 'bi', code: 'type_mismatch', message: 'Expected Map.'),
      );
    } else if (v is Map) {
      for (final e in v.entries) {
        final val = e.value;
        if (val == null) {
          issues.add(
            EasyIssue(
              path: 'bi' + '.' + e.key.toString(),
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else if (val != null) {
          if (ej.decodeBigInt(val) == null) {
            issues.add(
              (val is String
                  ? EasyIssue(
                      path: 'bi' + '.' + e.key.toString(),
                      code: 'invalid_bigint',
                      message: 'Invalid integer string.',
                    )
                  : EasyIssue(
                      path: 'bi' + '.' + e.key.toString(),
                      code: 'type_mismatch',
                      message: 'Expected String (integer) or int.',
                    )),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('by')) {
    issues.add(
      EasyIssue(
        path: 'by',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('by') && json['by'] == null) {
    issues.add(
      EasyIssue(
        path: 'by',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('by')) {
    final v = json['by'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(path: 'by', code: 'type_mismatch', message: 'Expected Map.'),
      );
    } else if (v is Map) {
      for (final e in v.entries) {
        final val = e.value;
        if (val == null) {
          issues.add(
            EasyIssue(
              path: 'by' + '.' + e.key.toString(),
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else if (val != null) {
          if (ej.decodeBytes(val) == null) {
            issues.add(
              (val is String
                  ? EasyIssue(
                      path: 'by' + '.' + e.key.toString(),
                      code: 'invalid_base64',
                      message: 'Invalid Base64 string.',
                    )
                  : EasyIssue(
                      path: 'by' + '.' + e.key.toString(),
                      code: 'type_mismatch',
                      message: 'Expected String (Base64).',
                    )),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('c')) {
    issues.add(
      EasyIssue(
        path: 'c',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('c') && json['c'] == null) {
    issues.add(
      EasyIssue(
        path: 'c',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('c')) {
    final v = json['c'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(path: 'c', code: 'type_mismatch', message: 'Expected Map.'),
      );
    } else if (v is Map) {
      for (final e in v.entries) {
        final val = e.value;
        if (val != null && val is! String) {
          issues.add(
            EasyIssue(
              path: 'c' + '.' + e.key.toString(),
              code: 'type_mismatch',
              message: 'Expected String with enum name.',
            ),
          );
        } else if (val != null) {
          final ok = Color.values.any((x) => x.name == val);
          if (!ok) {
            issues.add(
              EasyIssue(
                path: 'c' + '.' + e.key.toString(),
                code: 'invalid_enum',
                message: "Value '$val' does not match Color.",
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('o')) {
    issues.add(
      EasyIssue(
        path: 'o',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('o') && json['o'] == null) {
    issues.add(
      EasyIssue(
        path: 'o',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('o')) {
    final v = json['o'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(path: 'o', code: 'type_mismatch', message: 'Expected Map.'),
      );
    } else if (v is Map) {
      for (final e in v.entries) {
        final val = e.value;
        if (val != null && val is! Map) {
          issues.add(
            EasyIssue(
              path: 'o' + '.' + e.key.toString(),
              code: 'type_mismatch',
              message: 'Expected Map for Inner.',
            ),
          );
        } else if (val is Map) {
          final child = innerValidate(Map<String, dynamic>.from(val as Map));
          for (final ci in child) {
            issues.add(
              EasyIssue(
                path: 'o' + '.' + e.key.toString() + '.' + ci.path,
                code: ci.code,
                message: ci.message,
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('ik')) {
    issues.add(
      EasyIssue(
        path: 'ik',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('ik') && json['ik'] == null) {
    issues.add(
      EasyIssue(
        path: 'ik',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('ik')) {
    final v = json['ik'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(path: 'ik', code: 'type_mismatch', message: 'Expected Map.'),
      );
    } else if (v is Map) {
      for (final e in v.entries) {
        final k = e.key;
        final ok =
            (k is int) ||
            (k is num) ||
            (k is String && num.tryParse(k) != null);
        if (!ok) {
          issues.add(
            EasyIssue(
              path: 'ik' + '.' + k.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
        }
      }

      for (final e in v.entries) {
        final val = e.value;
        if (val == null) {
          issues.add(
            EasyIssue(
              path: 'ik' + '.' + e.key.toString(),
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else if (val is! String) {
          issues.add(
            EasyIssue(
              path: 'ik' + '.' + e.key.toString(),
              code: 'type_mismatch',
              message: 'Expected String.',
            ),
          );
        }
      }
    }
  }
  if (!json.containsKey('iN')) {
    issues.add(
      EasyIssue(
        path: 'iN',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('iN') && json['iN'] == null) {
    issues.add(
      EasyIssue(
        path: 'iN',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('iN')) {
    final v = json['iN'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(path: 'iN', code: 'type_mismatch', message: 'Expected Map.'),
      );
    } else if (v is Map) {
      for (final e in v.entries) {
        final val = e.value;
        if (val == null) {
        } else if (val is! int) {
          issues.add(
            EasyIssue(
              path: 'iN' + '.' + e.key.toString(),
              code: 'type_mismatch',
              message: 'Expected int.',
            ),
          );
        }
      }
    }
  }
  return issues;
}

Maps mapsFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in mapsValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Maps(
    i: (() {
      final _v = json['i'];
      if (_v is! Map) return const <String, int>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <String, int>{};
      for (final entry in _mapRaw.entries) {
        final k = (entry.key is String) ? entry.key : (entry.key?.toString());
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 'i' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = (() {
          final v = entry.value;
          return (v is int) ? v : 0;
        })();
        _out[k] = v;
      }
      return _out;
    })(),
    d: (() {
      final _v = json['d'];
      if (_v is! Map) return const <String, double>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <String, double>{};
      for (final entry in _mapRaw.entries) {
        final k = (entry.key is String) ? entry.key : (entry.key?.toString());
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 'd' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = (() {
          final v = entry.value;
          return (v is num) ? v.toDouble() : 0.0;
        })();
        _out[k] = v;
      }
      return _out;
    })(),
    b: (() {
      final _v = json['b'];
      if (_v is! Map) return const <String, bool>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <String, bool>{};
      for (final entry in _mapRaw.entries) {
        final k = (entry.key is String) ? entry.key : (entry.key?.toString());
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 'b' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = (() {
          final v = entry.value;
          return (v is bool) ? v : false;
        })();
        _out[k] = v;
      }
      return _out;
    })(),
    s: (() {
      final _v = json['s'];
      if (_v is! Map) return const <String, String>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <String, String>{};
      for (final entry in _mapRaw.entries) {
        final k = (entry.key is String) ? entry.key : (entry.key?.toString());
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 's' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = (() {
          final v = entry.value;
          return (v is String) ? v : '';
        })();
        _out[k] = v;
      }
      return _out;
    })(),
    dt: (() {
      final _v = json['dt'];
      if (_v is! Map) return const <String, DateTime>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <String, DateTime>{};
      for (final entry in _mapRaw.entries) {
        final k = (entry.key is String) ? entry.key : (entry.key?.toString());
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 'dt' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'dt' + '.' + k.toString(),
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return DateTime.fromMillisecondsSinceEpoch(0);
          }
          final r = ej.decodeDateTime(v);
          if (r != null) return r;
          onIssue?.call(
            EasyIssue(
              path: 'dt' + '.' + k.toString(),
              code: 'type_mismatch',
              message: 'Expected ISO-8601 String or epoch milliseconds.',
            ),
          );
          return DateTime.fromMillisecondsSinceEpoch(0);
        })();
        _out[k] = v;
      }
      return _out;
    })(),
    u: (() {
      final _v = json['u'];
      if (_v is! Map) return const <String, Uri>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <String, Uri>{};
      for (final entry in _mapRaw.entries) {
        final k = (entry.key is String) ? entry.key : (entry.key?.toString());
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 'u' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'u' + '.' + k.toString(),
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return Uri();
          }
          final r = ej.decodeUri(v);
          if (r != null) return r;
          onIssue?.call(
            (v is String
                ? EasyIssue(
                    path: 'u' + '.' + k.toString(),
                    code: 'invalid_uri',
                    message: 'Invalid URI.',
                  )
                : EasyIssue(
                    path: 'u' + '.' + k.toString(),
                    code: 'type_mismatch',
                    message: 'Expected String (URI).',
                  )),
          );
          return Uri();
        })();
        _out[k] = v;
      }
      return _out;
    })(),
    du: (() {
      final _v = json['du'];
      if (_v is! Map) return const <String, Duration>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <String, Duration>{};
      for (final entry in _mapRaw.entries) {
        final k = (entry.key is String) ? entry.key : (entry.key?.toString());
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 'du' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'du' + '.' + k.toString(),
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return Duration.zero;
          }
          final r = ej.decodeDuration(v);
          if (r != null) return r;
          onIssue?.call(
            EasyIssue(
              path: 'du' + '.' + k.toString(),
              code: 'type_mismatch',
              message: 'Expected number of microseconds.',
            ),
          );
          return Duration.zero;
        })();
        _out[k] = v;
      }
      return _out;
    })(),
    bi: (() {
      final _v = json['bi'];
      if (_v is! Map) return const <String, BigInt>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <String, BigInt>{};
      for (final entry in _mapRaw.entries) {
        final k = (entry.key is String) ? entry.key : (entry.key?.toString());
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 'bi' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'bi' + '.' + k.toString(),
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return BigInt.zero;
          }
          final r = ej.decodeBigInt(v);
          if (r != null) return r;
          onIssue?.call(
            (v is String
                ? EasyIssue(
                    path: 'bi' + '.' + k.toString(),
                    code: 'invalid_bigint',
                    message: 'Invalid integer string.',
                  )
                : EasyIssue(
                    path: 'bi' + '.' + k.toString(),
                    code: 'type_mismatch',
                    message: 'Expected String (integer) or int.',
                  )),
          );
          return BigInt.zero;
        })();
        _out[k] = v;
      }
      return _out;
    })(),
    by: (() {
      final _v = json['by'];
      if (_v is! Map) return const <String, Uint8List>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <String, Uint8List>{};
      for (final entry in _mapRaw.entries) {
        final k = (entry.key is String) ? entry.key : (entry.key?.toString());
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 'by' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'by' + '.' + k.toString(),
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return Uint8List(0);
          }
          final r = ej.decodeBytes(v);
          if (r != null) return r;
          onIssue?.call(
            (v is String
                ? EasyIssue(
                    path: 'by' + '.' + k.toString(),
                    code: 'invalid_base64',
                    message: 'Invalid Base64 string.',
                  )
                : EasyIssue(
                    path: 'by' + '.' + k.toString(),
                    code: 'type_mismatch',
                    message: 'Expected String (Base64).',
                  )),
          );
          return Uint8List(0);
        })();
        _out[k] = v;
      }
      return _out;
    })(),
    c: (() {
      final _v = json['c'];
      if (_v is! Map) return const <String, Color>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <String, Color>{};
      for (final entry in _mapRaw.entries) {
        final k = (entry.key is String) ? entry.key : (entry.key?.toString());
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 'c' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = (entry.value is String
            ? Color.values.firstWhere(
                (x) => x.name == entry.value,
                orElse: () => Color.values.first,
              )
            : Color.values.first);
        _out[k] = v;
      }
      return _out;
    })(),
    o: (() {
      final _v = json['o'];
      if (_v is! Map) return const <String, Inner>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <String, Inner>{};
      for (final entry in _mapRaw.entries) {
        final k = (entry.key is String) ? entry.key : (entry.key?.toString());
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 'o' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = (() {
          final _v = entry.value;
          if (_v is Map) {
            return innerFromJsonSafe(
              Map<String, dynamic>.from(_v as Map),
              onIssue: (i) => onIssue?.call(
                EasyIssue(
                  path: 'o' + '.' + k.toString() + '.' + i.path,
                  code: i.code,
                  message: i.message,
                ),
              ),
              runValidate: false,
            );
          }
          return innerFromJsonSafe(
            const <String, dynamic>{},
            onIssue: (i) => onIssue?.call(
              EasyIssue(
                path: 'o' + '.' + k.toString() + '.' + i.path,
                code: i.code,
                message: i.message,
              ),
            ),
            runValidate: false,
          );
        })();
        _out[k] = v;
      }
      return _out;
    })(),
    ik: (() {
      final _v = json['ik'];
      if (_v is! Map) return const <int, String>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <int, String>{};
      for (final entry in _mapRaw.entries) {
        final k = (() {
          final _k = entry.key;
          if (_k is int) return _k;
          if (_k is num) return _k.toInt();
          if (_k is String) {
            final n = num.tryParse(_k);
            if (n != null) return n.toInt();
          }
          return null;
        })();
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 'ik' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = (() {
          final v = entry.value;
          return (v is String) ? v : '';
        })();
        _out[k] = v;
      }
      return _out;
    })(),
    iN: (() {
      final _v = json['iN'];
      if (_v is! Map) return const <String, int?>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <String, int?>{};
      for (final entry in _mapRaw.entries) {
        final k = (entry.key is String) ? entry.key : (entry.key?.toString());
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 'iN' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = (() {
          final v = entry.value;
          return (v is int) ? v : null;
        })();
        _out[k] = v;
      }
      return _out;
    })(),
  ))(_report);
}

class MapsJson {
  const MapsJson();

  static Maps fromJson(Map<String, dynamic> json) {
    return mapsFromJson(json);
  }

  static Maps fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return mapsFromJsonSafe(json, onIssue: onIssue, runValidate: runValidate);
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return mapsValidate(json);
  }
}

List<Maps> mapsFromJsonList(List<dynamic> json) =>
    json.map((e) => mapsFromJson(e as Map<String, dynamic>)).toList();

List<Maps> mapsFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => mapsFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> mapsToJsonList(List<Maps> items) =>
    items.map((e) => mapsToJson(e)).toList();

Fallbacks fallbacksFromJson(Map<String, dynamic> json) {
  return Fallbacks(
    i: (json['i'] as int?) ?? 0,
    d: (json['d'] as num?)?.toDouble() ?? 0.0,
    n: json['n'] as num,
    b: (json['b'] as bool?) ?? false,
    s: (json['s'] as String?) ?? '',
    dt: ej.parseDateTime(json['dt']),
    u: Uri.parse(json['u'] as String),
    du: Duration(microseconds: (json['du'] as num).toInt()),
    bi: BigInt.parse(json['bi'] as String),
    by: base64Decode(json['by'] as String),
    uN: (json['uN'] as String?) != null
        ? Uri.parse(json['uN'] as String)
        : null,
    li:
        ((json['li'] as List?)?.asMap().entries.map<int>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (e as int?) ?? 0;
        }).toList()) ??
        const <int>[],
    ldt:
        ((json['ldt'] as List?)?.asMap().entries.map<DateTime>((entry) {
          final i = entry.key;
          final e = entry.value;
          return (ej.decodeDateTime(e) ??
              (throw FormatException('Invalid DateTime value.')));
        }).toList()) ??
        const <DateTime>[],
    mu: (Map<dynamic, dynamic>.from(json['mu'] as Map)).entries.fold(
      <String, Uri>{},
      (acc, entry) {
        final k = (entry.key is String
            ? (entry.key as String)
            : entry.key.toString());
        final v =
            (ej.decodeUri(entry.value) ??
            (throw FormatException('Invalid Uri value.')));
        acc[k] = v;
        return acc;
      },
    ),
  );
}

Map<String, dynamic> fallbacksToJson(Fallbacks instance) {
  return <String, dynamic>{
    'i': instance.i,
    'd': instance.d,
    'n': instance.n,
    'b': instance.b,
    's': instance.s,
    'dt': instance.dt.toIso8601String(),
    'u': instance.u.toString(),
    'du': instance.du.inMicroseconds,
    'bi': instance.bi.toString(),
    'by': base64Encode(instance.by),
    if (instance.uN != null) 'uN': instance.uN?.toString(),
    'li': instance.li,
    'ldt': instance.ldt.map((e) => e.toIso8601String()).toList(),
    'mu': instance.mu.map((k, v) => MapEntry(k, v.toString())),
  };
}

mixin FallbacksSerializer {
  Map<String, dynamic> toJson() {
    return fallbacksToJson(this as Fallbacks);
  }
}

List<EasyIssue> fallbacksValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('i')) {
    issues.add(
      EasyIssue(
        path: 'i',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('i') && json['i'] == null) {
    issues.add(
      EasyIssue(
        path: 'i',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('i')) {
    final v = json['i'];
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(path: 'i', code: 'type_mismatch', message: 'Expected int.'),
        );
      } else {
        final v = _n;
      }
    }
  }
  if (!json.containsKey('d')) {
    issues.add(
      EasyIssue(
        path: 'd',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('d') && json['d'] == null) {
    issues.add(
      EasyIssue(
        path: 'd',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('d')) {
    final v = json['d'];
    if (v != null) {
      final _n = v is num
          ? v.toDouble()
          : (v is String ? double.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'd',
            code: 'type_mismatch',
            message: 'Expected number.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  if (!json.containsKey('n')) {
    issues.add(
      EasyIssue(
        path: 'n',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('n') && json['n'] == null) {
    issues.add(
      EasyIssue(
        path: 'n',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('n')) {
    final v = json['n'];
    if (v != null) {
      final _n = ej.decodeNum(v);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'n',
            code: 'type_mismatch',
            message: 'Expected number.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  if (!json.containsKey('b')) {
    issues.add(
      EasyIssue(
        path: 'b',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('b') && json['b'] == null) {
    issues.add(
      EasyIssue(
        path: 'b',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('b')) {
    final v = json['b'];
    if (v != null && v is! bool) {
      issues.add(
        EasyIssue(path: 'b', code: 'type_mismatch', message: 'Expected bool.'),
      );
    } else if (v != null) {}
  }
  if (!json.containsKey('s')) {
    issues.add(
      EasyIssue(
        path: 's',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('s') && json['s'] == null) {
    issues.add(
      EasyIssue(
        path: 's',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('s')) {
    final v = json['s'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 's',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  if (!json.containsKey('dt')) {
    issues.add(
      EasyIssue(
        path: 'dt',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('dt') && json['dt'] == null) {
    issues.add(
      EasyIssue(
        path: 'dt',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('dt')) {
    final v = json['dt'];
    if (v != null && v is! String && v is! num && v is! DateTime) {
      issues.add(
        EasyIssue(
          path: 'dt',
          code: 'type_mismatch',
          message: 'Expected String (ISO), num or DateTime.',
        ),
      );
    } else if (v is String) {
      if (DateTime.tryParse(v) == null) {
        issues.add(
          EasyIssue(
            path: 'dt',
            code: 'type_mismatch',
            message: 'Invalid ISO format.',
          ),
        );
      } else {
        final dt = DateTime.parse(v);
      }
    }
  }
  if (!json.containsKey('u')) {
    issues.add(
      EasyIssue(
        path: 'u',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('u') && json['u'] == null) {
    issues.add(
      EasyIssue(
        path: 'u',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('u')) {
    final v = json['u'];
    if (v is! String) {
      issues.add(
        EasyIssue(
          path: 'u',
          code: 'type_mismatch',
          message: 'Expected String (URI).',
        ),
      );
    } else if (Uri.tryParse(v) == null) {
      issues.add(
        EasyIssue(path: 'u', code: 'invalid_uri', message: 'Invalid URI.'),
      );
    }
  }
  if (!json.containsKey('du')) {
    issues.add(
      EasyIssue(
        path: 'du',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('du') && json['du'] == null) {
    issues.add(
      EasyIssue(
        path: 'du',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('du')) {
    final v = json['du'];
    if (v is! num && !(v is String && int.tryParse(v) != null)) {
      issues.add(
        EasyIssue(
          path: 'du',
          code: 'type_mismatch',
          message: 'Expected number of microseconds.',
        ),
      );
    }
  }
  if (!json.containsKey('bi')) {
    issues.add(
      EasyIssue(
        path: 'bi',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('bi') && json['bi'] == null) {
    issues.add(
      EasyIssue(
        path: 'bi',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('bi')) {
    final v = json['bi'];
    if (v is String) {
      if (BigInt.tryParse(v) == null) {
        issues.add(
          EasyIssue(
            path: 'bi',
            code: 'invalid_bigint',
            message: 'Invalid integer string.',
          ),
        );
      }
    } else if (v is! num) {
      issues.add(
        EasyIssue(
          path: 'bi',
          code: 'type_mismatch',
          message: 'Expected String (integer) or int.',
        ),
      );
    }
  }
  if (!json.containsKey('by')) {
    issues.add(
      EasyIssue(
        path: 'by',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('by') && json['by'] == null) {
    issues.add(
      EasyIssue(
        path: 'by',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('by')) {
    final v = json['by'];
    if (v is! String) {
      issues.add(
        EasyIssue(
          path: 'by',
          code: 'type_mismatch',
          message: 'Expected String (Base64).',
        ),
      );
    } else {
      try {
        base64Decode(v);
      } catch (_) {
        issues.add(
          EasyIssue(
            path: 'by',
            code: 'invalid_base64',
            message: 'Invalid Base64 string.',
          ),
        );
      }
    }
  }
  if (json.containsKey('uN')) {
    final v = json['uN'];
    if (v is! String) {
      issues.add(
        EasyIssue(
          path: 'uN',
          code: 'type_mismatch',
          message: 'Expected String (URI).',
        ),
      );
    } else if (Uri.tryParse(v) == null) {
      issues.add(
        EasyIssue(path: 'uN', code: 'invalid_uri', message: 'Invalid URI.'),
      );
    }
  }
  if (!json.containsKey('li')) {
    issues.add(
      EasyIssue(
        path: 'li',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('li') && json['li'] == null) {
    issues.add(
      EasyIssue(
        path: 'li',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('li')) {
    final v = json['li'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(path: 'li', code: 'type_mismatch', message: 'Expected List.'),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'li' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! int) {
            issues.add(
              EasyIssue(
                path: 'li' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected int.',
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('ldt')) {
    issues.add(
      EasyIssue(
        path: 'ldt',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('ldt') && json['ldt'] == null) {
    issues.add(
      EasyIssue(
        path: 'ldt',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('ldt')) {
    final v = json['ldt'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'ldt',
          code: 'type_mismatch',
          message: 'Expected List.',
        ),
      );
    } else if (v is List) {
      for (var i = 0; i < v.length; i++) {
        final e = v[i];
        if (e == null) {
          issues.add(
            EasyIssue(
              path: 'ldt' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (ej.decodeDateTime(e) == null) {
            issues.add(
              EasyIssue(
                path: 'ldt' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected ISO-8601 String or epoch milliseconds.',
              ),
            );
          }
        }
      }
    }
  }
  if (!json.containsKey('mu')) {
    issues.add(
      EasyIssue(
        path: 'mu',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('mu') && json['mu'] == null) {
    issues.add(
      EasyIssue(
        path: 'mu',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('mu')) {
    final v = json['mu'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(path: 'mu', code: 'type_mismatch', message: 'Expected Map.'),
      );
    } else if (v is Map) {
      for (final e in v.entries) {
        final val = e.value;
        if (val == null) {
          issues.add(
            EasyIssue(
              path: 'mu' + '.' + e.key.toString(),
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else if (val != null) {
          if (ej.decodeUri(val) == null) {
            issues.add(
              (val is String
                  ? EasyIssue(
                      path: 'mu' + '.' + e.key.toString(),
                      code: 'invalid_uri',
                      message: 'Invalid URI.',
                    )
                  : EasyIssue(
                      path: 'mu' + '.' + e.key.toString(),
                      code: 'type_mismatch',
                      message: 'Expected String (URI).',
                    )),
            );
          }
        }
      }
    }
  }
  return issues;
}

Fallbacks fallbacksFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in fallbacksValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Fallbacks(
    i: (() {
      final v = json['i'];
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return p;
      }
      return -1;
    })(),
    d: (() {
      final v = json['d'];
      if (v is num) return v.toDouble();
      if (v is String) {
        final p = double.tryParse(v);
        if (p != null) return p;
      }
      return 1.0;
    })(),
    n: (() {
      final v = ej.decodeNum(json['n']);
      return v ?? 2;
    })(),
    b: (() {
      final v = json['b'];
      return (v is bool) ? v : true;
    })(),
    s: (() {
      final v = json['s'];
      return (v is String) ? v : 'R\$ 0,00';
    })(),
    dt: (() {
      final v = json['dt'];
      if (v == null) return DateTime.parse('2020-01-01T00:00:00.000Z');
      if (v is DateTime) return v;
      if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
      if (v is num) return DateTime.fromMillisecondsSinceEpoch(v.toInt());
      if (v is String) {
        try {
          return DateTime.parse(v);
        } catch (_) {
          onIssue?.call(
            EasyIssue(
              path: 'dt',
              code: 'type_mismatch',
              message: 'Invalid DateTime format.',
            ),
          );
          return DateTime.parse('2020-01-01T00:00:00.000Z');
        }
      }
      onIssue?.call(
        EasyIssue(
          path: 'dt',
          code: 'type_mismatch',
          message: 'Expected String/epoch/DateTime.',
        ),
      );
      return DateTime.parse('2020-01-01T00:00:00.000Z');
    })(),
    u: (() {
      final v = json['u'];
      if (v == null) return Uri.parse('https://fallback.dev');
      if (v is String) {
        final u = Uri.tryParse(v);
        if (u != null) return u;
        onIssue?.call(
          EasyIssue(path: 'u', code: 'invalid_uri', message: 'Invalid URI.'),
        );
        return Uri.parse('https://fallback.dev');
      }
      onIssue?.call(
        EasyIssue(
          path: 'u',
          code: 'type_mismatch',
          message: 'Expected String (URI).',
        ),
      );
      return Uri.parse('https://fallback.dev');
    })(),
    du: (() {
      final v = json['du'];
      if (v == null) return Duration(microseconds: 42);
      if (v is num) return Duration(microseconds: v.toInt());
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return Duration(microseconds: p);
      }
      onIssue?.call(
        EasyIssue(
          path: 'du',
          code: 'type_mismatch',
          message: 'Expected number of microseconds.',
        ),
      );
      return Duration(microseconds: 42);
    })(),
    bi: (() {
      final v = json['bi'];
      if (v == null) return BigInt.parse('99');
      if (v is String) {
        final b = BigInt.tryParse(v);
        if (b != null) return b;
        onIssue?.call(
          EasyIssue(
            path: 'bi',
            code: 'invalid_bigint',
            message: 'Invalid integer string.',
          ),
        );
        return BigInt.parse('99');
      }
      if (v is int) return BigInt.from(v);
      if (v is num) return BigInt.from(v.toInt());
      onIssue?.call(
        EasyIssue(
          path: 'bi',
          code: 'type_mismatch',
          message: 'Expected String (integer) or int.',
        ),
      );
      return BigInt.parse('99');
    })(),
    by: (() {
      final v = json['by'];
      if (v == null) return base64Decode('AQID');
      if (v is String) {
        try {
          return base64Decode(v);
        } catch (_) {
          onIssue?.call(
            EasyIssue(
              path: 'by',
              code: 'invalid_base64',
              message: 'Invalid Base64 string.',
            ),
          );
          return base64Decode('AQID');
        }
      }
      onIssue?.call(
        EasyIssue(
          path: 'by',
          code: 'type_mismatch',
          message: 'Expected String (Base64).',
        ),
      );
      return base64Decode('AQID');
    })(),
    uN: (() {
      final v = json['uN'];
      if (v == null) return null;
      if (v is String) {
        final u = Uri.tryParse(v);
        if (u != null) return u;
        onIssue?.call(
          EasyIssue(path: 'uN', code: 'invalid_uri', message: 'Invalid URI.'),
        );
        return Uri.parse('https://nullable.dev');
      }
      onIssue?.call(
        EasyIssue(
          path: 'uN',
          code: 'type_mismatch',
          message: 'Expected String (URI).',
        ),
      );
      return Uri.parse('https://nullable.dev');
    })(),
    li: (() {
      final _v = json['li'];
      if (_v is! List) return const <int>[];
      final _list = _v;
      return _list.asMap().entries.map<int>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'li' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return 0;
          }
          if (v is int) return v;
          onIssue?.call(
            EasyIssue(
              path: 'li' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Expected int.',
            ),
          );
          return 0;
        })();
      }).toList();
    })(),
    ldt: (() {
      final _v = json['ldt'];
      if (_v is! List) return const <DateTime>[];
      final _list = _v;
      return _list.asMap().entries.map<DateTime>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'ldt' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return DateTime.fromMillisecondsSinceEpoch(1000);
          }
          final r = ej.decodeDateTime(v);
          if (r != null) return r;
          onIssue?.call(
            EasyIssue(
              path: 'ldt' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Expected ISO-8601 String or epoch milliseconds.',
            ),
          );
          return DateTime.fromMillisecondsSinceEpoch(1000);
        })();
      }).toList();
    })(),
    mu: (() {
      final _v = json['mu'];
      if (_v is! Map) return const <String, Uri>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <String, Uri>{};
      for (final entry in _mapRaw.entries) {
        final k = (entry.key is String) ? entry.key : (entry.key?.toString());
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 'mu' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = (() {
          final v = entry.value;
          if (v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'mu' + '.' + k.toString(),
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return Uri.parse('https://item.dev');
          }
          final r = ej.decodeUri(v);
          if (r != null) return r;
          onIssue?.call(
            (v is String
                ? EasyIssue(
                    path: 'mu' + '.' + k.toString(),
                    code: 'invalid_uri',
                    message: 'Invalid URI.',
                  )
                : EasyIssue(
                    path: 'mu' + '.' + k.toString(),
                    code: 'type_mismatch',
                    message: 'Expected String (URI).',
                  )),
          );
          return Uri.parse('https://item.dev');
        })();
        _out[k] = v;
      }
      return _out;
    })(),
  ))(_report);
}

class FallbacksJson {
  const FallbacksJson();

  static Fallbacks fromJson(Map<String, dynamic> json) {
    return fallbacksFromJson(json);
  }

  static Fallbacks fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return fallbacksFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return fallbacksValidate(json);
  }
}

List<Fallbacks> fallbacksFromJsonList(List<dynamic> json) =>
    json.map((e) => fallbacksFromJson(e as Map<String, dynamic>)).toList();

List<Fallbacks> fallbacksFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => fallbacksFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> fallbacksToJsonList(List<Fallbacks> items) =>
    items.map((e) => fallbacksToJson(e)).toList();
