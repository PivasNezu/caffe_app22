import 'package:flutter/material.dart';
import 'package:caffe_app/data/coffee_database.dart';
import 'coffee_list_view.dart';

class CoffeeShopPage extends StatelessWidget {
  const CoffeeShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              'локация\nГенерала Белова',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: CoffeeListView(
                futureItems: CoffeeDatabase.getCoffeeItems(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
