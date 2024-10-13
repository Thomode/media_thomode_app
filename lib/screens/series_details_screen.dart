import 'package:flutter/material.dart';
import 'package:media_thomode_app/models/series_details.dart';
import 'package:media_thomode_app/services/series_service.dart';
import 'package:media_thomode_app/widgets/episode_card.dart';

class SeriesDetailsScreen extends StatefulWidget {
  final String seriesType;
  final String nameId;

  const SeriesDetailsScreen({super.key, required this.seriesType, required this.nameId});

  @override
  State<SeriesDetailsScreen> createState() => _SeriesDetailsScreenState();
}

class _SeriesDetailsScreenState extends State<SeriesDetailsScreen> {
  final SeriesService _seriesService = SeriesService();
  SeriesDetails? _seriesDetails;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _getSeriesDetails();
  }

  Future<void> _getSeriesDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';  // Resetea el mensaje de error antes de la nueva carga
    });

    try {
      SeriesDetails details = await _seriesService.getSeriesDetails(widget.seriesType, widget.nameId);
      setState(() {
        _seriesDetails = details;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al cargar los detalles de la serie';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles"),
      ),
      body: RefreshIndicator(  // Colocamos el RefreshIndicator al inicio del body
        onRefresh: _getSeriesDetails, // Acción de refrescar al deslizar hacia abajo
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage.isNotEmpty
            ? SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),  // Permite el deslizamiento incluso cuando no hay contenido
          child: SizedBox(
            height: MediaQuery.of(context).size.height,  // Para que el scroll siempre sea posible
            child: Center(child: Text(_errorMessage)),
          ),
        )
            : _seriesDetails == null
            ? SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),  // Permite el deslizamiento para refrescar
          child: SizedBox(
            height: MediaQuery.of(context).size.height,  // Ajuste para ocupar toda la pantalla
            child: const Center(child: Text('No se encontraron detalles.')),
          ),
        )
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen de perfil
              if (_seriesDetails!.profileImageUrl.isNotEmpty)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0), // Ajusta el valor para cambiar el radio
                    child: SizedBox(
                      width: 200,  // Ajusta el ancho
                      height: 300, // Ajusta la altura
                      child: Image.network(
                        _seriesDetails!.profileImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 20),

              // Nombre de la serie
              Center(
                child: Text(
                  _seriesDetails!.name,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              // Sinopsis
              Text(
                _seriesDetails!.synopsis,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Estado de la serie
              Text(
                'Estado: ${_seriesDetails!.status}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Lista de episodios
              const Text(
                'Episodios:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Lista de episodios
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(), // Deshabilitar desplazamiento en esta lista
                shrinkWrap: true, // Hacer que la lista se ajuste al contenido
                itemCount: _seriesDetails!.episodes.length,
                itemBuilder: (context, index) {
                  return EpisodeCard(
                    seriesType: widget.seriesType,
                    episode: _seriesDetails!.episodes[index],
                    lastEpisode: _seriesDetails!.lastEpisode,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}





