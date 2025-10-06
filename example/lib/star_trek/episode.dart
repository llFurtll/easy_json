import 'package:dart_easy_json/easy_json.dart';
import 'package:example/star_trek/simple_ref.dart';
import 'package:example/generated/star_trek/episode.easy.dart';

@EasyJson()
class Episode with EpisodeSerializer {
  final String uid;
  final String title;
  final String? titleGerman;
  final String? titleItalian;
  final String? titleJapanese;

  final SimpleRef series;
  final SimpleRef season;

  final int seasonNumber;
  final int episodeNumber;
  final String? productionSerialNumber;

  final bool? featureLength;

  final double? stardateFrom;
  final double? stardateTo;
  final int? yearFrom;
  final int? yearTo;

  // Pode ser DateTime direto (ISO yyyy-MM-dd)
  final DateTime? usAirDate;

  final String? finalScriptDate;

  const Episode({
    required this.uid,
    required this.title,
    this.titleGerman,
    this.titleItalian,
    this.titleJapanese,
    required this.series,
    required this.season,
    required this.seasonNumber,
    required this.episodeNumber,
    this.productionSerialNumber,
    this.featureLength,
    this.stardateFrom,
    this.stardateTo,
    this.yearFrom,
    this.yearTo,
    this.usAirDate,
    this.finalScriptDate,
  });
}