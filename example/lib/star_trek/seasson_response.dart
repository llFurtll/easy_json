import 'package:dart_easy_json/easy_json.dart';
import 'package:example/generated/star_trek/seasson_response.easy.dart';
import 'package:example/star_trek/seasson.dart';

@EasyJson()
class SeasonResponse with SeasonResponseSerializer {
  final Season season;
  const SeasonResponse({required this.season});
}