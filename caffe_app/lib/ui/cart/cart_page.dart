import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_item_card.dart';
import 'cart_summary.dart';



import '../../../providers/cart_provider.dart';
import '../../../models/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _CartView();
  }
}

class _CartView extends StatelessWidget {
  const _CartView();

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 238, 186, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Корзина',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 24),

              Expanded(
                child: ListView.separated(
                  itemCount: cart.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return CartItemCard(item: cart.items[index]);
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Использовать бонусы',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Checkbox(
                    value: cart.useBonus,
                    activeColor: Colors.orange,
                    onChanged: (v) => cart.toggleBonus(v ?? false),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              const CartSummary(),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Заказать',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
