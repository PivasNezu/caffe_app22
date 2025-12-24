import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:caffe_app/models/history_order.dart';
import 'package:caffe_app/models/cart_item.dart';
import 'package:caffe_app/providers/cart_provider.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 238, 186, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 238, 186, 1),
        elevation: 0,
        automaticallyImplyLeading: false, // стрелку убираем
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0), // небольшой отступ сверху
          child: Text(
            order.id, // показываем id заказа
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
        ),
      ),

      // ====== СПИСОК ТОВАРОВ ======
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: order.items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final item = order.items[index];

          return Container(
            height: 140,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 246, 218, 1),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                // Левая часть (картинка)
                Container(
                  width: 110,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 238, 186, 1),
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Image.network(
                      item.imageUrl,
                      height: 70,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.coffee, size: 40),
                    ),
                  ),
                ),

                // Правая часть
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Название
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Цена под названием
                        Text(
                          '${item.price} ₽',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Spacer(),
                        // Количество снизу
                        Text(
                          'x${item.quantity}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),

      // ====== КНОПКА "ПОВТОРИТЬ" ======
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () {
            final cart = context.read<CartProvider>();

            // Очистить корзину
            cart.clear();

            // Заполнить корзину товарами из заказа
            for (final item in order.items) {
              cart.addFromOrder(
                CartItem(
                  id: item.id,
                  name: item.name,
                  imageUrl: item.imageUrl,
                  price: item.price,
                  size: item.size,
                  quantity: item.quantity,
                ),
              );
            }

            // Вернуться в главное приложение
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Повторить',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
