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
import 'readme_models.dart';

import 'package:dart_easy_json/runtime.dart';

import 'readme_models.dart';
import 'readme_models.easy.dart';

import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_easy_json/runtime.dart' as ej;

User userFromJson(Map<String, dynamic> json) {
  return User(
    name: (json['name'] as String?) ?? '',
    age: (json['age'] as int?) ?? 0,
    email: json['email'] as String?,
  );
}

Map<String, dynamic> userToJson(User instance) {
  return <String, dynamic>{
    'name': instance.name,
    'age': instance.age,
    if (instance.email != null) 'email': instance.email,
  };
}

mixin UserSerializer {
  Map<String, dynamic> toJson() {
    return userToJson(this as User);
  }
}

List<EasyIssue> userValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('name')) {
    issues.add(
      EasyIssue(
        path: 'name',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('name') && json['name'] == null) {
    issues.add(
      EasyIssue(
        path: 'name',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('name')) {
    final v = json['name'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'name',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  if (!json.containsKey('age')) {
    issues.add(
      EasyIssue(
        path: 'age',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('age') && json['age'] == null) {
    issues.add(
      EasyIssue(
        path: 'age',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('age')) {
    final v = json['age'];
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'age',
            code: 'type_mismatch',
            message: 'Expected int.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  if (json.containsKey('email')) {
    final v = json['email'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'email',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  return issues;
}

User userFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in userValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => User(
    name: (() {
      final v = json['name'];
      return (v is String) ? v : '';
    })(),
    age: (() {
      final v = json['age'];
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return p;
      }
      return 0;
    })(),
    email: (() {
      final v = json['email'];
      return (v is String) ? v : null;
    })(),
  ))(_report);
}

class UserJson {
  const UserJson();

  static User fromJson(Map<String, dynamic> json) {
    return userFromJson(json);
  }

  static User fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return userFromJsonSafe(json, onIssue: onIssue, runValidate: runValidate);
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return userValidate(json);
  }
}

List<User> userFromJsonList(List<dynamic> json) =>
    json.map((e) => userFromJson(e as Map<String, dynamic>)).toList();

List<User> userFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => userFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> userToJsonList(List<User> items) =>
    items.map((e) => userToJson(e)).toList();

Product productFromJson(Map<String, dynamic> json) {
  return Product(
    name: (json['name'] as String?) ?? '',
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    stock: (json['stock'] as int?) ?? 0,
  );
}

Map<String, dynamic> productToJson(Product instance) {
  return <String, dynamic>{
    'name': instance.name,
    'price': instance.price,
    'stock': instance.stock,
  };
}

mixin ProductSerializer {
  Map<String, dynamic> toJson() {
    return productToJson(this as Product);
  }
}

List<EasyIssue> productValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('name')) {
    issues.add(
      EasyIssue(
        path: 'name',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('name') && json['name'] == null) {
    issues.add(
      EasyIssue(
        path: 'name',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('name')) {
    final v = json['name'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'name',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {
      if (v.length < 3) {
        issues.add(
          EasyIssue(
            path: 'name',
            code: 'min_length',
            message: 'Must have at least 3 characters.',
          ),
        );
      }
    }
  }
  if (!json.containsKey('price')) {
    issues.add(
      EasyIssue(
        path: 'price',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('price') && json['price'] == null) {
    issues.add(
      EasyIssue(
        path: 'price',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('price')) {
    final v = json['price'];
    if (v != null) {
      final _n = v is num
          ? v.toDouble()
          : (v is String ? double.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'price',
            code: 'type_mismatch',
            message: 'Expected number.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  if (!json.containsKey('stock')) {
    issues.add(
      EasyIssue(
        path: 'stock',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('stock') && json['stock'] == null) {
    issues.add(
      EasyIssue(
        path: 'stock',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('stock')) {
    final v = json['stock'];
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'stock',
            code: 'type_mismatch',
            message: 'Expected int.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  return issues;
}

Product productFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in productValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Product(
    name: (() {
      final v = json['name'];
      return (v is String) ? v : '';
    })(),
    price: (() {
      final v = json['price'];
      if (v is num) return v.toDouble();
      if (v is String) {
        final p = double.tryParse(v);
        if (p != null) return p;
      }
      return 0.0;
    })(),
    stock: (() {
      final v = json['stock'];
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

class ProductJson {
  const ProductJson();

  static Product fromJson(Map<String, dynamic> json) {
    return productFromJson(json);
  }

  static Product fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return productFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return productValidate(json);
  }
}

List<Product> productFromJsonList(List<dynamic> json) =>
    json.map((e) => productFromJson(e as Map<String, dynamic>)).toList();

List<Product> productFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => productFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> productToJsonList(List<Product> items) =>
    items.map((e) => productToJson(e)).toList();

SignUp signUpFromJson(Map<String, dynamic> json) {
  final issues = signUpValidate(json);
  if (issues.isNotEmpty) throw EasyValidationException(issues);
  return signUpFromJsonSafe(json, runValidate: false);
}

Map<String, dynamic> signUpToJson(SignUp instance) {
  return <String, dynamic>{
    'name': instance.name,
    'age': instance.age,
    'email': instance.email,
  };
}

mixin SignUpSerializer {
  Map<String, dynamic> toJson() {
    return signUpToJson(this as SignUp);
  }
}

List<EasyIssue> signUpValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('name')) {
    issues.add(
      EasyIssue(
        path: 'name',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('name') && json['name'] == null) {
    issues.add(
      EasyIssue(
        path: 'name',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('name')) {
    final v = json['name'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'name',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  if (!json.containsKey('age')) {
    issues.add(
      EasyIssue(
        path: 'age',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('age') && json['age'] == null) {
    issues.add(
      EasyIssue(
        path: 'age',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('age')) {
    final v = json['age'];
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'age',
            code: 'type_mismatch',
            message: 'Expected int.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  if (!json.containsKey('email')) {
    issues.add(
      EasyIssue(
        path: 'email',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('email') && json['email'] == null) {
    issues.add(
      EasyIssue(
        path: 'email',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('email')) {
    final v = json['email'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'email',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {
      if (!RegExp(
        '^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$',
      ).hasMatch(v as String)) {
        issues.add(
          EasyIssue(
            path: 'email',
            code: 'invalid_email',
            message: 'Invalid email.',
          ),
        );
      }
    }
  }
  return issues;
}

SignUp signUpFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in signUpValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => SignUp(
    name: (() {
      final v = json['name'];
      return (v is String) ? v : '';
    })(),
    age: (() {
      final v = json['age'];
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return p;
      }
      return 0;
    })(),
    email: (() {
      final v = json['email'];
      return (v is String) ? v : '';
    })(),
  ))(_report);
}

class SignUpJson {
  const SignUpJson();

  static SignUp fromJson(Map<String, dynamic> json) {
    return signUpFromJson(json);
  }

  static SignUp fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return signUpFromJsonSafe(json, onIssue: onIssue, runValidate: runValidate);
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return signUpValidate(json);
  }
}

List<SignUp> signUpFromJsonList(List<dynamic> json) =>
    json.map((e) => signUpFromJson(e as Map<String, dynamic>)).toList();

List<SignUp> signUpFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => signUpFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> signUpToJsonList(List<SignUp> items) =>
    items.map((e) => signUpToJson(e)).toList();

PageResponse<T> pageResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return PageResponse<T>(
    items:
        ((json['items'] as List?)?.asMap().entries.map<T>((entry) {
          final i = entry.key;
          final e = entry.value;
          return fromJsonT(e);
        }).toList()) ??
        <T>[],
    total: (json['total'] as int?) ?? 0,
  );
}

Map<String, dynamic> pageResponseToJson<T>(
  PageResponse<T> instance,
  Object? Function(T value) toJsonT,
) {
  return <String, dynamic>{
    'items': instance.items.map((e) => toJsonT(e)).toList(),
    'total': instance.total,
  };
}

mixin PageResponseSerializer<T> {
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return pageResponseToJson<T>(this as PageResponse<T>, toJsonT);
  }
}

List<EasyIssue> pageResponseValidate<T>(
  Map<String, dynamic> json, {
  List<EasyIssue> Function(Object? json)? validateT,
}) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('items')) {
    issues.add(
      EasyIssue(
        path: 'items',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('items') && json['items'] == null) {
    issues.add(
      EasyIssue(
        path: 'items',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('items')) {
    final v = json['items'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'items',
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
              path: 'items' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (validateT != null) {
            for (final n0 in validateT(e)) {
              issues.add(
                EasyIssue(
                  path: 'items' + '[' + i.toString() + ']' + n0.path,
                  code: n0.code,
                  message: n0.message,
                ),
              );
            }
          }
        }
      }
    }
  }
  if (!json.containsKey('total')) {
    issues.add(
      EasyIssue(
        path: 'total',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('total') && json['total'] == null) {
    issues.add(
      EasyIssue(
        path: 'total',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('total')) {
    final v = json['total'];
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'total',
            code: 'type_mismatch',
            message: 'Expected int.',
          ),
        );
      } else {
        final v = _n;
      }
    }
  }
  return issues;
}

PageResponse<T> pageResponseFromJsonSafe<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in pageResponseValidate<T>(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => PageResponse<T>(
    items: (() {
      final _v = json['items'];
      if (_v is! List) return <T>[];
      final _list = _v;
      return _list.asMap().entries.map<T>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return fromJsonT(entry.value);
      }).toList();
    })(),
    total: (() {
      final v = json['total'];
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

class PageResponseJson {
  const PageResponseJson();

  static PageResponse<T> fromJson<T>(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return pageResponseFromJson<T>(json, fromJsonT);
  }

  static PageResponse<T> fromJsonSafe<T>(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return pageResponseFromJsonSafe<T>(
      json,
      fromJsonT,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return pageResponseValidate(json);
  }
}

List<PageResponse<T>> pageResponseFromJsonList<T>(
  List<dynamic> json,
  T Function(Object? json) fromJsonT,
) => json
    .map((e) => pageResponseFromJson<T>(e as Map<String, dynamic>, fromJsonT))
    .toList();

List<PageResponse<T>> pageResponseFromJsonSafeList<T>(
  List<dynamic> json,
  T Function(Object? json) fromJsonT, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => pageResponseFromJsonSafe<T>(
        entry.value as Map<String, dynamic>,
        fromJsonT,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> pageResponseToJsonList<T>(
  List<PageResponse<T>> items,
  Object? Function(T value) toJsonT,
) => items.map((e) => pageResponseToJson<T>(e, toJsonT)).toList();

UserSearch userSearchFromJson(Map<String, dynamic> json) {
  return UserSearch(
    results: pageResponseFromJson<User>(
      Map<String, dynamic>.from(json['results'] as Map),
      (Object? e0) => userFromJson(Map<String, dynamic>.from(e0 as Map)),
    ),
    byTeam: (Map<dynamic, dynamic>.from(json['byTeam'] as Map)).entries
        .fold<Map<String, List<User>>>(<String, List<User>>{}, (acc, entry) {
          final k = (entry.key is String
              ? (entry.key as String)
              : entry.key.toString());
          final v = <User>[
            for (final e0 in (entry.value as List))
              userFromJson(Map<String, dynamic>.from(e0 as Map)),
          ];
          acc[k] = v;
          return acc;
        }),
  );
}

Map<String, dynamic> userSearchToJson(UserSearch instance) {
  return <String, dynamic>{
    'results': instance.results.toJson((e0) => e0.toJson()),
    'byTeam': instance.byTeam.map(
      (k, v) => MapEntry(k, v.map((e0) => e0.toJson()).toList()),
    ),
  };
}

mixin UserSearchSerializer {
  Map<String, dynamic> toJson() {
    return userSearchToJson(this as UserSearch);
  }
}

List<EasyIssue> userSearchValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('results')) {
    issues.add(
      EasyIssue(
        path: 'results',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('results') && json['results'] == null) {
    issues.add(
      EasyIssue(
        path: 'results',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('results')) {
    final v = json['results'];
    if (v != null) {
      if (v is! Map) {
        issues.add(
          EasyIssue(
            path: 'results',
            code: 'type_mismatch',
            message: 'Expected Map for PageResponse.',
          ),
        );
      } else {
        for (final n0 in pageResponseValidate<User>(
          Map<String, dynamic>.from(v),
          validateT: (Object? e0) {
            final issues = <EasyIssue>[];
            {
              final x1 = e0;
              if (x1 == null) {
                issues.add(
                  EasyIssue(
                    path: '',
                    code: 'null_not_allowed',
                    message: 'Null value not allowed.',
                  ),
                );
              } else {
                if (x1 is! Map) {
                  issues.add(
                    EasyIssue(
                      path: '',
                      code: 'type_mismatch',
                      message: 'Expected Map for User.',
                    ),
                  );
                } else {
                  for (final n1 in userValidate(
                    Map<String, dynamic>.from(x1),
                  )) {
                    issues.add(
                      EasyIssue(
                        path: '' + '.' + n1.path,
                        code: n1.code,
                        message: n1.message,
                      ),
                    );
                  }
                }
              }
            }
            return issues;
          },
        )) {
          issues.add(
            EasyIssue(
              path: 'results' + '.' + n0.path,
              code: n0.code,
              message: n0.message,
            ),
          );
        }
      }
    }
  }
  if (!json.containsKey('byTeam')) {
    issues.add(
      EasyIssue(
        path: 'byTeam',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('byTeam') && json['byTeam'] == null) {
    issues.add(
      EasyIssue(
        path: 'byTeam',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('byTeam')) {
    final v = json['byTeam'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(
          path: 'byTeam',
          code: 'type_mismatch',
          message: 'Expected Map.',
        ),
      );
    } else if (v is Map) {
      for (final e in v.entries) {
        {
          final x0 = e.value;
          if (x0 == null) {
            issues.add(
              EasyIssue(
                path: 'byTeam' + '.' + e.key.toString(),
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
          } else {
            if (x0 is! List) {
              issues.add(
                EasyIssue(
                  path: 'byTeam' + '.' + e.key.toString(),
                  code: 'type_mismatch',
                  message: 'Expected List.',
                ),
              );
            } else {
              for (var i0 = 0; i0 < x0.length; i0++) {
                {
                  final x1 = x0[i0];
                  if (x1 == null) {
                    issues.add(
                      EasyIssue(
                        path:
                            'byTeam' +
                            '.' +
                            e.key.toString() +
                            '[' +
                            i0.toString() +
                            ']',
                        code: 'null_not_allowed',
                        message: 'Null value not allowed.',
                      ),
                    );
                  } else {
                    if (x1 is! Map) {
                      issues.add(
                        EasyIssue(
                          path:
                              'byTeam' +
                              '.' +
                              e.key.toString() +
                              '[' +
                              i0.toString() +
                              ']',
                          code: 'type_mismatch',
                          message: 'Expected Map for User.',
                        ),
                      );
                    } else {
                      for (final n1 in userValidate(
                        Map<String, dynamic>.from(x1),
                      )) {
                        issues.add(
                          EasyIssue(
                            path:
                                'byTeam' +
                                '.' +
                                e.key.toString() +
                                '[' +
                                i0.toString() +
                                ']' +
                                '.' +
                                n1.path,
                            code: n1.code,
                            message: n1.message,
                          ),
                        );
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  return issues;
}

UserSearch userSearchFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in userSearchValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => UserSearch(
    results: (() {
      final x0 = json['results'];
      if (x0 == null)
        return pageResponseFromJsonSafe<User>(
          const <String, dynamic>{},
          (Object? e0) => ((void Function(EasyIssue)? onIssue) => (() {
            final x1 = e0;
            if (x1 == null) {
              onIssue?.call(
                EasyIssue(
                  path: 'results',
                  code: 'null_not_allowed',
                  message: 'Null value not allowed.',
                ),
              );
              return userFromJsonSafe(
                const <String, dynamic>{},
                onIssue: (n1) => onIssue?.call(
                  EasyIssue(
                    path: 'results' + '.' + n1.path,
                    code: n1.code,
                    message: n1.message,
                  ),
                ),
                runValidate: false,
              );
            }
            if (x1 is! Map) {
              onIssue?.call(
                EasyIssue(
                  path: 'results',
                  code: 'type_mismatch',
                  message: 'Expected Map for User.',
                ),
              );
              return userFromJsonSafe(
                const <String, dynamic>{},
                onIssue: (n1) => onIssue?.call(
                  EasyIssue(
                    path: 'results' + '.' + n1.path,
                    code: n1.code,
                    message: n1.message,
                  ),
                ),
                runValidate: false,
              );
            }
            return userFromJsonSafe(
              Map<String, dynamic>.from(x1),
              onIssue: (n1) => onIssue?.call(
                EasyIssue(
                  path: 'results' + '.' + n1.path,
                  code: n1.code,
                  message: n1.message,
                ),
              ),
              runValidate: false,
            );
          })())(null),
          onIssue: (n0) => onIssue?.call(
            EasyIssue(
              path: 'results' + '.' + n0.path,
              code: n0.code,
              message: n0.message,
            ),
          ),
          runValidate: false,
        );
      if (x0 is! Map) {
        onIssue?.call(
          EasyIssue(
            path: 'results',
            code: 'type_mismatch',
            message: 'Expected Map for PageResponse.',
          ),
        );
        return pageResponseFromJsonSafe<User>(
          const <String, dynamic>{},
          (Object? e0) => ((void Function(EasyIssue)? onIssue) => (() {
            final x1 = e0;
            if (x1 == null) {
              onIssue?.call(
                EasyIssue(
                  path: 'results',
                  code: 'null_not_allowed',
                  message: 'Null value not allowed.',
                ),
              );
              return userFromJsonSafe(
                const <String, dynamic>{},
                onIssue: (n1) => onIssue?.call(
                  EasyIssue(
                    path: 'results' + '.' + n1.path,
                    code: n1.code,
                    message: n1.message,
                  ),
                ),
                runValidate: false,
              );
            }
            if (x1 is! Map) {
              onIssue?.call(
                EasyIssue(
                  path: 'results',
                  code: 'type_mismatch',
                  message: 'Expected Map for User.',
                ),
              );
              return userFromJsonSafe(
                const <String, dynamic>{},
                onIssue: (n1) => onIssue?.call(
                  EasyIssue(
                    path: 'results' + '.' + n1.path,
                    code: n1.code,
                    message: n1.message,
                  ),
                ),
                runValidate: false,
              );
            }
            return userFromJsonSafe(
              Map<String, dynamic>.from(x1),
              onIssue: (n1) => onIssue?.call(
                EasyIssue(
                  path: 'results' + '.' + n1.path,
                  code: n1.code,
                  message: n1.message,
                ),
              ),
              runValidate: false,
            );
          })())(null),
          onIssue: (n0) => onIssue?.call(
            EasyIssue(
              path: 'results' + '.' + n0.path,
              code: n0.code,
              message: n0.message,
            ),
          ),
          runValidate: false,
        );
      }
      return pageResponseFromJsonSafe<User>(
        Map<String, dynamic>.from(x0),
        (Object? e0) => ((void Function(EasyIssue)? onIssue) => (() {
          final x1 = e0;
          if (x1 == null) {
            onIssue?.call(
              EasyIssue(
                path: 'results',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return userFromJsonSafe(
              const <String, dynamic>{},
              onIssue: (n1) => onIssue?.call(
                EasyIssue(
                  path: 'results' + '.' + n1.path,
                  code: n1.code,
                  message: n1.message,
                ),
              ),
              runValidate: false,
            );
          }
          if (x1 is! Map) {
            onIssue?.call(
              EasyIssue(
                path: 'results',
                code: 'type_mismatch',
                message: 'Expected Map for User.',
              ),
            );
            return userFromJsonSafe(
              const <String, dynamic>{},
              onIssue: (n1) => onIssue?.call(
                EasyIssue(
                  path: 'results' + '.' + n1.path,
                  code: n1.code,
                  message: n1.message,
                ),
              ),
              runValidate: false,
            );
          }
          return userFromJsonSafe(
            Map<String, dynamic>.from(x1),
            onIssue: (n1) => onIssue?.call(
              EasyIssue(
                path: 'results' + '.' + n1.path,
                code: n1.code,
                message: n1.message,
              ),
            ),
            runValidate: false,
          );
        })())(null),
        onIssue: (n0) => onIssue?.call(
          EasyIssue(
            path: 'results' + '.' + n0.path,
            code: n0.code,
            message: n0.message,
          ),
        ),
        runValidate: false,
      );
    })(),
    byTeam: (() {
      final _v = json['byTeam'];
      if (_v is! Map) return const <String, List<User>>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <String, List<User>>{};
      for (final entry in _mapRaw.entries) {
        final k = (entry.key is String) ? entry.key : (entry.key?.toString());
        if (k == null) {
          onIssue?.call(
            EasyIssue(
              path: 'byTeam' + '.' + entry.key.toString(),
              code: 'key_type_mismatch',
              message: 'Incompatible key type for map.',
            ),
          );
          continue;
        }
        final v = (() {
          final x0 = entry.value;
          if (x0 == null) {
            onIssue?.call(
              EasyIssue(
                path: 'byTeam' + '.' + k.toString(),
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return <User>[];
          }
          if (x0 is! List) {
            onIssue?.call(
              EasyIssue(
                path: 'byTeam' + '.' + k.toString(),
                code: 'type_mismatch',
                message: 'Expected List.',
              ),
            );
            return <User>[];
          }
          return <User>[
            for (var i0 = 0; i0 < x0.length; i0++)
              (() {
                final x1 = x0[i0];
                if (x1 == null) {
                  onIssue?.call(
                    EasyIssue(
                      path:
                          'byTeam' +
                          '.' +
                          k.toString() +
                          '[' +
                          i0.toString() +
                          ']',
                      code: 'null_not_allowed',
                      message: 'Null value not allowed.',
                    ),
                  );
                  return userFromJsonSafe(
                    const <String, dynamic>{},
                    onIssue: (n1) => onIssue?.call(
                      EasyIssue(
                        path:
                            'byTeam' +
                            '.' +
                            k.toString() +
                            '[' +
                            i0.toString() +
                            ']' +
                            '.' +
                            n1.path,
                        code: n1.code,
                        message: n1.message,
                      ),
                    ),
                    runValidate: false,
                  );
                }
                if (x1 is! Map) {
                  onIssue?.call(
                    EasyIssue(
                      path:
                          'byTeam' +
                          '.' +
                          k.toString() +
                          '[' +
                          i0.toString() +
                          ']',
                      code: 'type_mismatch',
                      message: 'Expected Map for User.',
                    ),
                  );
                  return userFromJsonSafe(
                    const <String, dynamic>{},
                    onIssue: (n1) => onIssue?.call(
                      EasyIssue(
                        path:
                            'byTeam' +
                            '.' +
                            k.toString() +
                            '[' +
                            i0.toString() +
                            ']' +
                            '.' +
                            n1.path,
                        code: n1.code,
                        message: n1.message,
                      ),
                    ),
                    runValidate: false,
                  );
                }
                return userFromJsonSafe(
                  Map<String, dynamic>.from(x1),
                  onIssue: (n1) => onIssue?.call(
                    EasyIssue(
                      path:
                          'byTeam' +
                          '.' +
                          k.toString() +
                          '[' +
                          i0.toString() +
                          ']' +
                          '.' +
                          n1.path,
                      code: n1.code,
                      message: n1.message,
                    ),
                  ),
                  runValidate: false,
                );
              })(),
          ];
        })();
        _out[k] = v;
      }
      return _out;
    })(),
  ))(_report);
}

class UserSearchJson {
  const UserSearchJson();

  static UserSearch fromJson(Map<String, dynamic> json) {
    return userSearchFromJson(json);
  }

  static UserSearch fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return userSearchFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return userSearchValidate(json);
  }
}

List<UserSearch> userSearchFromJsonList(List<dynamic> json) =>
    json.map((e) => userSearchFromJson(e as Map<String, dynamic>)).toList();

List<UserSearch> userSearchFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => userSearchFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> userSearchToJsonList(List<UserSearch> items) =>
    items.map((e) => userSearchToJson(e)).toList();

UserPage userPageFromJson(Map<String, dynamic> json) {
  return UserPage(
    items:
        ((json['items'] as List?)?.asMap().entries.map<User>((entry) {
          final i = entry.key;
          final e = entry.value;
          return userFromJson(Map<String, dynamic>.from(e as Map));
        }).toList()) ??
        const <User>[],
  );
}

Map<String, dynamic> userPageToJson(UserPage instance) {
  return <String, dynamic>{
    'items': instance.items.map((e) => e.toJson()).toList(),
  };
}

mixin UserPageSerializer {
  Map<String, dynamic> toJson() {
    return userPageToJson(this as UserPage);
  }
}

List<EasyIssue> userPageValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('items')) {
    issues.add(
      EasyIssue(
        path: 'items',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('items') && json['items'] == null) {
    issues.add(
      EasyIssue(
        path: 'items',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('items')) {
    final v = json['items'];
    if (v != null && v is! List) {
      issues.add(
        EasyIssue(
          path: 'items',
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
              path: 'items' + '[' + i.toString() + ']',
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else {
          if (e is! Map) {
            issues.add(
              EasyIssue(
                path: 'items' + '[' + i.toString() + ']',
                code: 'type_mismatch',
                message: 'Expected Map for User.',
              ),
            );
          } else {
            final child = userValidate(Map<String, dynamic>.from(e as Map));
            for (final ci in child) {
              issues.add(
                EasyIssue(
                  path: 'items' + '[' + i.toString() + '].' + ci.path,
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
  return issues;
}

UserPage userPageFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in userPageValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => UserPage(
    items: (() {
      final _v = json['items'];
      if (_v is! List) return const <User>[];
      final _list = _v;
      return _list.asMap().entries.map<User>((entry) {
        final idx = entry.key;
        final elem = entry.value;
        return (() {
          final _v = entry.value;
          if (_v == null) {
            onIssue?.call(
              EasyIssue(
                path: 'items' + '[' + entry.key.toString() + ']',
                code: 'null_not_allowed',
                message: 'Null value not allowed.',
              ),
            );
            return userFromJsonSafe(
              const <String, dynamic>{},
              onIssue: (i) => onIssue?.call(
                EasyIssue(
                  path:
                      'items' + '[' + entry.key.toString() + ']' + '.' + i.path,
                  code: i.code,
                  message: i.message,
                ),
              ),
              runValidate: false,
            );
          }
          if (_v is Map) {
            return userFromJsonSafe(
              Map<String, dynamic>.from(_v as Map),
              onIssue: (i) => onIssue?.call(
                EasyIssue(
                  path:
                      'items' + '[' + entry.key.toString() + ']' + '.' + i.path,
                  code: i.code,
                  message: i.message,
                ),
              ),
              runValidate: false,
            );
          }
          onIssue?.call(
            EasyIssue(
              path: 'items' + '[' + entry.key.toString() + ']',
              code: 'type_mismatch',
              message: 'Expected Map for User.',
            ),
          );
          return userFromJsonSafe(
            const <String, dynamic>{},
            onIssue: (i) => onIssue?.call(
              EasyIssue(
                path: "'items' + '[' + entry.key.toString() + ']'." + i.path,
                code: i.code,
                message: i.message,
              ),
            ),
            runValidate: false,
          );
        })();
      }).toList();
    })(),
  ))(_report);
}

class UserPageJson {
  const UserPageJson();

  static UserPage fromJson(Map<String, dynamic> json) {
    return userPageFromJson(json);
  }

  static UserPage fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return userPageFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return userPageValidate(json);
  }
}

List<UserPage> userPageFromJsonList(List<dynamic> json) =>
    json.map((e) => userPageFromJson(e as Map<String, dynamic>)).toList();

List<UserPage> userPageFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => userPageFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> userPageToJsonList(List<UserPage> items) =>
    items.map((e) => userPageToJson(e)).toList();

Post postFromJson(Map<String, dynamic> json) {
  final d = json['type'];
  switch (d) {
    case 'text':
      return TextPost.fromJson(json);
    case 'video':
      return VideoPost.fromJson(json);
    default:
      return UnknownPost.fromJson(json);
  }
}

Map<String, dynamic> postToJson(Post instance) {
  return (instance as dynamic).toJson() as Map<String, dynamic>;
}

mixin PostSerializer {
  Map<String, dynamic> toJson() {
    return postToJson(this as Post);
  }
}

List<EasyIssue> postValidate(Map<String, dynamic> json) {
  final d = json['type'];
  switch (d) {
    case 'text':
      return textPostValidate(json);
    case 'video':
      return videoPostValidate(json);
    default:
      final issues = [
        EasyIssue(
          path: 'type',
          code: 'unknown_union_type',
          message: 'Unknown type: \$d',
        ),
      ];
      issues.addAll(unknownPostValidate(json));
      return issues;
  }
}

Post postFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in postValidate(json)) _report(i);
  }
  final d = json['type'];
  switch (d) {
    case 'text':
      return textPostFromJsonSafe(json, onIssue: _report, runValidate: false);
    case 'video':
      return videoPostFromJsonSafe(json, onIssue: _report, runValidate: false);
    default:
      return unknownPostFromJsonSafe(
        json,
        onIssue: _report,
        runValidate: false,
      );
  }
}

class PostJson {
  const PostJson();

  static Post fromJson(Map<String, dynamic> json) {
    return postFromJson(json);
  }

  static Post fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return postFromJsonSafe(json, onIssue: onIssue, runValidate: runValidate);
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return postValidate(json);
  }
}

List<Post> postFromJsonList(List<dynamic> json) =>
    json.map((e) => postFromJson(e as Map<String, dynamic>)).toList();

List<Post> postFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => postFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> postToJsonList(List<Post> items) =>
    items.map((e) => postToJson(e)).toList();

TextPost textPostFromJson(Map<String, dynamic> json) {
  return TextPost(content: (json['content'] as String?) ?? '');
}

Map<String, dynamic> textPostToJson(TextPost instance) {
  return <String, dynamic>{'content': instance.content};
}

mixin TextPostSerializer {
  Map<String, dynamic> toJson() {
    return textPostToJson(this as TextPost);
  }
}

List<EasyIssue> textPostValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('content')) {
    issues.add(
      EasyIssue(
        path: 'content',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('content') && json['content'] == null) {
    issues.add(
      EasyIssue(
        path: 'content',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('content')) {
    final v = json['content'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'content',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  return issues;
}

TextPost textPostFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in textPostValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => TextPost(
    content: (() {
      final v = json['content'];
      return (v is String) ? v : '';
    })(),
  ))(_report);
}

class TextPostJson {
  const TextPostJson();

  static TextPost fromJson(Map<String, dynamic> json) {
    return textPostFromJson(json);
  }

  static TextPost fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return textPostFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return textPostValidate(json);
  }
}

List<TextPost> textPostFromJsonList(List<dynamic> json) =>
    json.map((e) => textPostFromJson(e as Map<String, dynamic>)).toList();

List<TextPost> textPostFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => textPostFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> textPostToJsonList(List<TextPost> items) =>
    items.map((e) => textPostToJson(e)).toList();

VideoPost videoPostFromJson(Map<String, dynamic> json) {
  return VideoPost(url: (json['url'] as String?) ?? '');
}

Map<String, dynamic> videoPostToJson(VideoPost instance) {
  return <String, dynamic>{'url': instance.url};
}

mixin VideoPostSerializer {
  Map<String, dynamic> toJson() {
    return videoPostToJson(this as VideoPost);
  }
}

List<EasyIssue> videoPostValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('url')) {
    issues.add(
      EasyIssue(
        path: 'url',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('url') && json['url'] == null) {
    issues.add(
      EasyIssue(
        path: 'url',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('url')) {
    final v = json['url'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'url',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  return issues;
}

VideoPost videoPostFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in videoPostValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => VideoPost(
    url: (() {
      final v = json['url'];
      return (v is String) ? v : '';
    })(),
  ))(_report);
}

class VideoPostJson {
  const VideoPostJson();

  static VideoPost fromJson(Map<String, dynamic> json) {
    return videoPostFromJson(json);
  }

  static VideoPost fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return videoPostFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return videoPostValidate(json);
  }
}

List<VideoPost> videoPostFromJsonList(List<dynamic> json) =>
    json.map((e) => videoPostFromJson(e as Map<String, dynamic>)).toList();

List<VideoPost> videoPostFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => videoPostFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> videoPostToJsonList(List<VideoPost> items) =>
    items.map((e) => videoPostToJson(e)).toList();

UnknownPost unknownPostFromJson(Map<String, dynamic> json) {
  return UnknownPost();
}

Map<String, dynamic> unknownPostToJson(UnknownPost instance) {
  return <String, dynamic>{};
}

mixin UnknownPostSerializer {
  Map<String, dynamic> toJson() {
    return unknownPostToJson(this as UnknownPost);
  }
}

List<EasyIssue> unknownPostValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  return issues;
}

UnknownPost unknownPostFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in unknownPostValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => UnknownPost())(_report);
}

class UnknownPostJson {
  const UnknownPostJson();

  static UnknownPost fromJson(Map<String, dynamic> json) {
    return unknownPostFromJson(json);
  }

  static UnknownPost fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return unknownPostFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return unknownPostValidate(json);
  }
}

List<UnknownPost> unknownPostFromJsonList(List<dynamic> json) =>
    json.map((e) => unknownPostFromJson(e as Map<String, dynamic>)).toList();

List<UnknownPost> unknownPostFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => unknownPostFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> unknownPostToJsonList(List<UnknownPost> items) =>
    items.map((e) => unknownPostToJson(e)).toList();

Order orderFromJson(Map<String, dynamic> json) {
  return Order(
    id: (json['_id'] as String?) ?? '',
    customerName: (json['customer_name'] as String?) ?? '',
    city:
        (((json['shipping'] as Map?)?['address'] as Map?)?['city']
            as String?) ??
        '',
    createdAt: EpochMs.fromJson(json['created_at']),
    quantities: (Map<dynamic, dynamic>.from(json['quantities'] as Map)).entries
        .fold<Map<int, int>>(<int, int>{}, (acc, entry) {
          final k = (entry.key is int
              ? (entry.key as int)
              : (entry.key is num
                    ? (entry.key as num).toInt()
                    : int.parse(entry.key as String)));
          final v = (entry.value as int?) ?? 0;
          acc[k] = v;
          return acc;
        }),
  );
}

Map<String, dynamic> orderToJson(Order instance) {
  final json = <String, dynamic>{
    '_id': instance.id,
    'customer_name': instance.customerName,
    'created_at': EpochMs.toJson(instance.createdAt),
    'quantities': instance.quantities.map((k, v) => MapEntry(k.toString(), v)),
  };
  ej.writePath(json, const ['shipping', 'address', 'city'], instance.city);
  return json;
}

mixin OrderSerializer {
  Map<String, dynamic> toJson() {
    return orderToJson(this as Order);
  }
}

List<EasyIssue> orderValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('_id')) {
    issues.add(
      EasyIssue(
        path: '_id',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('_id') && json['_id'] == null) {
    issues.add(
      EasyIssue(
        path: '_id',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('_id')) {
    final v = json['_id'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: '_id',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  if (!json.containsKey('customer_name')) {
    issues.add(
      EasyIssue(
        path: 'customer_name',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('customer_name') && json['customer_name'] == null) {
    issues.add(
      EasyIssue(
        path: 'customer_name',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('customer_name')) {
    final v = json['customer_name'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'customer_name',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  {
    final v = ((json['shipping'] as Map?)?['address'] as Map?)?['city'];
    if (v == null) {
      issues.add(
        EasyIssue(
          path: 'shipping.address.city',
          code: 'missing_required',
          message: 'Missing required field.',
        ),
      );
    }
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'shipping.address.city',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  if (!json.containsKey('quantities')) {
    issues.add(
      EasyIssue(
        path: 'quantities',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('quantities') && json['quantities'] == null) {
    issues.add(
      EasyIssue(
        path: 'quantities',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('quantities')) {
    final v = json['quantities'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(
          path: 'quantities',
          code: 'type_mismatch',
          message: 'Expected Map.',
        ),
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
              path: 'quantities' + '.' + k.toString(),
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
              path: 'quantities' + '.' + e.key.toString(),
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else if (val is! int) {
          issues.add(
            EasyIssue(
              path: 'quantities' + '.' + e.key.toString(),
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

Order orderFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in orderValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Order(
    id: (() {
      final v = json['_id'];
      return (v is String) ? v : '';
    })(),
    customerName: (() {
      final v = json['customer_name'];
      return (v is String) ? v : '';
    })(),
    city: (() {
      final v = ((json['shipping'] as Map?)?['address'] as Map?)?['city'];
      return (v is String) ? v : '';
    })(),
    createdAt: (() {
      try {
        // Tenta usar o conversor TmDateMs
        return EpochMs.fromJson(json['created_at']);
      } catch (e) {
        // TmDateMs falhou (ex: veio String mas ele queria int).
        // Em vez de falhar, tenta a lógica nativa robusta!
        return (() {
          final v = json['created_at'];
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
                  path: 'created_at',
                  code: 'type_mismatch',
                  message: 'Invalid DateTime format.',
                ),
              );
              return DateTime.fromMillisecondsSinceEpoch(0);
            }
          }
          onIssue?.call(
            EasyIssue(
              path: 'created_at',
              code: 'type_mismatch',
              message: 'Expected String/epoch/DateTime.',
            ),
          );
          return DateTime.fromMillisecondsSinceEpoch(0);
        })();
      }
    })(),
    quantities: (() {
      final _v = json['quantities'];
      if (_v is! Map) return const <int, int>{};
      final _mapRaw = Map<dynamic, dynamic>.from(_v as Map);
      final _out = <int, int>{};
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
              path: 'quantities' + '.' + entry.key.toString(),
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
  ))(_report);
}

class OrderJson {
  const OrderJson();

  static Order fromJson(Map<String, dynamic> json) {
    return orderFromJson(json);
  }

  static Order fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return orderFromJsonSafe(json, onIssue: onIssue, runValidate: runValidate);
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return orderValidate(json);
  }
}

List<Order> orderFromJsonList(List<dynamic> json) =>
    json.map((e) => orderFromJson(e as Map<String, dynamic>)).toList();

List<Order> orderFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => orderFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> orderToJsonList(List<Order> items) =>
    items.map((e) => orderToJson(e)).toList();

UserModel userModelFromJson(Map<String, dynamic> json) {
  return UserModel(emailAddress: (json['email_address'] as String?) ?? '');
}

Map<String, dynamic> userModelToJson(UserModel instance) {
  return <String, dynamic>{'email_address': instance.emailAddress};
}

mixin UserModelSerializer {
  Map<String, dynamic> toJson() {
    return userModelToJson(this as UserModel);
  }
}

List<EasyIssue> userModelValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('email_address')) {
    issues.add(
      EasyIssue(
        path: 'email_address',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('email_address') && json['email_address'] == null) {
    issues.add(
      EasyIssue(
        path: 'email_address',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('email_address')) {
    final v = json['email_address'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'email_address',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  return issues;
}

UserModel userModelFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in userModelValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => UserModel(
    emailAddress: (() {
      final v = json['email_address'];
      return (v is String) ? v : '';
    })(),
  ))(_report);
}

class UserModelJson {
  const UserModelJson();

  static UserModel fromJson(Map<String, dynamic> json) {
    return userModelFromJson(json);
  }

  static UserModel fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return userModelFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return userModelValidate(json);
  }
}

List<UserModel> userModelFromJsonList(List<dynamic> json) =>
    json.map((e) => userModelFromJson(e as Map<String, dynamic>)).toList();

List<UserModel> userModelFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => userModelFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> userModelToJsonList(List<UserModel> items) =>
    items.map((e) => userModelToJson(e)).toList();

LoginResponse loginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse(token: (json['token'] as String?) ?? '');
}

List<EasyIssue> loginResponseValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('token')) {
    issues.add(
      EasyIssue(
        path: 'token',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('token') && json['token'] == null) {
    issues.add(
      EasyIssue(
        path: 'token',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('token')) {
    final v = json['token'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'token',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {}
  }
  return issues;
}

LoginResponse loginResponseFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in loginResponseValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => LoginResponse(
    token: (() {
      final v = json['token'];
      return (v is String) ? v : '';
    })(),
  ))(_report);
}

class LoginResponseJson {
  const LoginResponseJson();

  static LoginResponse fromJson(Map<String, dynamic> json) {
    return loginResponseFromJson(json);
  }

  static LoginResponse fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return loginResponseFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return loginResponseValidate(json);
  }
}

List<LoginResponse> loginResponseFromJsonList(List<dynamic> json) =>
    json.map((e) => loginResponseFromJson(e as Map<String, dynamic>)).toList();

List<LoginResponse> loginResponseFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => loginResponseFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

Map<String, dynamic> loginRequestToJson(LoginRequest instance) {
  return <String, dynamic>{
    'user': instance.user,
    'password': instance.password,
  };
}

mixin LoginRequestSerializer {
  Map<String, dynamic> toJson() {
    return loginRequestToJson(this as LoginRequest);
  }
}

List<Map<String, dynamic>> loginRequestToJsonList(List<LoginRequest> items) =>
    items.map((e) => loginRequestToJson(e)).toList();

Account accountFromJson(Map<String, dynamic> json) {
  return Account(
    username: (json['username'] as String?) ?? '',
    email: (json['email'] as String?) ?? '',
    age: (json['age'] as int?) ?? 0,
    birthDate: ej.parseDateTime(json['birthDate']),
    luckyNumber: (json['luckyNumber'] as int?) ?? 0,
  );
}

Map<String, dynamic> accountToJson(Account instance) {
  return <String, dynamic>{
    'username': instance.username,
    'email': instance.email,
    'age': instance.age,
    'birthDate': instance.birthDate.toIso8601String(),
    'luckyNumber': instance.luckyNumber,
  };
}

mixin AccountSerializer {
  Map<String, dynamic> toJson() {
    return accountToJson(this as Account);
  }
}

List<EasyIssue> accountValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('username')) {
    issues.add(
      EasyIssue(
        path: 'username',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('username') && json['username'] == null) {
    issues.add(
      EasyIssue(
        path: 'username',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('username')) {
    final v = json['username'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'username',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {
      if (v.length < 3) {
        issues.add(
          EasyIssue(
            path: 'username',
            code: 'min_length',
            message: 'Must have at least 3 characters.',
          ),
        );
      }
      if (v.length > 20) {
        issues.add(
          EasyIssue(
            path: 'username',
            code: 'max_length',
            message: 'Must have at most 20 characters.',
          ),
        );
      }
      if (!RegExp('^[a-z0-9_]+\$').hasMatch(v as String)) {
        issues.add(
          EasyIssue(
            path: 'username',
            code: 'regex_mismatch',
            message: 'Invalid format.',
          ),
        );
      }
    }
  }
  if (!json.containsKey('email')) {
    issues.add(
      EasyIssue(
        path: 'email',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('email') && json['email'] == null) {
    issues.add(
      EasyIssue(
        path: 'email',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('email')) {
    final v = json['email'];
    if (v != null && v is! String) {
      issues.add(
        EasyIssue(
          path: 'email',
          code: 'type_mismatch',
          message: 'Expected String.',
        ),
      );
    } else if (v != null) {
      if (!RegExp(
        '^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$',
      ).hasMatch(v as String)) {
        issues.add(
          EasyIssue(
            path: 'email',
            code: 'invalid_email',
            message: 'Invalid email.',
          ),
        );
      }
    }
  }
  if (!json.containsKey('age')) {
    issues.add(
      EasyIssue(
        path: 'age',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('age') && json['age'] == null) {
    issues.add(
      EasyIssue(
        path: 'age',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('age')) {
    final v = json['age'];
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'age',
            code: 'type_mismatch',
            message: 'Expected int.',
          ),
        );
      } else {
        final v = _n;
        if ((v as num) < 18) {
          issues.add(
            EasyIssue(
              path: 'age',
              code: 'min_value',
              message: 'The minimum value is 18.',
            ),
          );
        }
        if ((v as num) > 120) {
          issues.add(
            EasyIssue(
              path: 'age',
              code: 'max_value',
              message: 'The maximum value is 120.',
            ),
          );
        }
      }
    }
  }
  if (!json.containsKey('birthDate')) {
    issues.add(
      EasyIssue(
        path: 'birthDate',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('birthDate') && json['birthDate'] == null) {
    issues.add(
      EasyIssue(
        path: 'birthDate',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('birthDate')) {
    final v = json['birthDate'];
    if (v != null && v is! String && v is! num && v is! DateTime) {
      issues.add(
        EasyIssue(
          path: 'birthDate',
          code: 'type_mismatch',
          message: 'Expected String (ISO), num or DateTime.',
        ),
      );
    } else if (v is String) {
      if (DateTime.tryParse(v) == null) {
        issues.add(
          EasyIssue(
            path: 'birthDate',
            code: 'type_mismatch',
            message: 'Invalid ISO format.',
          ),
        );
      } else {
        final dt = DateTime.parse(v);
        if (dt.isAfter(DateTime.now())) {
          issues.add(
            EasyIssue(
              path: 'birthDate',
              code: 'must_be_past',
              message: 'The date must be in the past.',
            ),
          );
        }
      }
    }
  }
  if (!json.containsKey('luckyNumber')) {
    issues.add(
      EasyIssue(
        path: 'luckyNumber',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('luckyNumber') && json['luckyNumber'] == null) {
    issues.add(
      EasyIssue(
        path: 'luckyNumber',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('luckyNumber')) {
    final v = json['luckyNumber'];
    if (v != null) {
      final _n = v is int ? v : (v is String ? int.tryParse(v) : null);
      if (_n == null) {
        issues.add(
          EasyIssue(
            path: 'luckyNumber',
            code: 'type_mismatch',
            message: 'Expected int.',
          ),
        );
      } else {
        final v = _n;
        if (!(Rules.isEven(v as int))) {
          issues.add(
            EasyIssue(
              path: 'luckyNumber',
              code: 'custom_validation_failed',
              message: 'Custom validation failed.',
            ),
          );
        }
      }
    }
  }
  return issues;
}

Account accountFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in accountValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => Account(
    username: (() {
      final v = json['username'];
      return (v is String) ? v : '';
    })(),
    email: (() {
      final v = json['email'];
      return (v is String) ? v : '';
    })(),
    age: (() {
      final v = json['age'];
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) {
        final p = int.tryParse(v);
        if (p != null) return p;
      }
      return 0;
    })(),
    birthDate: (() {
      final v = json['birthDate'];
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
              path: 'birthDate',
              code: 'type_mismatch',
              message: 'Invalid DateTime format.',
            ),
          );
          return DateTime.fromMillisecondsSinceEpoch(0);
        }
      }
      onIssue?.call(
        EasyIssue(
          path: 'birthDate',
          code: 'type_mismatch',
          message: 'Expected String/epoch/DateTime.',
        ),
      );
      return DateTime.fromMillisecondsSinceEpoch(0);
    })(),
    luckyNumber: (() {
      final v = json['luckyNumber'];
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

class AccountJson {
  const AccountJson();

  static Account fromJson(Map<String, dynamic> json) {
    return accountFromJson(json);
  }

  static Account fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return accountFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return accountValidate(json);
  }
}

List<Account> accountFromJsonList(List<dynamic> json) =>
    json.map((e) => accountFromJson(e as Map<String, dynamic>)).toList();

List<Account> accountFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => accountFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> accountToJsonList(List<Account> items) =>
    items.map((e) => accountToJson(e)).toList();

IntKeyed intKeyedFromJson(Map<String, dynamic> json) {
  return IntKeyed(
    names: (Map<dynamic, dynamic>.from(json['names'] as Map)).entries
        .fold<Map<int, String>>(<int, String>{}, (acc, entry) {
          final k = (entry.key is int
              ? (entry.key as int)
              : (entry.key is num
                    ? (entry.key as num).toInt()
                    : int.parse(entry.key as String)));
          final v = (entry.value as String?) ?? '';
          acc[k] = v;
          return acc;
        }),
  );
}

Map<String, dynamic> intKeyedToJson(IntKeyed instance) {
  return <String, dynamic>{
    'names': instance.names.map((k, v) => MapEntry(k.toString(), v)),
  };
}

mixin IntKeyedSerializer {
  Map<String, dynamic> toJson() {
    return intKeyedToJson(this as IntKeyed);
  }
}

List<EasyIssue> intKeyedValidate(Map<String, dynamic> json) {
  final issues = <EasyIssue>[];
  if (!json.containsKey('names')) {
    issues.add(
      EasyIssue(
        path: 'names',
        code: 'missing_required',
        message: 'Missing required field.',
      ),
    );
  }
  if (json.containsKey('names') && json['names'] == null) {
    issues.add(
      EasyIssue(
        path: 'names',
        code: 'null_not_allowed',
        message: 'Null value not allowed.',
      ),
    );
  }
  if (json.containsKey('names')) {
    final v = json['names'];
    if (v != null && v is! Map) {
      issues.add(
        EasyIssue(
          path: 'names',
          code: 'type_mismatch',
          message: 'Expected Map.',
        ),
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
              path: 'names' + '.' + k.toString(),
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
              path: 'names' + '.' + e.key.toString(),
              code: 'null_not_allowed',
              message: 'Null value not allowed.',
            ),
          );
        } else if (val is! String) {
          issues.add(
            EasyIssue(
              path: 'names' + '.' + e.key.toString(),
              code: 'type_mismatch',
              message: 'Expected String.',
            ),
          );
        }
      }
    }
  }
  return issues;
}

IntKeyed intKeyedFromJsonSafe(
  Map<String, dynamic> json, {
  void Function(EasyIssue)? onIssue,
  bool runValidate = true,
}) {
  // validate + parse podem apontar o mesmo problema: reporta uma vez só.
  final _report = ej.dedupeIssues(onIssue);
  if (runValidate && _report != null) {
    for (final i in intKeyedValidate(json)) _report(i);
  }
  return ((void Function(EasyIssue)? onIssue) => IntKeyed(
    names: (() {
      final _v = json['names'];
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
              path: 'names' + '.' + entry.key.toString(),
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
  ))(_report);
}

class IntKeyedJson {
  const IntKeyedJson();

  static IntKeyed fromJson(Map<String, dynamic> json) {
    return intKeyedFromJson(json);
  }

  static IntKeyed fromJsonSafe(
    Map<String, dynamic> json, {
    void Function(EasyIssue)? onIssue,
    bool runValidate = true,
  }) {
    return intKeyedFromJsonSafe(
      json,
      onIssue: onIssue,
      runValidate: runValidate,
    );
  }

  static List<EasyIssue> validate(Map<String, dynamic> json) {
    return intKeyedValidate(json);
  }
}

List<IntKeyed> intKeyedFromJsonList(List<dynamic> json) =>
    json.map((e) => intKeyedFromJson(e as Map<String, dynamic>)).toList();

List<IntKeyed> intKeyedFromJsonSafeList(
  List<dynamic> json, {
  void Function(int index, EasyIssue issue)? onIssue,
  bool runValidate = true,
}) => json
    .asMap()
    .entries
    .map(
      (entry) => intKeyedFromJsonSafe(
        entry.value as Map<String, dynamic>,
        onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
        runValidate: runValidate,
      ),
    )
    .toList();

List<Map<String, dynamic>> intKeyedToJsonList(List<IntKeyed> items) =>
    items.map((e) => intKeyedToJson(e)).toList();
