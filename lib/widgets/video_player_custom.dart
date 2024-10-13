import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerCustom extends StatefulWidget {
  const VideoPlayerCustom({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  State<VideoPlayerCustom> createState() => _VideoPlayerCustomState();
}

class _VideoPlayerCustomState extends State<VideoPlayerCustom> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    // Inicializar el controlador de VideoPlayer
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));

    // Inicializar el controlador de Chewie
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      zoomAndPan: true
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9, // Mantener la relación de aspecto de 16:9
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}
