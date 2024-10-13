import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Necesario para SystemChrome
import 'package:media_thomode_app/models/episode.dart';
import 'package:media_thomode_app/models/video_episode.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoWebViewScreen extends StatefulWidget {
  final Episode episode;
  final VideoEpisode videoEpisode;

  const VideoWebViewScreen({super.key, required this.episode, required this.videoEpisode});

  @override
  State<VideoWebViewScreen> createState() => _VideoWebViewScreenState();
}

class _VideoWebViewScreenState extends State<VideoWebViewScreen> {
  late final WebViewController _controller;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    // Inicializamos el controlador de WebView
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Habilitar JavaScript
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (_isAdUrl(request.url)) {
              print('Bloqueado: ${request.url}');
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.videoEpisode.videoUrl)); // Cargar la URL del video
  }

  // Función para detectar URLs de publicidad o indeseadas
  bool _isAdUrl(String url) {
    final adPatterns = [
      'ads', // Bloquear URLs que contienen 'ads'
      'doubleclick.net', // Un dominio publicitario común
      'popup', // Redireccionamientos de popups
      'tracker',
      'banner',
      'redirect'
    ];

    for (var pattern in adPatterns) {
      if (url.contains(pattern)) {
        return true;
      }
    }
    return false;
  }

  Future<void> _goToMainPage() async {
    await _controller.loadRequest(Uri.parse(widget.videoEpisode.videoUrl));
  }

  void _enterFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); // Modo pantalla completa
  }

  void _exitFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values); // Restaurar la barra
  }

  void _toggleFullScreen() {
    setState(() {
      if (_isFullScreen) {
        _exitFullScreen();
      } else {
        _enterFullScreen();
      }
      _isFullScreen = !_isFullScreen;
    });
  }

  @override
  void dispose() {
    _exitFullScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reproducir'),
        actions: [
          IconButton(
            icon: Icon(_isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen), // Cambiar ícono dependiendo del estado
            onPressed: () {
              _toggleFullScreen(); // Alternar entre entrar/salir de pantalla completa
            },
          ),
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () async {
              await _goToMainPage(); // Regresar a la página principal cuando se presiona el ícono de "home"
            },
          ),
        ],
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9, // Ajusta el aspecto según la relación del video
          child: WebViewWidget(controller: _controller), // Uso de WebViewWidget
        ),
      ),
    );
  }
}







