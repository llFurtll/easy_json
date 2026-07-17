// ignore_for_file: experimental_member_use
import 'dart:async';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';

import 'annotations.dart';
import 'field_context.dart';
import 'strategies.dart';

const _issueImport = "package:dart_easy_json/src/easy_issue.dart";

final _easyConvertChecker = const TypeChecker.typeNamed(EasyConvert);
final _easyUnionChecker = const TypeChecker.typeNamed(EasyUnion);
final _easyValidateChecker = const TypeChecker.typeNamed(EasyValidate);

class EasyJsonGenerator extends Generator {
  final BuilderOptions options;

  EasyJsonGenerator(this.options);

  @override
  Future<String?> generate(LibraryReader library, BuildStep buildStep) async {
    // Lê as opções do build.yaml para obter as extensões de saída.
    // O fallback é o comportamento padrão do build_runner se nada for especificado.
    final buildExtensions = (options.config['build_extensions'] as Map?)?.cast<String, String>() ??
        {r'{{}}.dart': r'{{}}.easy.dart'};
 
    final annotated = library.annotatedWith(const TypeChecker.typeNamed(EasyJson));
    if (annotated.isEmpty) return null;

    final allGeneratedCode = StringBuffer();
    final allImports = <String>{};

    // Adiciona imports fixos
    allImports.add(_issueImport);

    // --- 1. Coleta todos os imports de todas as classes ---
    for (final annotatedElement in annotated) {
      final clazz = annotatedElement.element as ClassElement;
      final inputId = buildStep.inputId;

      // Importa a biblioteca atual
      allImports.add(clazz.library.uri.toString());

      // Coleta tipos referenciados nos campos
      final referenced = <ClassElement>{};
      for (final f in _getAllFields(clazz)) {
        // Adiciona imports de conversores e validadores customizados
        final easyConvert = _easyConvertChecker.firstAnnotationOfExact(f);
        if (easyConvert != null) {
          _collectReferencedFunctions(easyConvert, ['fromJson', 'toJson', 'valueFromJson', 'valueToJson'], referenced);
        }

        final easyValidate = _easyValidateChecker.firstAnnotationOfExact(f);
        if (easyValidate != null) {
          _collectReferencedFunctions(easyValidate, ['custom'], referenced);
        }

        // Coleta imports dos tipos dos campos
        _collectReferencedClasses(f.type, referenced);
      }

      for (final cls in referenced) {
        // Ignora tipos do SDK
        if (cls.library.uri.scheme == 'dart') continue;

        final clsId = await buildStep.resolver.assetIdForElement(cls);

        // Evita importar o próprio arquivo que está sendo lido
        if (clsId != inputId) {
          allImports.add(clsId.uri.toString());
        }

        // Se a classe referenciada também é @EasyJson, importa o .easy.dart
        if (const TypeChecker.typeNamed(EasyJson).hasAnnotationOf(cls, throwOnUnresolved: false)) {
          // Calcula o AssetId do arquivo gerado (.easy.dart) a partir do AssetId da classe de origem.
          final genId = _expectedOutput(clsId, buildExtensions);
          allImports.add(genId.uri.toString());
        }
      }
    }

    // --- 2. Gera o código para cada classe ---
    for (final annotatedElement in annotated) {
      final code = _generateForClass(
        annotatedElement.element as ClassElement,
        annotatedElement.annotation,
      );
      allGeneratedCode.writeln(code);
    }

    // --- 3. Monta o arquivo final ---
    final extraImports = <String>[
      "import 'dart:convert';",
      "import 'dart:typed_data';",
      "import 'package:dart_easy_json/src/runtime.dart' as ej;",
      "import 'package:dart_easy_json/src/messages.dart';",
    ];

    String fixImport(String uriStr, String fromPath) {
      if (uriStr.startsWith('asset:')) {
        final targetPath = uriStr.split('/').skip(1).join('/'); // skip asset:dart_easy_json
        return p.relative(targetPath, from: p.dirname(fromPath)).replaceAll(r'\', '/');
      }
      return uriStr;
    }

    final selfImport = fixImport(buildStep.inputId.uri.toString(), buildStep.inputId.path);
    final extraImports2 = allImports.map((i) => "import '${fixImport(i, buildStep.inputId.path)}';").toSet().toList();
    extraImports2.sort();

    final header = [
      "// ignore_for_file: type=lint, unused_import, unnecessary_cast, unused_local_variable, duplicate_import",
      "import '$selfImport';",
      ...extraImports2,
      ...extraImports,
    ].join('\n');

    final finalContent = '''
      // GENERATED CODE - DO NOT MODIFY BY HAND

      // **************************************************************************
      // EasyJsonGenerator
      // **************************************************************************

      $header

      ${allGeneratedCode.toString()}
    ''';

    try {
      return DartFormatter(
        languageVersion: DartFormatter.latestLanguageVersion,
      ).format(finalContent);
    } catch (_) {
      return finalContent; // Facilita debugar se format falhar
    }
  }

  String _generateForClass(ClassElement clazz, ConstantReader annotation) {
    final unionAnn = _easyUnionChecker.firstAnnotationOfExact(clazz);
    if (unionAnn != null) {
      return _generateUnionClass(clazz, ConstantReader(unionAnn), annotation);
    }
    final className = clazz.displayName;
    final varName = _lcFirst(className);
    final classIncludeIfNull =
        (annotation.peek('includeIfNull')?.literalValue as bool?) ?? false;
    final classCaseStyle = _readClassCaseStyle(annotation);
    final generateFromJson = (annotation.peek('fromJson')?.literalValue as bool?) ?? true;
    final generateToJson = (annotation.peek('toJson')?.literalValue as bool?) ?? true;

    // === Cria FieldContexts ===
    final fields = _getAllFields(clazz).toList();
    final contexts = [
      for (final f in fields)
        FieldContext(
          enclosingClass: clazz,
          element: f,
          classIncludeIfNull: classIncludeIfNull,
          classCaseStyle: classCaseStyle,
        ),
    ].where((c) => !c.isIgnored).toList();

    // === Render fromJson / toJson / validate / fromJsonSafe ===
    final fromJsonBody = contexts
        .map((c) => "${c.name}: ${_pick(c).fromJson(c)},")
        .join('\n');
    final toJsonBody = contexts
        .map((c) {
          final s = _pick(c).toJson(c);
          if (!c.isNullable) return "'${c.jsonKey}': $s,";
          return c.emitNulls
              ? "'${c.jsonKey}': $s,"
              : "if (${c.instanceAccess} != null) '${c.jsonKey}': $s,";
        })
        .join('\n');

    final validateBuf = StringBuffer()
      ..writeln("final issues = <EasyIssue>[];");
    for (final c in contexts) {
      _pick(c).validate(c, validateBuf);
    }
    validateBuf.writeln('return issues;');

    final fromJsonSafeBody = contexts
        .map((c) => "${c.name}: ${_pick(c).fromJsonSafe(c)},")
        .join('\n');

    // === Métodos ===
    final emitter = DartEmitter();

    Method mFromJson() => Method(
      (b) => b
        ..name = '${varName}FromJson'
        ..returns = refer(className)
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'json'
              ..type = refer('Map<String, dynamic>'),
          ),
        )
        ..body = Code('return $className($fromJsonBody);'),
    );

