import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier {
  String _location = 'Выберите локацию';

  String get location => _location;

  void setLocation(String value) {
    _location = value;
    notifyListeners();
  }
}
