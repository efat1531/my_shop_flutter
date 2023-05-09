// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_shop/provider/product_provider.dart';
import 'package:provider/provider.dart';
import './products_item.dart';

class ProductGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final products = productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: ((context, index) => ProductItem(
            products[index].title,
            products[index].imageUrl,
            products[index].id,
          )),
      itemCount: products.length,
    );
  }
}
