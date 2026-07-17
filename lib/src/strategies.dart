// ignore_for_file: experimental_member_use
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';

import 'annotations.dart';
import 'field_context.dart';
import 'templates.dart';

part 'strategies/base.dart';
part 'strategies/primitive_strategy.dart';
part 'strategies/uint8list_strategy.dart';
part 'strategies/enum_strategy.dart';
part 'strategies/object_strategy.dart';
part 'strategies/list_strategy.dart';
part 'strategies/set_strategy.dart';
part 'strategies/map_strategy.dart';
