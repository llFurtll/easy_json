import 'package:dart_easy_json/easy_json.dart';
import 'package:example/generated/star_trek/series.easy.dart';
import 'package:example/star_trek/company.dart';

@EasyJson()
class Series with SeriesSerializer {
  final String uid;
  final String title;
  final String? abbreviation;

  // Se quiser que o pacote já parse datas:
  final DateTime? originalRunStartDate;
  final DateTime? originalRunEndDate;

  final int? productionStartYear;
  final int? productionEndYear;
  final int? seasonsCount;
  final int? episodesCount;
  final int? featureLengthEpisodesCount;

  final Company? productionCompany;
  final Company? originalBroadcaster;

  const Series({
    required this.uid,
    required this.title,
    this.abbreviation,
    this.originalRunStartDate,
    this.originalRunEndDate,
    this.productionStartYear,
    this.productionEndYear,
    this.seasonsCount,
    this.episodesCount,
    this.featureLengthEpisodesCount,
    this.productionCompany,
    this.originalBroadcaster,
  });
}
