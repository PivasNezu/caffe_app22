import 'package:flutter/material.dart';
import '../data/cart_repository.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final CartRepository repository;

  CartProvider(this.repository);

  List<CartItem> _items = [];
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

  Future<void> loadCart() async {
    _items = await repository.fetchCartItems();
    notifyListeners();
  }

  void increment(String id) {
    final item = _items.firstWhere((e) => e.id == id);
    item.quantity++;
    notifyListeners();
    repository.updateQuantity(id, item.quantity);
  }

  void decrement(String id) {
    final index = _items.indexWhere((e) => e.id == id);
    if (index == -1) return;

    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index); // 🔥 удаление при 0
    }

    notifyListeners();
  }

  void toggleBonus(bool value) {
    _useBonus = value;
    notifyListeners();
  }
}
