import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier {
  Map<String, dynamic>? _selectedPoint;

  Map<String, dynamic>? get selectedPoint => _selectedPoint;

  void setLocation(Map<String, dynamic> point) {
    _selectedPoint = point;
    notifyListeners();
  }
}
