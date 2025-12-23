import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'styles/coffee_text_styles.dart';
import 'package:caffe_app/ui/cart/cart_page.dart';
import 'map.dart';
import 'providers/cart_provider.dart';
import 'models/coffee_item.dart';
import 'coffee_detail_page.dart';
import 'data/coffee_database.dart';

class CoffeeShopAppWrapper extends StatelessWidget {
  const CoffeeShopAppWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CartProvider())],
      child: const CoffeeShopApp(),
    );
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

    _tabController.addListener(() {
      if (_tabController.indexIsChanging == false) {
        setState(() {});
      }
    });
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
            fontWeight: FontWeight.w700,
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
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF7B7166),
                                ),
                              ),
                              Text(
                                selectedPoint != null
                                    ? selectedPoint!['name']
                                    : 'Выберите локацию',
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
                  CoffeeListView(futureItems: CoffeeDatabase.getCoffeeItems()),
                  CoffeeListView(futureItems: CoffeeDatabase.getDrinks()),
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

class CoffeeListView extends StatelessWidget {
  final Future<List<CoffeeItemSize>> futureItems;

  const CoffeeListView({Key? key, required this.futureItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CoffeeItemSize>>(
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
            return CoffeeCard(item: item);
          },
        );
      },
    );
  }
}

class CoffeeCard extends StatelessWidget {
  final CoffeeItemSize item;

  const CoffeeCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final priceS = item.prices['S'] ?? 0;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CoffeeDetailPage(item: item)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 238, 186, 1),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      item.imageUrl,
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name, style: CoffeeTextStyles.name),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('$priceS ₽', style: CoffeeTextStyles.price),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.amber,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  item.rating.toString(),
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
      ),
    );
  }
}
