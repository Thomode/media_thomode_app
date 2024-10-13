class VideoEpisode {
  String seriesNameId;
  String episodeId;
  String videoUrl;
  bool videoDirect;
  String serverName;

  VideoEpisode({
    required this.seriesNameId,
    required this.episodeId,
    required this.videoUrl,
    required this.videoDirect,
    required this.serverName,
  });

  factory VideoEpisode.fromJson(Map<String, dynamic> json) {
    return VideoEpisode(
      seriesNameId: json['series_name_id'],
      episodeId: json['episode_id'],
      videoUrl: json['video_url'],
      videoDirect: json['video_direct'],
      serverName: json['server_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'series_name_id': seriesNameId,
      'episode_id': episodeId,
      'video_url': videoUrl,
      'video_direct': videoDirect,
      'server_name': serverName,
    };
  }
}
