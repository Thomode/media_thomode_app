class Episode {
  final String title;
  final String seriesNameId;
  final String episodeId;

  Episode({
    required this.title,
    required this.seriesNameId,
    required this.episodeId,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      title: json['title'],
      seriesNameId: json['series_name_id'],
      episodeId: json['episode_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'series_name_id': seriesNameId,
      'episode_id': episodeId,
    };
  }
}

