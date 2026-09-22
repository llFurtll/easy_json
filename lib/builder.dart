import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/easy_json_generator.dart';

/// Builder factory registered in `build.yaml` as `dart_easy_json:easy_json_builder`.
///
/// Not meant to be called from application code — `build_runner` invokes it
/// for every library containing an `@EasyJson`-annotated class and writes
/// its output to the `.easy.dart` file configured by `build_extensions`.
Builder easyJsonBuilder(BuilderOptions options) {
  return LibraryBuilder(
    EasyJsonGenerator(options),
    generatedExtension: '.easy.dart',
    options: options
  );
}