import '../models/coffee_item.dart';

class CoffeeDatabase {
  static Future<List<CoffeeItemSize>> getCoffeeItems() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      CoffeeItemSize(
        id: '1',
        name: 'Латте',
        rating: 4.2,
        imageUrl:
            'https://images.unsplash.com/photo-1561882468-9110e03e0f78?w=400',
        prices: {'S': 250, 'M': 340, 'L': 520},
      ),
      CoffeeItemSize(
        id: '2',
        name: 'Капучино',
        rating: 4.5,
        imageUrl:
            'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=400',
        prices: {'S': 230, 'M': 310, 'L': 470},
      ),
    ];
  }
}
