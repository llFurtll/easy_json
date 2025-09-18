// lib/main.dart
import 'dart:convert';
import 'package:example/generated/star_trek/seasson_response.easy.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  final uri = Uri.parse(
    'https://stapi.co/api/v1/rest/season?uid=SAMA0000001633',
  );

  try {
    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.reasonPhrase}');
    }

    final Map<String, dynamic> body =
        jsonDecode(res.body) as Map<String, dynamic>;

    final parsed = SeasonResponseJson.fromJsonSafe(
      body,
      onIssue: (i) => print('[issue] ${i.path} | ${i.code} -> ${i.message}'),
    );

    final season = parsed.season;
    print('Season: ${season.title}');
    print(
      'Series: ${season.series.title} (${season.series.abbreviation ?? '-'})',
    );
    print('Episódios: ${season.numberOfEpisodes}\n');

    for (final e in season.episodes) {
      final air = e.usAirDate?.toIso8601String().split('T').first ?? '—';
      print(
        '#${e.episodeNumber.toString().padLeft(2, '0')} '
        '${e.title}  |  stardate ${e.stardateFrom?.toStringAsFixed(1) ?? '—'}  |  US: $air',
      );
    }

  } catch (e) {
    print('Falha ao buscar/parsear: $e');
  }
}
