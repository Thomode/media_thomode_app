import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:media_thomode_app/models/series.dart';
import 'package:media_thomode_app/models/series_details.dart';
import 'package:media_thomode_app/models/video_episode.dart';

class SeriesService {
  final String baseUrl = "http://192.168.100.12:8000/api/series";

  // Buscar series por nombre
  Future<List<Series>> searchSeries(String seriesType, String searchName) async {
    final url = Uri.parse('$baseUrl/$seriesType/search/$searchName');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return jsonResponse.map((data) => Series.fromJson(data)).toList();

      } else {
        throw Exception('Failed to load series');
      }
    } catch (e) {
      throw Exception('Error searching series: $e');
    }
  }

  // Obtener detalles de una serie por name_id
  Future<SeriesDetails> getSeriesDetails(String seriesType, String nameId) async {
    final url = Uri.parse('$baseUrl/$seriesType/$nameId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return SeriesDetails.fromJson(json.decode(utf8.decode(response.bodyBytes)));

      } else if (response.statusCode == 404) {
        throw Exception('Series not found: $nameId');
      } else {
        throw Exception('Failed to load series details');
      }
    } catch (e) {
      throw Exception('Error fetching series details: $e');
    }
  }

  // Obtener URL de video directo por series_name_id y episode_id
  Future<List<VideoEpisode>> getVideoServers(String seriesType,String seriesNameId, String episodeId) async {
    final url = Uri.parse('$baseUrl/$seriesType/$seriesNameId/$episodeId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return jsonResponse.map((data) => VideoEpisode.fromJson(data)).toList();

      } else if (response.statusCode == 404) {
        throw Exception('Video not found for: $seriesNameId/$episodeId');
      } else {
        throw Exception('Failed to load video episode');
      }
    } catch (e) {
      throw Exception('Error fetching video URL: $e');
    }
  }
}
