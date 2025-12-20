import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 246, 218, 1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          ...cart.items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.name),
                  Text('${item.price * item.quantity} ₽'),
                ],
              ),
            ),
          ),

          const Divider(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Итого',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${cart.total} ₽',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
