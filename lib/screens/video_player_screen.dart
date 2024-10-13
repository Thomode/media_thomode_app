import 'package:flutter/material.dart';
import 'package:media_thomode_app/widgets/video_player_custom.dart';
import 'package:media_thomode_app/models/episode.dart';
import 'package:media_thomode_app/models/video_episode.dart';

class VideoPlayerScreen extends StatefulWidget {
  final Episode episode;
  final VideoEpisode videoEpisode;

  const VideoPlayerScreen({super.key, required this.episode,required this.videoEpisode});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reproducir'),
      ),
      body: Column(
        children: [
          VideoPlayerCustom(videoUrl: widget.videoEpisode.videoUrl),
          const SizedBox(height: 20),
          Text(
            widget.episode.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      )
      );
  }
}

