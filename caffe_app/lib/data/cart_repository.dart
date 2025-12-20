import '../models/cart_item.dart';

class CartRepository {
  /// ВРЕМЕННО mock
  /// Потом заменишь на SQLite / API
  Future<List<CartItem>> fetchCartItems() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      CartItem(
        id: '1',
        name: 'Латте',
        price: 250,
        quantity: 1,
        imageUrl: '',
      ),
      CartItem(
        id: '2',
        name: 'Латте',
        price: 250,
        quantity: 1,
        imageUrl: '',
      ),
      CartItem(
        id: '3',
        name: 'Латте',
        price: 250,
        quantity: 1,
        imageUrl: '',
      ),
    ];
  }

  Future<void> updateQuantity(String id, int quantity) async {
    // TODO: UPDATE cart SET quantity = ?
  }
}
