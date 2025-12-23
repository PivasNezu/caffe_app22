class CartItem {
  final String id;        // id товара
  final String name;
  final String imageUrl;
  final String size;      // ВАЖНО
  final int price;        // цена за 1
  int quantity;           // количество

  CartItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.size,
    required this.price,
    required this.quantity,
  });
}
