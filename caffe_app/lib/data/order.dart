import '../models/history_order.dart';

final mockOrders = [
  Order(
    id: 'Заказ 1',
    date: DateTime.now().subtract(const Duration(days: 1)),
    items: [
      OrderItem(
        id: '1',
        name: 'Латте',
        imageUrl:
            'https://images.unsplash.com/photo-1561882468-9110e03e0f78?w=400',
        price: 250,
        size: 'M',
        quantity: 1,
      ),
      OrderItem(
        id: '2',
        name: 'Латте',
        imageUrl:
            'https://images.unsplash.com/photo-1561882468-9110e03e0f78?w=400',
        price: 250,
        size: 'S',
        quantity: 2,
      ),
    ],
  ),
  Order(
    id: 'Заказ 2',
    date: DateTime.now().subtract(const Duration(days: 3)),
    items: [
      OrderItem(
        id: '3',
        name: 'Латте',
        imageUrl:
            'https://images.unsplash.com/photo-1561882468-9110e03e0f78?w=400',
        price: 340,
        size: 'L',
        quantity: 1,
      ),
    ],
  ),
];
