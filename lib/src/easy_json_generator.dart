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

const _issueImport = "package:dart_easy_json/runtime.dart";

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
      for (final (f, fieldType) in _getAllFields(clazz)) {
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
        _collectReferencedClasses(fieldType, referenced);
      }

      // Bounds dos parâmetros de tipo (`class X<T extends Base>`) também
      // aparecem no código gerado.
      for (final tp in clazz.typeParameters) {
        final bound = tp.bound;
        if (bound != null) _collectReferencedClasses(bound, referenced);
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
      "import 'package:dart_easy_json/runtime.dart' as ej;",
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
      for (final (f, type) in fields)
        FieldContext(
          enclosingClass: clazz,
          element: f,
          type: type,
          classIncludeIfNull: classIncludeIfNull,
          classCaseStyle: classCaseStyle,
        ),
    ].where((c) => !c.isIgnored).toList();

    // === Genéricos / strict ===
    final generics = _Generics(clazz);
    for (final c in contexts) {
      _checkGenericSupport(c);
      // fallback / itemFallback / enumFallback inválidos viram erro de build.
      checkEasyKeyValues(c);
    }
    // `ApiResponse<T>` para classes genéricas, `User` para as demais.
    final classRef = '$className${generics.args}';
    final strict = (annotation.peek('strict')?.literalValue as bool?) ?? false;

    // === Render fromJson / toJson / validate / fromJsonSafe ===
    final fromJsonBody = contexts
      .map((c) => "${c.name}: ${_pick(c).fromJson(c)},")
      .join('\n');
    final toJsonBody = contexts
      .where((c) => c.easyPath == null)
      .map((c) {
        final s = _pick(c).toJson(c);
        if (!c.isNullable) return "'${c.jsonKey}': $s,";
        return c.emitNulls
          ? "'${c.jsonKey}': $s,"
          : "if (${c.instanceAccess} != null) '${c.jsonKey}': $s,";
      })
      .join('\n');

    // Campos com @EasyPath são escritos aninhados (mesmo formato que o
    // fromJson lê), então saem do literal e viram chamadas a ej.writePath.
    final pathFields = contexts.where((c) => c.easyPath != null).toList();
    final toJsonCode = pathFields.isEmpty
        ? 'return <String, dynamic>{$toJsonBody};'
        : [
            'final json = <String, dynamic>{$toJsonBody};',
            for (final c in pathFields)
              '${!c.isNullable || c.emitNulls ? '' : 'if (${c.instanceAccess} != null) '}'
                  'ej.writePath(json, const [${c.easyPath!.split('.').map(_quote).join(', ')}], ${_pick(c).toJson(c)});',
            'return json;',
          ].join('\n');

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

    // strict: valida tudo antes e lança EasyValidationException com todos os
    // problemas; se passar, constrói pelo caminho safe (que aceita tudo que
    // o validate aceita), então nunca sobra um TypeError cru.
    final fromJsonCode = strict
        ? '''
          final issues = ${varName}Validate${generics.args}(json);
          if (issues.isNotEmpty) throw EasyValidationException(issues);
          return ${varName}FromJsonSafe${generics.args}(json${generics.fromJsonArgs}, runValidate: false);
        '''
        : 'return $classRef($fromJsonBody);';

    Method mFromJson() => Method(
      (b) => b
        ..name = '${varName}FromJson'
        ..types.addAll(generics.typeRefs)
        ..returns = refer(classRef)
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'json'
              ..type = refer('Map<String, dynamic>'),
          ),
        )
        ..requiredParameters.addAll(generics.fromJsonParams)
        ..body = Code(fromJsonCode),
    );

    Method mToJson() => Method(
      (b) => b
        ..name = '${varName}ToJson'
        ..types.addAll(generics.typeRefs)
        ..returns = refer('Map<String, dynamic>')
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'instance'
              ..type = refer(classRef),
          ),
        )
        ..requiredParameters.addAll(generics.toJsonParams)
        ..body = Code(toJsonCode),
    );

    Method mValidate() => Method(
      (b) => b
        ..name = '${varName}Validate'
        // Validar `T` por dentro só é possível com um validador para ele
        // (`validateT`, opcional). O gerador passa um quando a classe é
        // usada como campo com o tipo conhecido (`Page<User>`).
        ..types.addAll(generics.typeRefs)
        ..returns = refer('List<EasyIssue>')
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'json'
              ..type = refer('Map<String, dynamic>'),
          ),
        )
        ..optionalParameters.addAll(generics.validateParams)
        ..body = Code(validateBuf.toString()),
    );

    Method mFromJsonSafe() => Method(
      (b) => b
        ..name = '${varName}FromJsonSafe'
        ..types.addAll(generics.typeRefs)
        ..returns = refer(classRef)
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'json'
              ..type = refer('Map<String, dynamic>'),
          ),
        )
        ..requiredParameters.addAll(generics.fromJsonParams)
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
        // validate + parse podem apontar o mesmo problema: reporta uma vez só.
        final _report = ej.dedupeIssues(onIssue);
        if (runValidate && _report != null) {
          for (final i in ${varName}Validate${generics.args}(json)) _report(i);
        }
        return ((void Function(EasyIssue)? onIssue) => $classRef(
          $fromJsonSafeBody
        ))(_report);
      """),
    );

    final mixin = MixinBuilder()
      ..name = '${className}Serializer'
      ..types.addAll(generics.typeRefs)
      ..methods.add(
        Method(
          (b) => b
            ..name = 'toJson'
            ..returns = refer('Map<String, dynamic>')
            ..requiredParameters.addAll(generics.toJsonParams)
            ..body = Code(
              'return ${varName}ToJson${generics.args}(this as $classRef${generics.toJsonArgs});',
            ),
        ),
      );

    final companion = _companionClass(className, varName, generics);

    final src =
        '''
        ${generateFromJson ? mFromJson().accept(emitter) : ''}
        ${generateToJson ? mToJson().accept(emitter) : ''}
        ${generateToJson ? mixin.build().accept(emitter) : ''}\n
        ${generateFromJson ? mValidate().accept(emitter) : ''}
        ${generateFromJson ? mFromJsonSafe().accept(emitter) : ''}
        ${generateFromJson ? companion.accept(emitter) : ''}
        ${_listHelpers(className, varName, generics, generateFromJson: generateFromJson, generateToJson: generateToJson)}
    ''';

    return src;
  }

  String _generateUnionClass(ClassElement clazz, ConstantReader unionAnn, ConstantReader jsonAnn) {
    final className = clazz.displayName;
    final varName = _lcFirst(className);
    final generateFromJson = (jsonAnn.peek('fromJson')?.literalValue as bool?) ?? true;
    final generateToJson = (jsonAnn.peek('toJson')?.literalValue as bool?) ?? true;
    final strict = (jsonAnn.peek('strict')?.literalValue as bool?) ?? false;

    if (clazz.typeParameters.isNotEmpty) {
      throw InvalidGenerationSourceError(
        '`$className` is a generic @EasyUnion, which is not supported yet.',
        element: clazz,
      );
    }
    final generics = _Generics(clazz); // sempre vazio aqui

    final discriminator = unionAnn.peek('discriminator')!.stringValue;

    final mappingMap = unionAnn.peek('mapping')!.mapValue;
    final mapping = <String, String>{};
    for (final entry in mappingMap.entries) {
      final k = entry.key!.toStringValue()!;
      final type = entry.value!.toTypeValue()!;
      if (type is InterfaceType && type.element.typeParameters.isNotEmpty) {
        throw InvalidGenerationSourceError(
          '@EasyUnion on `$className` maps \'$k\' to the generic class '
          '`${type.element.displayName}`, which is not supported yet.',
          element: clazz,
        );
      }
      mapping[k] = type.element!.displayName;
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

    // strict: mesma ideia das classes normais — valida (inclusive o
    // discriminator) e só então delega para o caminho safe.
    final fromJsonCode = strict
        ? '''
          final issues = ${varName}Validate(json);
          if (issues.isNotEmpty) throw EasyValidationException(issues);
          return ${varName}FromJsonSafe(json, runValidate: false);
        '''
        : fromJsonBuf.toString();

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
        ..body = Code(fromJsonCode),
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
    fromJsonSafeBuf.writeln("final _report = ej.dedupeIssues(onIssue);");
    fromJsonSafeBuf.writeln("if (runValidate && _report != null) {");
    fromJsonSafeBuf.writeln("  for (final i in ${varName}Validate(json)) _report(i);");
    fromJsonSafeBuf.writeln("}");
    fromJsonSafeBuf.writeln("final d = json['$discriminator'];");
    fromJsonSafeBuf.writeln("switch (d) {");
    for (final entry in mapping.entries) {
      final childVarName = _lcFirst(entry.value);
      fromJsonSafeBuf.writeln("  case '${entry.key}': return ${childVarName}FromJsonSafe(json, onIssue: _report, runValidate: false);");
    }
    fromJsonSafeBuf.writeln("  default:");
    if (fallbackType != null) {
      final fbVarName = _lcFirst(fallbackType);
      fromJsonSafeBuf.writeln("    return ${fbVarName}FromJsonSafe(json, onIssue: _report, runValidate: false);");
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

    final companion = _companionClass(className, varName, generics);

    final src = '''
      ${generateFromJson ? mFromJson().accept(emitter) : ''}
      ${generateToJson ? mToJson().accept(emitter) : ''}
      ${generateToJson ? mixin.build().accept(emitter) : ''}
      
      ${generateFromJson ? mValidate().accept(emitter) : ''}
      ${generateFromJson ? mFromJsonSafe().accept(emitter) : ''}
      ${generateFromJson ? companion.accept(emitter) : ''}
      ${_listHelpers(className, varName, generics, generateFromJson: generateFromJson, generateToJson: generateToJson)}
    ''';

    return src;
  }

  /// Gera helpers de topo para operar sobre `List<$className>` de uma vez:
  /// `${varName}FromJsonList`, `${varName}FromJsonSafeList` e `${varName}ToJsonList`.
  String _listHelpers(
    String className,
    String varName,
    _Generics generics, {
    required bool generateFromJson,
    required bool generateToJson,
  }) {
    final buf = StringBuffer();
    final classRef = '$className${generics.args}';
    final args = generics.args;
    final decl = generics.decl;

    if (generateFromJson) {
      buf.writeln("""
        List<$classRef> ${varName}FromJsonList$decl(List<dynamic> json${generics.fromJsonParamsDecl}) =>
            json.map((e) => ${varName}FromJson$args(e as Map<String, dynamic>${generics.fromJsonArgs})).toList();

        List<$classRef> ${varName}FromJsonSafeList$decl(
          List<dynamic> json${generics.fromJsonParamsDecl}, {
          void Function(int index, EasyIssue issue)? onIssue,
          bool runValidate = true,
        }) => json.asMap().entries.map((entry) => ${varName}FromJsonSafe$args(
              entry.value as Map<String, dynamic>${generics.fromJsonArgs},
              onIssue: onIssue == null ? null : (i) => onIssue(entry.key, i),
              runValidate: runValidate,
            )).toList();
      """);
    }

    if (generateToJson) {
      buf.writeln("""
        List<Map<String, dynamic>> ${varName}ToJsonList$decl(List<$classRef> items${generics.toJsonParamsDecl}) =>
            items.map((e) => ${varName}ToJson$args(e${generics.toJsonArgs})).toList();
      """);
    }

    return buf.toString();
  }

  /// Parâmetros de tipo só são suportados onde o gerador sabe repassar o
  /// conversor: `T` direto ou dentro de List / Set / Map e de classes
  /// @EasyJson genéricas. Fora disso (ex.: `Future<T>`), erro claro no build
  /// em vez de código que não compila.
  void _checkGenericSupport(FieldContext c) {
    bool ok(DartType t) {
      if (!containsTypeParameter(t) || t is TypeParameterType) return true;
      final it = t as InterfaceType;
      final container = const {'List', 'Set', 'Map'}.contains(it.element.name) ||
          isEasyJsonClass(it);
      return container && it.typeArguments.every(ok);
    }

    if (c.convertFromJson != null || ok(c.type)) return;
    throw InvalidGenerationSourceError(
      'Field `${c.enclosingClass.displayName}.${c.name}` '
      '(`${c.type.getDisplayString()}`): type parameters are supported as '
      '`T` / `T?` or inside List, Set, Map and @EasyJson classes.',
      element: c.element,
    );
  }

  // ===== infra =====
  TypeStrategy _pick(FieldContext c) {
    if (c.isTypeParameter) return GenericStrategy();
    if (c.isEnum) return EnumStrategy();
    if (c.isEasyJsonObject) return ObjectStrategy();
    if (c.isList) return ListStrategy();
    if (c.isSet) return SetStrategy();
    if (c.isMap) return MapStrategy();
    if (c.isUint8List) return Uint8ListStrategy();
    if (c.isUri) return UriStrategy();
    if (c.isDuration) return DurationStrategy();
    if (c.isBigInt) return BigIntStrategy();
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

  /// Campos da classe e das superclasses, cada um com o tipo visto por
  /// [clazz]: um `List<T> items` herdado de `Page<User>` vira `List<User>`.
  Iterable<(FieldElement, DartType)> _getAllFields(ClassElement clazz) {
    final fieldsMap = <String, (FieldElement, DartType)>{};

    // 1. Adiciona campos das superclasses (ignorando Object), do topo para a base.
    // Usamos o .reversed para que as classes mais altas na hierarquia sejam processadas primeiro.
    // `allSupertypes` já vem com os argumentos de tipo em termos de [clazz].
    for (final supertype in clazz.allSupertypes.reversed) {
      if (supertype.isDartCoreObject) continue;
      for (final f in supertype.element.fields.where((f) => !f.isStatic)) {
        final type = supertype.getGetter(f.name!)?.returnType ?? f.type;
        fieldsMap[f.name!] = (f, type);
      }
    }

    // 2. Adiciona campos da classe atual (sobrescrevendo atributos pai, caso haja um override)
    for (final f in clazz.fields.where((f) => !f.isStatic)) {
      fieldsMap[f.name!] = (f, f.type);
    }

    return fieldsMap.values;
  }

  String _lcFirst(String s) =>
      s.isEmpty ? s : (s[0].toLowerCase() + s.substring(1));

  /// Literal de string Dart (aspas simples) com escape de `\`, `'` e `$`.
  String _quote(String s) =>
      "'${s.replaceAll(r'\', r'\\').replaceAll("'", r"\'").replaceAll(r'$', r'\$')}'";

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

  Class _companionClass(String className, String varName, _Generics generics) => Class((b) {
    // Métodos estáticos não enxergam parâmetros de tipo da classe, então os
    // genéricos ficam nos próprios métodos: `ApiResponseJson.fromJson<T>(...)`.
    final classRef = '$className${generics.args}';
    b
      ..name = '${className}Json'
      ..constructors.add(Constructor((c) => c..constant = true))
      ..methods.addAll([
        Method(
          (m) => m
            ..name = 'fromJson'
            ..static = true
            ..types.addAll(generics.typeRefs)
            ..returns = refer(classRef)
            ..requiredParameters.add(
              Parameter(
                (p) => p
                  ..name = 'json'
                  ..type = refer('Map<String, dynamic>'),
              ),
            )
            ..requiredParameters.addAll(generics.fromJsonParams)
            ..body = Code(
              'return ${varName}FromJson${generics.args}(json${generics.fromJsonArgs});',
            ),
        ),
        Method(
          (m) => m
            ..name = 'fromJsonSafe'
            ..static = true
            ..types.addAll(generics.typeRefs)
            ..returns = refer(classRef)
            ..requiredParameters.add(
              Parameter(
                (p) => p
                  ..name = 'json'
                  ..type = refer('Map<String, dynamic>'),
              ),
            )
            ..requiredParameters.addAll(generics.fromJsonParams)
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
              'return ${varName}FromJsonSafe${generics.args}(json${generics.fromJsonArgs}, onIssue: onIssue, runValidate: runValidate);',
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

/// Parâmetros de tipo de uma classe @EasyJson e os pedaços de código que
/// derivam deles. Para classes não genéricas tudo é vazio, então o código
/// gerado continua idêntico ao de antes.
///
/// Segue a convenção do `json_serializable`: um conversor por parâmetro de
/// tipo, `T Function(Object? json) fromJsonT` / `Object? Function(T value) toJsonT`.
class _Generics {
  _Generics(ClassElement clazz)
      : names = [for (final tp in clazz.typeParameters) tp.displayName],
        _bounds = [
          for (final tp in clazz.typeParameters) tp.bound?.getDisplayString(),
        ];

  final List<String> names;
  final List<String?> _bounds;

  bool get isGeneric => names.isNotEmpty;

  /// `<T, U>` (uso) ou ''.
  String get args => isGeneric ? '<${names.join(', ')}>' : '';

  /// `<T extends Base, U>` (declaração) ou ''.
  String get decl {
    if (!isGeneric) return '';
    final parts = [
      for (var i = 0; i < names.length; i++)
        _bounds[i] == null ? names[i] : '${names[i]} extends ${_bounds[i]}',
    ];
    return '<${parts.join(', ')}>';
  }

  List<Reference> get typeRefs => [
    for (var i = 0; i < names.length; i++)
      TypeReference(
        (b) => b
          ..symbol = names[i]
          ..bound = _bounds[i] == null ? null : refer(_bounds[i]!),
      ),
  ];

  List<Parameter> get fromJsonParams => [
    for (final t in names)
      Parameter(
        (p) => p
          ..name = 'fromJson$t'
          ..type = refer('$t Function(Object? json)'),
      ),
  ];

  /// `{List<EasyIssue> Function(Object? json)? validateT}` — issues com o
  /// path relativo ao valor (`''`, `'.name'`, `'[0]'`).
  List<Parameter> get validateParams => [
    for (final t in names)
      Parameter(
        (p) => p
          ..named = true
          ..name = 'validate$t'
          ..type = refer('List<EasyIssue> Function(Object? json)?'),
      ),
  ];

  List<Parameter> get toJsonParams => [
    for (final t in names)
      Parameter(
        (p) => p
          ..name = 'toJson$t'
          ..type = refer('Object? Function($t value)'),
      ),
  ];

  /// `, T Function(Object? json) fromJsonT` — para templates em string.
  String get fromJsonParamsDecl =>
      names.map((t) => ', $t Function(Object? json) fromJson$t').join();
  String get toJsonParamsDecl =>
      names.map((t) => ', Object? Function($t value) toJson$t').join();

  /// `, fromJsonT` — repassa os conversores adiante.
  String get fromJsonArgs => names.map((t) => ', fromJson$t').join();
  String get toJsonArgs => names.map((t) => ', toJson$t').join();
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


