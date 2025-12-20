class CartItem {
  final String id;
  final String name;
  final int price; // В КОПЕЙКАХ / РУБЛЯХ — ЧИСЛО
  final String imageUrl;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });
}
