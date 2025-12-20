import 'package:flutter/material.dart';

class CoffeeTextStyles {
  static TextStyle name = TextStyle(
    fontFamily: 'Montserrat',  // Убедитесь, что здесь правильное имя
    fontSize: 16,
    fontWeight: FontWeight.w700,  // Bold - должен соответствовать весу 700
    color: Colors.black87,
  );

  static TextStyle price = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w600,  // SemiBold - должен соответствовать весу 600
    color: Colors.black87,
  );

  static TextStyle rating = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w600,  // SemiBold
    color: Colors.black87,
  );
}
