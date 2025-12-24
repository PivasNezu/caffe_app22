class OrderItem {
  final String id;
  final String name;
  final String imageUrl;
  final int price;
  final String size;
  final int quantity;

  OrderItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.size,
    required this.quantity,
  });
}

class Order {
  final String id;
  final DateTime date;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.date,
    required this.items,
  });

  int get totalPrice {
    return items.fold(
      0,
      (sum, item) => sum + item.price * item.quantity,
    );
  }
}