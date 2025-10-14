import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';

import 'annotations.dart';

final _easyKeyChecker = const TypeChecker.typeNamed(EasyKey);
final _easyJsonChecker = const TypeChecker.typeNamed(EasyJson);
final _easyConvertChecker = const TypeChecker.typeNamed(EasyConvert);
final _easyMapKeyChecker = const TypeChecker.typeNamed(EasyMapKey);
final _easyValidateChecker = const TypeChecker.typeNamed(EasyValidate);

class FieldContext {
  FieldContext({
    required this.enclosingClass,
    required this.element,
    required this.classIncludeIfNull,
    this.classCaseStyle,
  }) : name = element.displayName,
       type = element.type,
       isNullable = _isNullableType(element.type),
       jsonKey =
           _jsonKeyFor(element) ??
           _applyCaseStyle(element.displayName, classCaseStyle),
       includeIfNull = _includeIfNullFor(element),
       enumFallbackName = _easyKey(element)?.peek('enumFallback')?.stringValue,
       fieldFallback = _easyKey(element)?.peek('fallback')?.literalValue,
       itemFallback = _easyKey(element)?.peek('itemFallback')?.literalValue,
       mapKeyCoercion = _easyMapKey(element)
           ?.peek('type')
           ?.revive()
           .accessor
           .split('.')
           .last
           .let((s) => s == 'int' ? EasyMapKeyType.int : EasyMapKeyType.string),
       convertFromJson = _fnRefOrNull(_easyConvert(element), 'fromJson'),
       convertToJson = _fnRefOrNull(_easyConvert(element), 'toJson'),
       valueFromJson = _fnRefOrNull(_easyConvert(element), 'valueFromJson'),
       valueToJson = _fnRefOrNull(_easyConvert(element), 'valueToJson'),
       customValidatorFn = _fnRefOrNull(_easyValidate(element), 'custom'),
       validator = _easyValidate(element) {
    final it = type;
    if (it is InterfaceType) {
      if (isList) listItemType = it.typeArguments.first;
      if (isSet) setItemType = it.typeArguments.first;
      if (isMap) {
        mapKeyType = it.typeArguments.first;
        mapValueType = it.typeArguments.last;
      }
    }
  }

  final ClassElement enclosingClass;
  final FieldElement element;

  final String name;
  final DartType type;
  final bool isNullable;

  final String jsonKey;
  final bool classIncludeIfNull;
  final bool? includeIfNull;

  final Object? fieldFallback;
  final Object? itemFallback;
  final String? enumFallbackName;

  // conversions
  final String? convertFromJson;
  final String? convertToJson;
  final String? valueFromJson; // Map value
  final String? valueToJson; // Map value

  final EasyMapKeyType? mapKeyCoercion; // null => string (default)
  final CaseStyle? classCaseStyle;

  /// Dados da anotação `@EasyValidate`, se presente.
  final ConstantReader? validator;

  /// Referência à função de validação customizada, se presente.
  final String? customValidatorFn;

  // Derived collection info
  DartType? listItemType;
  DartType? setItemType;
  DartType? mapKeyType;
  DartType? mapValueType;

  // Queries
  bool get isEnum => type.element is EnumElement;
  bool get isEasyJsonObject =>
      type.element is ClassElement &&
      _easyJsonChecker.hasAnnotationOf(
        type.element as ClassElement,
        throwOnUnresolved: false,
      );
  bool get isList =>
      type is InterfaceType && (type as InterfaceType).element.name == 'List';
  bool get isSet =>
      type is InterfaceType && (type as InterfaceType).element.name == 'Set';
  bool get isMap =>
      type is InterfaceType && (type as InterfaceType).element.name == 'Map';

  bool get emitNulls => (includeIfNull ?? classIncludeIfNull) == true;

  String get instanceAccess => 'instance.$name';
  String get jsonAccessor => "json['$jsonKey']";
  String get pathExpr => "'$jsonKey'";

  // helpers
  static bool _isNullableType(DartType t) => t.getDisplayString().endsWith('?');

  static ConstantReader? _easyKey(FieldElement f) {
    final a = _easyKeyChecker.firstAnnotationOfExact(f);
    return a == null ? null : ConstantReader(a);
  }

  static ConstantReader? _easyConvert(FieldElement f) {
    final a = _easyConvertChecker.firstAnnotationOfExact(f);
    return a == null ? null : ConstantReader(a);
  }

  static ConstantReader? _easyMapKey(FieldElement f) {
    final a = _easyMapKeyChecker.firstAnnotationOfExact(f);
    return a == null ? null : ConstantReader(a);
  }

  static ConstantReader? _easyValidate(FieldElement f) {
    final a = _easyValidateChecker.firstAnnotationOfExact(f);
    return a == null ? null : ConstantReader(a);
  }

  static String? _jsonKeyFor(FieldElement f) =>
      _easyKey(f)?.peek('name')?.stringValue;
  static bool? _includeIfNullFor(FieldElement f) =>
      _easyKey(f)?.peek('includeIfNull')?.literalValue as bool?;

  static String? _fnRefOrNull(ConstantReader? ann, String key) {
    final v = ann?.peek(key);
    if (v == null) return null;
    final obj = v.objectValue;
    if (obj.isNull) return null;
    final revived = ConstantReader(obj).revive();
    return revived.accessor; // ex.: MyConv.fromJson
  }
}

extension _Let<T> on T {
  R let<R>(R Function(T) fn) => fn(this);
}

// ===== Utils de tipos =====
bool isExactlyDateTime(DartType t) =>
    TypeChecker.typeNamed(DateTime).isExactlyType(t);

String displayWithNull(DartType t) => t.getDisplayString();
String displayNonNull(DartType t) {
  final s = t.getDisplayString();
  return s.endsWith('?') ? s.substring(0, s.length - 1) : s;
}

bool isEasyJsonClass(DartType t) =>
    t.element is ClassElement &&
    _easyJsonChecker.hasAnnotationOf(
      t.element as ClassElement,
      throwOnUnresolved: false,
    );

bool isEnumType(DartType t) => t.element is EnumElement;

DartType? asSetItem(DartType t) {
  if (t is InterfaceType &&
      t.element.name == 'Set' &&
      t.typeArguments.length == 1) {
    return t.typeArguments.first;
  }
  return null;
}

({DartType? key, DartType? value}) asMapKV(DartType t) {
  if (t is InterfaceType &&
      t.element.name == 'Map' &&
      t.typeArguments.length == 2) {
    return (key: t.typeArguments[0], value: t.typeArguments[1]);
  }
  return (key: null, value: null);
}

String _applyCaseStyle(String name, CaseStyle? style) {
  if (style == null || style == CaseStyle.none) return name;

  final snakeish = name.replaceAllMapped(
    RegExp(r'([a-z0-9])([A-Z])'),
    (m) => '${m.group(1)}_${m.group(2)}',
  );
  final parts = snakeish
      .replaceAll('-', '_')
      .split('_')
      .where((p) => p.isNotEmpty)
      .toList();

  String cap(String s) =>
      s.isEmpty ? s : (s[0].toUpperCase() + s.substring(1).toLowerCase());
  String low(String s) => s.toLowerCase();

  switch (style) {
    case CaseStyle.snake:
      return parts.map(low).join('_');
    case CaseStyle.kebab:
      return parts.map(low).join('-');
    case CaseStyle.camel:
      return parts.isEmpty
          ? name
          : parts.first.toLowerCase() + parts.skip(1).map(cap).join();
    case CaseStyle.pascal:
      return parts.map(cap).join();
    case CaseStyle.none:
      return name;
  }
}
