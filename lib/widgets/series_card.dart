import 'package:flutter/material.dart';
import 'package:media_thomode_app/models/series.dart';
import 'package:media_thomode_app/screens/series_details_screen.dart';

class SeriesCard extends StatelessWidget {
  final String seriesType;
  final Series series;

  const SeriesCard({super.key, required this.seriesType, required this.series});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SeriesDetailsScreen(seriesType: seriesType, nameId: series.nameId),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen de la serie
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: AspectRatio(
                aspectRatio: 7 / 8, // Ajusta el aspecto de la imagen
                child: Image.network(
                  series.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error), // Mostrar un ícono si falla la carga de la imagen
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre de la serie
                  Text(
                    series.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

