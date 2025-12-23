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

  static Future<List<CoffeeItemSize>> getDrinks() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      CoffeeItemSize(
        id: '3',
        name: 'Чай',
        rating: 4.1,
        imageUrl:
            'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=400',
        prices: {'S': 120, 'M': 180, 'L': 220},
      ),
      CoffeeItemSize(
        id: '4',
        name: 'Какао',
        rating: 4.7,
        imageUrl:
            'https://images.unsplash.com/photo-1542990253-0d0f5be5f0ed?w=400',
        prices: {'S': 200, 'M': 280, 'L': 350},
      ),
    ];
  }

  static Future<List<CoffeeItemSize>> getDesserts() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      CoffeeItemSize(
        id: '5',
        name: 'Круассан',
        rating: 4.5,
        imageUrl:
            'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=400',
        prices: {'S': 180, 'M': 250, 'L': 300},
      ),
      CoffeeItemSize(
        id: '6',
        name: 'Чизкейк',
        rating: 4.9,
        imageUrl:
            'https://images.unsplash.com/photo-1524351199678-941a58a3df50?w=400',
        prices: {'S': 320, 'M': 400, 'L': 480},
      ),
    ];
  }
}