    Method mToJson() => Method(
      (b) => b
        ..name = '${varName}ToJson'
        ..returns = refer('Map<String, dynamic>')
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'instance'
              ..type = refer(className),
          ),
        )
        ..body = Code('return <String, dynamic>{$toJsonBody};'),
    );

    Method mValidate() => Method(
      (b) => b
        ..name = '${varName}Validate'
        ..returns = refer('List<EasyIssue>')
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'json'
              ..type = refer('Map<String, dynamic>'),
          ),
        )
        ..body = Code(validateBuf.toString()),
    );

    Method mFromJsonSafe() => Method(
      (b) => b
        ..name = '${varName}FromJsonSafe'
        ..returns = refer(className)
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'json'
              ..type = refer('Map<String, dynamic>'),
          ),
        )
        ..optionalParameters.addAll([
          Parameter(
            (p) => p
              ..named = true
              ..name = 'onIssue'
              ..type = refer('void Function(EasyIssue)?'),
          ),
          Parameter(
            (p) => p
              ..named = true
              ..name = 'runValidate'
              ..type = refer('bool')
              ..defaultTo = const Code('true'),
          ),
        ])
        ..body = Code("""
        if (runValidate) {
          final _issues = ${varName}Validate(json);
          if (onIssue != null) { for (final i in _issues) onIssue(i); }
        }
        return $className(
          $fromJsonSafeBody
        );
      """),
    );

    final mixin = MixinBuilder()
      ..name = '${className}Serializer'
      ..methods.add(
        Method(
          (b) => b
            ..name = 'toJson'
            ..returns = refer('Map<String, dynamic>')
            ..body = Code('return ${varName}ToJson(this as $className);'),
        ),
      );

    final companion = _companionClass(className, varName);

    final src =
        '''
        ${generateFromJson ? mFromJson().accept(emitter) : ''}
        ${generateToJson ? mToJson().accept(emitter) : ''}
        ${generateToJson ? mixin.build().accept(emitter) : ''}\n
        ${generateFromJson ? mValidate().accept(emitter) : ''}
        ${generateFromJson ? mFromJsonSafe().accept(emitter) : ''}
        ${generateFromJson ? companion.accept(emitter) : ''}
    ''';

    return src;
  }

  String _generateUnionClass(ClassElement clazz, ConstantReader unionAnn, ConstantReader jsonAnn) {
    final className = clazz.displayName;
    final varName = _lcFirst(className);
    final generateFromJson = (jsonAnn.peek('fromJson')?.literalValue as bool?) ?? true;
    final generateToJson = (jsonAnn.peek('toJson')?.literalValue as bool?) ?? true;

    final discriminator = unionAnn.peek('discriminator')!.stringValue;
    
    final mappingMap = unionAnn.peek('mapping')!.mapValue;
    final mapping = <String, String>{};
    for (final entry in mappingMap.entries) {
      final k = entry.key!.toStringValue()!;
      final v = entry.value!.toTypeValue()!.element!.displayName;
      mapping[k] = v;
    }

    final fallbackType = unionAnn.peek('fallback')?.typeValue.element?.displayName;

    final emitter = DartEmitter();

    // fromJson
    final fromJsonBuf = StringBuffer();
    fromJsonBuf.writeln("final d = json['$discriminator'];");
    fromJsonBuf.writeln("switch (d) {");
    for (final entry in mapping.entries) {
      fromJsonBuf.writeln("  case '${entry.key}': return ${entry.value}.fromJson(json);");
    }
    fromJsonBuf.writeln("  default:");
    if (fallbackType != null) {
      fromJsonBuf.writeln("    return $fallbackType.fromJson(json);");
    } else {
      fromJsonBuf.writeln("    throw Exception('Unknown union type: \\\$d');");
    }
    fromJsonBuf.writeln("}");

    Method mFromJson() => Method(
      (b) => b
        ..name = '${varName}FromJson'
        ..returns = refer(className)
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'json'
              ..type = refer('Map<String, dynamic>'),
          ),
        )
        ..body = Code(fromJsonBuf.toString()),
    );

    // validate
    final validateBuf = StringBuffer();
    validateBuf.writeln("final d = json['$discriminator'];");
    validateBuf.writeln("switch (d) {");
    for (final entry in mapping.entries) {
      final childVarName = _lcFirst(entry.value);
      validateBuf.writeln("  case '${entry.key}': return ${childVarName}Validate(json);");
    }
    validateBuf.writeln("  default:");
    validateBuf.writeln("    final issues = [EasyIssue(path: '$discriminator', code: 'unknown_union_type', message: 'Unknown type: \\\$d')];");
    if (fallbackType != null) {
      final fbVarName = _lcFirst(fallbackType);
      validateBuf.writeln("    issues.addAll(${fbVarName}Validate(json));");
    }
    validateBuf.writeln("    return issues;");
    validateBuf.writeln("}");

    Method mValidate() => Method(
      (b) => b
        ..name = '${varName}Validate'
        ..returns = refer('List<EasyIssue>')
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'json'
              ..type = refer('Map<String, dynamic>'),
          ),
        )
        ..body = Code(validateBuf.toString()),
    );

    // fromJsonSafe
    final fromJsonSafeBuf = StringBuffer();
    fromJsonSafeBuf.writeln("if (runValidate) {");
    fromJsonSafeBuf.writeln("  final _issues = ${varName}Validate(json);");
    fromJsonSafeBuf.writeln("  if (onIssue != null) { for (final i in _issues) onIssue(i); }");
    fromJsonSafeBuf.writeln("}");
    fromJsonSafeBuf.writeln("final d = json['$discriminator'];");
    fromJsonSafeBuf.writeln("switch (d) {");
    for (final entry in mapping.entries) {
      final childVarName = _lcFirst(entry.value);
      fromJsonSafeBuf.writeln("  case '${entry.key}': return ${childVarName}FromJsonSafe(json, onIssue: onIssue, runValidate: false);");
    }
    fromJsonSafeBuf.writeln("  default:");
    if (fallbackType != null) {
      final fbVarName = _lcFirst(fallbackType);
      fromJsonSafeBuf.writeln("    return ${fbVarName}FromJsonSafe(json, onIssue: onIssue, runValidate: false);");
    } else {
      fromJsonSafeBuf.writeln("    throw Exception('Unknown union type: \\\$d. Provide a fallback in @EasyUnion to avoid crashes on unknown types.');");
    }
    fromJsonSafeBuf.writeln("}");

    Method mFromJsonSafe() => Method(
      (b) => b
        ..name = '${varName}FromJsonSafe'
        ..returns = refer(className)
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'json'
              ..type = refer('Map<String, dynamic>'),
          ),
        )
        ..optionalParameters.addAll([
          Parameter(
            (p) => p
              ..named = true
              ..name = 'onIssue'
              ..type = refer('void Function(EasyIssue)?'),
          ),
          Parameter(
            (p) => p
              ..named = true
              ..name = 'runValidate'
              ..type = refer('bool')
              ..defaultTo = const Code('true'),
          ),
        ])
        ..body = Code(fromJsonSafeBuf.toString()),
    );

    // toJson
    Method mToJson() => Method(
      (b) => b
        ..name = '${varName}ToJson'
        ..returns = refer('Map<String, dynamic>')
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'instance'
              ..type = refer(className),
          ),
        )
        ..body = const Code('return (instance as dynamic).toJson() as Map<String, dynamic>;'),
    );

    final mixin = MixinBuilder()
      ..name = '${className}Serializer'
      ..methods.add(
        Method(
          (b) => b
            ..name = 'toJson'
            ..returns = refer('Map<String, dynamic>')
            ..body = Code('return ${varName}ToJson(this as $className);'),
        ),
      );

    final companion = _companionClass(className, varName);

    final src =
        '''
        ${generateFromJson ? mFromJson().accept(emitter) : ''}
        ${generateToJson ? mToJson().accept(emitter) : ''}
        ${generateToJson ? mixin.build().accept(emitter) : ''}
        
        ${generateFromJson ? mValidate().accept(emitter) : ''}
        ${generateFromJson ? mFromJsonSafe().accept(emitter) : ''}
        ${generateFromJson ? companion.accept(emitter) : ''}
    ''';

    return src;
  }

  // ===== infra =====
  TypeStrategy _pick(FieldContext c) {
    if (c.isEnum) return EnumStrategy();
    if (c.isEasyJsonObject) return ObjectStrategy();
    if (c.isList) return ListStrategy();
    if (c.isSet) return SetStrategy();
    if (c.isMap) return MapStrategy();
    if (c.isUint8List) return Uint8ListStrategy();
    return PrimitiveStrategy();
  }

  void _collectReferencedClasses(DartType type, Set<ClassElement> out) {
    if (type is InterfaceType) {
      final el = type.element;
      if (el is ClassElement) out.add(el);
      for (final t in type.typeArguments) {
        _collectReferencedClasses(t, out);
      }
    }
  }

  void _collectReferencedFunctions(DartObject annotation, List<String> fieldNames, Set<ClassElement> out) {
    for (final fieldName in fieldNames) {
      final field = annotation.getField(fieldName);
      if (field == null || field.isNull) continue;

      final fn = field.toFunctionValue();
      if (fn == null) continue;

      final enclosing = fn.enclosingElement;
      if (enclosing is ClassElement) {
        out.add(enclosing);
      }
      // Se for uma função de nível superior, a biblioteca já será importada pelo tipo do campo.
    }
  }

  Iterable<FieldElement> _getAllFields(ClassElement clazz) {
    final fieldsMap = <String, FieldElement>{};

    // 1. Adiciona campos das superclasses (ignorando Object), do topo para a base.
    // Usamos o .reversed para que as classes mais altas na hierarquia sejam processadas primeiro.
    for (final supertype in clazz.allSupertypes.reversed) {
      if (supertype.isDartCoreObject) continue;
      for (final f in supertype.element.fields.where((f) => !f.isStatic)) {
        fieldsMap[f.name!] = f;
      }
    }

    // 2. Adiciona campos da classe atual (sobrescrevendo atributos pai, caso haja um override)
    for (final f in clazz.fields.where((f) => !f.isStatic)) {
      fieldsMap[f.name!] = f;
    }

    return fieldsMap.values;
  }

  String _lcFirst(String s) =>
      s.isEmpty ? s : (s[0].toLowerCase() + s.substring(1));

  CaseStyle? _readClassCaseStyle(ConstantReader classAnn) {
    final peek = classAnn.peek('caseStyle');
    if (peek == null || peek.isNull) return null;
    final revived = peek.revive(); // enum revive
    final accessor = revived.accessor; // ex.: 'CaseStyle.snake'
    return CaseStyle.values.firstWhere(
      (e) => e.toString() == accessor,
      orElse: () => CaseStyle.none,
    );
  }

  Class _companionClass(String className, String varName) => Class((b) {
    b
      ..name = '${className}Json'
      ..constructors.add(Constructor((c) => c..constant = true))
      ..methods.addAll([
        Method(
          (m) => m
            ..name = 'fromJson'
            ..static = true
            ..returns = refer(className)
            ..requiredParameters.add(
              Parameter(
                (p) => p
                  ..name = 'json'
                  ..type = refer('Map<String, dynamic>'),
              ),
            )
            ..body = Code('return ${varName}FromJson(json);'),
        ),
        Method(
          (m) => m
            ..name = 'fromJsonSafe'
            ..static = true
            ..returns = refer(className)
            ..requiredParameters.add(
              Parameter(
                (p) => p
                  ..name = 'json'
                  ..type = refer('Map<String, dynamic>'),
              ),
            )
            ..optionalParameters.addAll([
              Parameter(
                (p) => p
                  ..named = true
                  ..name = 'onIssue'
                  ..type = refer('void Function(EasyIssue)?'),
              ),
              Parameter(
                (p) => p
                  ..named = true
                  ..name = 'runValidate'
                  ..type = refer('bool')
                  ..defaultTo = const Code('true'),
              ),
            ])
            ..body = Code(
              'return ${varName}FromJsonSafe(json, onIssue: onIssue, runValidate: runValidate);',
            ),
        ),
        Method(
          (m) => m
            ..name = 'validate'
            ..static = true
            ..returns = refer('List<EasyIssue>')
            ..requiredParameters.add(
              Parameter(
                (p) => p
                  ..name = 'json'
                  ..type = refer('Map<String, dynamic>'),
              ),
            )
            ..body = Code('return ${varName}Validate(json);'),
        ),
      ]);
  });
}

/// Calcula o AssetId de saída para um AssetId de entrada com base nas regras de build_extensions.
AssetId _expectedOutput(AssetId inputId, Map<String, String> buildExtensions) {
  final matchingExtensions = buildExtensions.entries.where((entry) {
    final regex = RegExp(entry.key.replaceFirst(r'{{}}', r'(.+)'));
    return regex.hasMatch(inputId.path);
  });

  if (matchingExtensions.isEmpty) {
    // Fallback se nenhuma regra corresponder (improvável com a configuração padrão)
    return inputId.changeExtension('.easy.dart');
  }

  final rule = matchingExtensions.first;
  final newPath = inputId.path.replaceFirstMapped(RegExp(rule.key.replaceFirst(r'{{}}', r'(.+)')), (match) {
    return rule.value.replaceFirst(r'{{}}', match.group(1)!);
  });
  return AssetId(inputId.package, newPath);
}


