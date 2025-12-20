import 'package:flutter/material.dart';
import 'styles/coffee_text_styles.dart';
import 'package:caffe_app/ui/cart/cart_page.dart';

import 'map.dart';

void main() {
  runApp(const CoffeeShopApp());
}

// Модель данных для кофе
class CoffeeItem {
  final String id;
  final String name;
  final String price;
  final double rating;
  final String imageUrl;

  CoffeeItem({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });
}

// Имитация базы данных
class CoffeeDatabase {
  static Future<List<CoffeeItem>> getCoffeeItems() async {
    // Имитация задержки загрузки из БД
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      CoffeeItem(
        id: '1',
        name: 'Латте',
        price: '250 ₽',
        rating: 4.2,
        imageUrl:
            'https://images.unsplash.com/photo-1561882468-9110e03e0f78?w=400',
      ),
      CoffeeItem(
        id: '2',
        name: 'Капучино',
        price: '220 ₽',
        rating: 4.5,
        imageUrl:
            'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=400',
      ),
      CoffeeItem(
        id: '3',
        name: 'Эспрессо',
        price: '150 ₽',
        rating: 4.8,
        imageUrl:
            'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=400',
      ),
      CoffeeItem(
        id: '4',
        name: 'Американо',
        price: '180 ₽',
        rating: 4.3,
        imageUrl:
            'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=400',
      ),
      CoffeeItem(
        id: '5',
        name: 'Раф',
        price: '280 ₽',
        rating: 4.6,
        imageUrl:
            'https://images.unsplash.com/photo-1485808191679-5f86510681a2?w=400',
      ),
      CoffeeItem(
        id: '6',
        name: 'Флэт Уайт',
        price: '260 ₽',
        rating: 4.4,
        imageUrl:
            'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
      ),
    ];
  }

  static Future<List<CoffeeItem>> getDrinks() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      CoffeeItem(
        id: '7',
        name: 'Чай',
        price: '120 ₽',
        rating: 4.1,
        imageUrl:
            'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=400',
      ),
      CoffeeItem(
        id: '8',
        name: 'Какао',
        price: '200 ₽',
        rating: 4.7,
        imageUrl:
            'https://images.unsplash.com/photo-1542990253-0d0f5be5f0ed?w=400',
      ),
    ];
  }

  static Future<List<CoffeeItem>> getDesserts() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      CoffeeItem(
        id: '9',
        name: 'Круассан',
        price: '180 ₽',
        rating: 4.5,
        imageUrl:
            'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=400',
      ),
      CoffeeItem(
        id: '10',
        name: 'Чизкейк',
        price: '320 ₽',
        rating: 4.9,
        imageUrl:
            'https://images.unsplash.com/photo-1524351199678-941a58a3df50?w=400',
      ),
    ];
  }
}

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color.fromRGBO(255, 238, 186, 1),
        fontFamily: 'Montserrat',
      ),
      home: const CoffeeShopPage(),
    );
  }
}

class CoffeeShopPage extends StatefulWidget {
  const CoffeeShopPage({Key? key}) : super(key: key);

  @override
  State<CoffeeShopPage> createState() => _CoffeeShopPageState();
}

class _CoffeeShopPageState extends State<CoffeeShopPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, dynamic>? selectedPoint;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTabButton(String text, int index) {
    final isSelected = _tabController.index == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _tabController.animateTo(index);
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700, // Bold
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Заголовок с кнопками
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  // Левая кнопка-заглушка
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          // Заглушка для левой кнопки
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Левая кнопка нажата'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.menu,
                          color: Colors.black54,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  // Локация по центру (кликабельная)
                  Expanded(
                    child: Center(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () async {
                          final selectedPoint = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MapPage()),
                          );

                          if (selectedPoint != null) {
                            // Используем выбранную точку
                            print('Выбранная точка: ${selectedPoint['name']}');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Вы выбрали: ${selectedPoint['name']}',
                                ),
                              ),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'локация',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600, // SemiBold
                                  color: Color(0xFF7B7166), // #7B7166
                                ),
                              ),
                              Text(
                                selectedPoint != null
                                    ? selectedPoint!['name'] // название выбранной точки
                                    : 'Выберите локацию', // текст по умолчанию
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Правая кнопка-заглушка
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          // Заглушка для правой кнопки
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Правая кнопка нажата'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.notifications_outlined,
                          color: Colors.black54,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Табы с овальными кнопками
            Container(
              height: 44,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(child: _buildTabButton('Кофе', 0)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildTabButton('Другие напитки', 1)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildTabButton('Десерты', 2)),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Список товаров
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Вкладка "Кофе"
                  CoffeeListView(futureItems: CoffeeDatabase.getCoffeeItems()),
                  // Вкладка "Другие напитки"
                  CoffeeListView(futureItems: CoffeeDatabase.getDrinks()),
                  // Вкладка "Десерты"
                  CoffeeListView(futureItems: CoffeeDatabase.getDesserts()),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const CartPage()),
  );
            },
            child: const Icon(
              Icons.arrow_outward,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}

// Виджет для отображения списка товаров с загрузкой из БД
class CoffeeListView extends StatelessWidget {
  final Future<List<CoffeeItem>> futureItems;

  const CoffeeListView({Key? key, required this.futureItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CoffeeItem>>(
      future: futureItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text('Ошибка загрузки: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Нет доступных товаров'));
        }

        final items = snapshot.data!;

        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 2.0,
            mainAxisSpacing: 16,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return CoffeeCard(
              name: item.name,
              price: item.price,
              rating: item.rating,
              imageUrl: item.imageUrl,
            );
          },
        );
      },
    );
  }
}

class CoffeeCard extends StatelessWidget {
  final String name;
  final String price;
  final double rating;
  final String imageUrl;

  const CoffeeCard({
    Key? key,
    required this.name,
    required this.price,
    required this.rating,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 238, 186, 1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            spreadRadius: 1, // Расширяем тень
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Изображение товара по центру
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                          color: Colors.black,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.coffee,
                          size: 50,
                          color: Colors.brown[300],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          // Карточка с информацией
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 246, 218, 1),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Левая часть: Название и цена
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Название товара
                      Text(name, style: CoffeeTextStyles.name),
                      const SizedBox(height: 4),
                      // Строка с ценой и рейтингом
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Цена
                          Text(price, style: CoffeeTextStyles.price),
                          // Рейтинг
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                rating.toString(),
                                style: CoffeeTextStyles.rating,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
