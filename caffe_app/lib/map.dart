import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String? selectedPointId;

  final List<Map<String, dynamic>> points = [
    {'id': '1', 'name': 'Точка 1', 'lat': 55.624378, 'lon': 37.714321},
    {'id': '2', 'name': 'Точка 2', 'lat': 55.622426, 'lon': 37.717231},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Выберите точку')),
      body: YandexMap(
        mapObjects: points.map((point) {
          return PlacemarkMapObject(
            mapId: MapObjectId(point['id']),
            point: Point(latitude: point['lat'], longitude: point['lon']),
            onTap: (mapObject, pointTap) {
              // Сохраняем выбранную точку
              selectedPointId = point['id'];

              // Возврат на предыдущий экран с результатом
              Navigator.pop(context, {
                'id': point['id'],
                'name': point['name'],
                'lat': point['lat'],
                'lon': point['lon'],
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
