import 'package:flutter/material.dart';
import 'package:media_thomode_app/models/episode.dart';
import 'package:media_thomode_app/models/video_episode.dart';
import 'package:media_thomode_app/screens/video_player_screen.dart';
import 'package:media_thomode_app/screens/video_webview_screen.dart';
import 'package:media_thomode_app/services/series_service.dart';

class VideoServersScreen extends StatefulWidget {
  final String seriesType;
  final Episode episode;
  final String lastEpisode;

  const VideoServersScreen({super.key, required this.seriesType, required this.episode, required this.lastEpisode});

  @override
  State<VideoServersScreen> createState() => _VideoServersScreenState();
}

class _VideoServersScreenState extends State<VideoServersScreen> {
  bool _isLoading = true;
  List<VideoEpisode> _servers = [];

  @override
  void initState() {
    super.initState();
    _fetchVideoServers();
  }

  Future<void> _fetchVideoServers() async {
    final SeriesService _seriesService = SeriesService();
    try {
      // Llama al servicio para obtener la lista de servidores de video
      List<VideoEpisode> servers = await _seriesService.getVideoServers(
          widget.seriesType,
          widget.episode.seriesNameId,
          widget.episode.episodeId
      );

      setState(() {
        _servers = servers; // Asignar la lista de servidores obtenida
        _isLoading = false; // Desactivar la carga
      });

    } catch (e) {
      // Manejo de errores
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar los servidores: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servidores'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _servers.isNotEmpty
          ? Column(
        children: [
          // Mostrar el título del episodio
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.episode.title,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),

          // Listado de servidores en un ListView.builder
          Expanded(
            child: ListView.builder(
              itemCount: _servers.length,
              itemBuilder: (context, index) {
                final server = _servers[index];
                return GestureDetector(
                  onTap: () {
                    if (server.videoDirect){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoPlayerScreen(
                                episode: widget.episode,
                                videoEpisode: server
                            )
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoWebViewScreen(
                                episode: widget.episode,
                                videoEpisode: server
                            )
                        ),
                      );
                    }
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    elevation: 4,
                    child: ListTile(
                        title: Text(server.serverName, style: const TextStyle(fontSize: 20),),
                        subtitle: Text(
                            'Directo: ${server.videoDirect ? "Sí" : "No"}'),
                        trailing: const Icon(Icons.play_arrow)
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )
          : const Center(
        child: Text('No se pudo cargar el video'),
      ),
    );
  }
}




