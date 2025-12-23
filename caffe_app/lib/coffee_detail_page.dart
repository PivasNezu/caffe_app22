import 'package:flutter/material.dart';
import 'models/coffee_item.dart'; // чтобы использовать CoffeeItem
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../models/cart_item.dart';

class CoffeeDetailPage extends StatefulWidget {
  final CoffeeItemSize item;

  const CoffeeDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  State<CoffeeDetailPage> createState() => _CoffeeDetailPageState();
}

class _CoffeeDetailPageState extends State<CoffeeDetailPage> {
  int selectedSize = 1;

  final sizes = ['S', 'M', 'L'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 238, 186, 1),
      body: SafeArea(
        child: Column(
          children: [
            // ---------- HEADER ----------
            const SizedBox(height: 42), // небольшой отступ вместо удалённого Row

            // ---------- COFFEE CARD ----------
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // --- TOP (IMAGE) ---
                  Container(
                    height: 220,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 238, 186, 1),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Image.network(
                        widget.item.imageUrl,
                        height: 180,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // --- BOTTOM (NAME + RATING) ---
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 246, 218, 1),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.item.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.item.rating.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
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
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: List.generate(sizes.length, (index) {
                  final sizeName = sizes[index]; // название размера
                  final isSelected = selectedSize == index;
                  final price = widget
                      .item
                      .prices[sizeName]; // цена для выбранного размера

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSize = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.black
                              : Color.fromRGBO(255, 246, 218, 1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          children: [
                            Text(
                              sizeName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? Color.fromRGBO(255, 246, 218, 1)
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              price != null
                                  ? '${price} ₽'
                                  : '-', // проверка на null
                              style: TextStyle(
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
