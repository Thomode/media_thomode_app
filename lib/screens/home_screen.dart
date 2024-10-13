import 'package:flutter/material.dart';
import 'package:media_thomode_app/models/series.dart';
import 'package:media_thomode_app/services/series_service.dart';
import 'package:media_thomode_app/widgets/series_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SeriesService _seriesService = SeriesService();
  List<Series> _seriesList = [];
  bool _isLoading = false;
  String _searchText = '';
  String _seriesType = 'anime'; // Inicializamos con 'anime' como valor por defecto
  final List<String> _seriesTypes = ['anime', 'donghua']; // Lista de tipos de serie

  // Función para buscar series
  Future<void> _searchSeries() async {
    if (_searchText.isEmpty) return;

    setState(() {
      _isLoading = true; // Mostrar el indicador de carga
    });

    try {
      List<Series> results = await _seriesService.searchSeries(_seriesType, _searchText);

      setState(() {
        _seriesList = results; // Actualizar la lista con los resultados
      });
    } catch (e) {
      print('Error al buscar series: $e');
    } finally {
      setState(() {
        _isLoading = false; // Ocultar el indicador de carga
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Media Thomode"),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            // Campo de búsqueda
            TextField(
              onChanged: (value) {
                _searchText = value; // Actualizar el valor del texto
              },
              onSubmitted: (value) {
                _searchText = value;
                _searchSeries();
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                hintText: "Buscar serie",
                suffixIcon: IconButton(
                  onPressed: _searchSeries, // Llamar a la función de búsqueda
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Selector de tipo de serie utilizando Chips
            Center(
              child: Wrap(
                spacing: 8.0,
                children: List<Widget>.generate(_seriesTypes.length, (int index) {
                  return ChoiceChip(
                    label: Text(_seriesTypes[index]),
                    selected: _seriesType == _seriesTypes[index],
                    onSelected: (bool selected) {
                      setState(() {
                        _seriesType = selected ? _seriesTypes[index] : _seriesType;
                      });
                      _searchSeries(); // Opcional: realizar la búsqueda al cambiar el tipo
                    },
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 10), // Espacio entre el selector y el Grid

            // Cuerpo principal que muestra los resultados o el indicador de carga
            _isLoading
                ? const Center(child: CircularProgressIndicator(),)
                : _seriesList.isNotEmpty
                ? LayoutBuilder(
              builder: (context, constraints) {
                // Calculamos el número de columnas según el ancho de la pantalla
                int columns = constraints.maxWidth > 600 ? 3 : 2; // Más de 600px, 3 columnas; de lo contrario, 2
                double aspectRatio = 0.65; // Ajustar la relación de aspecto de la tarjeta

                return GridView.builder(
                  shrinkWrap: true, // Permite que el GridView se ajuste a su contenido
                  physics: const NeverScrollableScrollPhysics(), // Desactiva el desplazamiento del GridView
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    childAspectRatio: aspectRatio, // Ajusta este valor para una mejor visualización
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: _seriesList.length,
                  itemBuilder: (context, index) {
                    return SeriesCard(seriesType: _seriesType, series: _seriesList[index]);
                  },
                );
              },
            )
                : const Center(
              child: Text('No se encontraron resultados'),
            ),
          ],
        ),
      ),
    );
  }
}




