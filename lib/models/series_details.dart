import 'package:media_thomode_app/models/episode.dart';

class SeriesDetails {
  final String name;
  final String nameId;
  final String synopsis;
  final String status;
  final String profileImageUrl;
  final String coverImageUrl;
  final String lastEpisode;
  final List<Episode> episodes;

  SeriesDetails({
    required this.name,
    required this.nameId,
    required this.synopsis,
    required this.status,
    required this.profileImageUrl,
    required this.coverImageUrl,
    required this.lastEpisode,
    required this.episodes,
  });

  // Método para convertir desde JSON
  factory SeriesDetails.fromJson(Map<String, dynamic> json) {
    var episodesFromJson = json['episodes'] as List;
    List<Episode> episodesList = episodesFromJson.map((episode) => Episode.fromJson(episode)).toList();

    return SeriesDetails(
      name: json['name'],
      nameId: json['name_id'],
      synopsis: json['synopsis'],
      status: json['status'],
      profileImageUrl: json['profile_image_url'],
      coverImageUrl: json['cover_image_url'],
      lastEpisode: json['last_episode'],
      episodes: episodesList,
    );
  }

  // Método para convertir a JSON (opcional)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'name_id': nameId,
      'synopsis': synopsis,
      'status': status,
      'profile_image_url': profileImageUrl,
      'cover_image_url': coverImageUrl,
      'last_episode': lastEpisode,
      'episodes': episodes.map((episode) => episode.toJson()).toList(),
    };
  }
}

