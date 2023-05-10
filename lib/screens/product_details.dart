import 'package:flutter/material.dart';
import 'package:my_shop/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  static String routeName = '/productdetail';

  @override
  Widget build(BuildContext context) {
    final String ProductId =
        ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct =
        Provider.of<ProductProvider>(context,listen: false).FindById(ProductId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: Center(
        child: Text(loadedProduct.price.toString()),
      ),
    );
  }
}
