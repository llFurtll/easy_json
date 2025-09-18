import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/easy_json_generator.dart';

Builder easyJsonBuilder(BuilderOptions options) {
  return LibraryBuilder(
    EasyJsonGenerator(),
    generatedExtension: '.easy.dart',
    options: options
  );
}