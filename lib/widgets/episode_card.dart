import 'package:flutter/material.dart';
import 'package:media_thomode_app/models/episode.dart';
import 'package:media_thomode_app/screens/video_player_screen.dart';
import 'package:media_thomode_app/screens/video_servers_screen.dart';

class EpisodeCard extends StatelessWidget {
  final String seriesType;
  final Episode episode;
  final String lastEpisode;

  const EpisodeCard({super.key, required this.seriesType,required this.episode, required this.lastEpisode});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navega al VideoPlayerScreen pasando el episodio y lastEpisode
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoServersScreen(
                seriesType: seriesType,
                episode: episode,
                lastEpisode: lastEpisode
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título del episodio
              Text(
                episode.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



