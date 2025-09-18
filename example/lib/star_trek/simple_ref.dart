import 'package:easy_json/easy_json.dart';
import 'package:example/generated/star_trek/simple_ref.easy.dart';

@EasyJson()
class SimpleRef with SimpleRefSerializer {
  final String uid;
  final String title;
  const SimpleRef({required this.uid, required this.title});
}