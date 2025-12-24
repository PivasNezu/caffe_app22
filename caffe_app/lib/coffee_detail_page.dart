import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../providers/location_provider.dart';
import '../../models/coffee_item.dart';
import '../../models/cart_item.dart';
import 'map.dart';

class CoffeeDetailPage extends StatefulWidget {
  final CoffeeItemSize item;

  const CoffeeDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  State<CoffeeDetailPage> createState() => _CoffeeDetailPageState();
}

class _CoffeeDetailPageState extends State<CoffeeDetailPage> {
  int selectedSize = 0;

  @override
  Widget build(BuildContext context) {
    final sizes = widget.item.prices.keys.toList();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 238, 186, 1),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            // ---------------- GEO LOCATION ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Consumer<LocationProvider>(
                builder: (_, locationProvider, __) {
                  final selectedPoint = locationProvider.selectedPoint;

                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MapPage()),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Локация',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF7B7166),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          selectedPoint != null
                              ? selectedPoint['name']
                              : 'Выберите локацию',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // ---------- COFFEE CARD ----------
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 28,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // IMAGE
                  Container(
                    height: 350,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 238, 186, 1),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(28),
                      ),
                    ),
                    child: Center(
                      child: Image.network(
                        widget.item.imageUrl,
                        height: 240,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // NAME + RATING
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 246, 218, 1),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(18),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.item.name,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 22,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              widget.item.rating.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ---------- SIZE SELECTOR ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 28,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  color: const Color.fromRGBO(255, 246, 218, 1),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final sizes = widget.item.prices.keys.take(5).toList();

                    return Row(
                      children: List.generate(sizes.length, (index) {
                        final size = sizes[index];
                        final isSelected = selectedSize == index;
                        final price = widget.item.prices[size];

                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() => selectedSize = index);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    size,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    price != null ? '$price ₽' : '-',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: isSelected
                                          ? Colors.white70
                                          : Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ),

            const Spacer(),

            // ---------- ADD BUTTON ----------
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    final sizeName = sizes[selectedSize];
                    final price = widget.item.prices[sizeName];

                    if (price == null) return;

                    final cartItem = CartItem(
                      id: widget.item.id,
                      name: widget.item.name,
                      imageUrl: widget.item.imageUrl,
                      size: sizeName,
                      price: price,
                      quantity: 1,
                    );

                    context.read<CartProvider>().addItem(cartItem);

                    Navigator.pop(context); // возвращаемся назад
                  },
                  child: const Text(
                    'Добавить',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
