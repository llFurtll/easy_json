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

class EasyJsonGenerator extends Generator {
  @override
  Future<String?> generate(LibraryReader library, BuildStep buildStep) async {
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
      for (final f in clazz.fields.where((f) => !f.isStatic)) {
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
          // Esta lógica de resolução de caminho para o arquivo gerado pode ser simplificada
          // ou melhorada, mas por agora vamos manter a consistência.
          final clsRel = p.relative(clsId.path, from: 'lib');
          final generatedPath = p.join(
            'lib',
            'generated',
            p.dirname(clsRel),
            p.setExtension(p.basename(clsRel), '.easy.dart'),
          ).replaceAll('\\', '/');

          final genId = AssetId(clsId.package, generatedPath);
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
    final orderedImports = allImports.toList()..sort();
    final extraImports = <String>[
      "import 'package:dart_easy_json/src/runtime.dart' as ej;",
      "import 'package:dart_easy_json/src/messages.dart';",
    ];

    final header = [
      "// ignore_for_file: type=lint",
      ...orderedImports.map((u) => "import '$u';"),
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
    final className = clazz.displayName;
    final varName = _lcFirst(className);
    final classIncludeIfNull =
        (annotation.peek('includeIfNull')?.literalValue as bool?) ?? false;
    final classCaseStyle = _readClassCaseStyle(annotation);

    // === Cria FieldContexts ===
    final fields = clazz.fields.where((f) => !f.isStatic).toList();
    final contexts = [
      for (final f in fields)
        FieldContext(
          enclosingClass: clazz,
          element: f,
          classIncludeIfNull: classIncludeIfNull,
          classCaseStyle: classCaseStyle,
        ),
    ];

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
        ${mFromJson().accept(emitter)}
        ${mToJson().accept(emitter)}
        ${mixin.build().accept(emitter)}\n
        ${mValidate().accept(emitter)}
        ${mFromJsonSafe().accept(emitter)}
        ${companion.accept(emitter)}
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
