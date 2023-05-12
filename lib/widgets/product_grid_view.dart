// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import '../provider/product_provider.dart';
import 'package:provider/provider.dart';
import './products_item.dart';

class ProductGridView extends StatelessWidget {
  final bool _showFavourites;
  ProductGridView(this._showFavourites);
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final products = _showFavourites?productData.favouriteItems:productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: ((context, index) => ChangeNotifierProvider.value(
            value: products[index],
            child: ProductItem(),
          )),
      itemCount: products.length,
    );
  }
}
