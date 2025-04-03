import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FleetMapsScreen extends StatelessWidget {
  const FleetMapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(-29.9200, -51.1800), // Latitude e longitude de Canoas
          initialZoom: 13.0, // Nível de zoom inicial
        ),
        children: [
          // Camada do mapa
          TileLayer(
            urlTemplate: 'https://osm.crearecloud.com.br/tiles/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          // Marcador para a localização inicial
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(-29.9200, -51.1800), // Localização de Canoas
                child: const Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: 40.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}