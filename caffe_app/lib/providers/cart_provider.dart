import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  bool _useBonus = false;

  List<CartItem> get items => _items;
  bool get useBonus => _useBonus;

  int get total {
    final sum = _items.fold(
      0,
      (prev, item) => prev + item.price * item.quantity,
    );
    return _useBonus ? sum - 100 : sum;
  }

  // ===== ДОБАВЛЕНО =====
  void clear() {
    _items.clear();
    _useBonus = false;
    notifyListeners();
  }

  // ===== ДОБАВЛЕНО =====
  void addFromOrder(CartItem item) {
    _items.add(
      CartItem(
        id: item.id,
        name: item.name,
        imageUrl: item.imageUrl,
        price: item.price,
        size: item.size,
        quantity: item.quantity,
      ),
    );
    notifyListeners();
  }

  // ===== СТАРОЕ =====
  void addItem(CartItem item) {
    final index = _items.indexWhere(
      (e) => e.id == item.id && e.size == item.size,
    );

    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(item);
    }

    notifyListeners();
  }

  void increment(String id, String size) {
    final item = _items.firstWhere(
      (e) => e.id == id && e.size == size,
    );
    item.quantity++;
    notifyListeners();
  }

  void decrement(String id, String size) {
    final index = _items.indexWhere(
      (e) => e.id == id && e.size == size,
    );

    if (index == -1) return;

    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }

    notifyListeners();
  }

  void toggleBonus(bool value) {
    _useBonus = value;
    notifyListeners();
  }
}
