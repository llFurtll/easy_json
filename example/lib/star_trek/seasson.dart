import 'package:easy_json/easy_json.dart';
import 'package:example/generated/star_trek/seasson.easy.dart';
import 'package:example/star_trek/episode.dart';
import 'package:example/star_trek/series.dart';

@EasyJson()
class Season with SeasonSerializer {
  final String uid;
  final String title;
  final Series series;
  final int seasonNumber;
  final int numberOfEpisodes;
  final List<Episode> episodes;

  const Season({
    required this.uid,
    required this.title,
    required this.series,
    required this.seasonNumber,
    required this.numberOfEpisodes,
    required this.episodes,
  });
}