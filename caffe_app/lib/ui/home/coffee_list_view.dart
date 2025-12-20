import 'package:flutter/material.dart';
import 'package:caffe_app/models/coffee_item.dart';
import 'package:caffe_app/coffee_detail_page.dart';
import 'coffee_card.dart';

class CoffeeListView extends StatelessWidget {
  final Future<List<CoffeeItemSize>> futureItems;

  const CoffeeListView({Key? key, required this.futureItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CoffeeItemSize>>(
      future: futureItems,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
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
            return CoffeeCard(item: items[index]);
          },
        );
      },
    );
  }
}
