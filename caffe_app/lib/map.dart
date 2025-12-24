import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../providers/location_provider.dart'; // используем существующий провайдер

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final List<Map<String, dynamic>> points = [
    {'id': '1', 'name': 'Точка 1', 'lat': 55.624378, 'lon': 37.714321},
    {'id': '2', 'name': 'Точка 2', 'lat': 55.622426, 'lon': 37.717231},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Выберите точку')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(55.623, 37.715),
          initialZoom: 15.0,
        ),
        children: [
          // Карта OpenStreetMap
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.app',
          ),

          // Слой маркеров
          MarkerLayer(
            markers: points.map((point) {
              return Marker(
                point: LatLng(point['lat'], point['lon']),
                width: 50,
                height: 50,
                child: GestureDetector(
                  onTap: () {
                    Provider.of<LocationProvider>(
                      context,
                      listen: false,
                    ).setLocation(point); // сохраняем всю точку
                    Navigator.pop(context); // возвращаемся назад
                  },
                  child: const Icon(
                    Icons.location_on,
                    size: 40,
                    color: Colors.red,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
