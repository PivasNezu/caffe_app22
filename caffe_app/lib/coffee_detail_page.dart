import 'package:flutter/material.dart';
import 'models/coffee_item.dart'; // чтобы использовать CoffeeItem

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  const Icon(Icons.notifications_outlined),
                ],
              ),
            ),

            // ---------- IMAGE ----------
            Container(
              height: 260,
              margin: const EdgeInsets.symmetric(horizontal: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Center(
                child: Image.network(
                  widget.item.imageUrl,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ---------- NAME + RATING ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.item.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
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
                          color: isSelected ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          children: [
                            Text(
                              sizeName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              price != null
                                  ? '\$${price}'
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
                  onPressed: () {},
                  child: const Text(
                    'Добавить',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
