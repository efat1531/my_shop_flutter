import 'package:flutter/material.dart';
import 'package:my_shop/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  static String routeName = '/productdetail';

  @override
  Widget build(BuildContext context) {
    final String ProductId =
        ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<ProductProvider>(context, listen: false)
        .FindById(ProductId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 10.0,
              ),
              height: 300,
              width: double.infinity,
              child:
                  Image.network(loadedProduct.imageUrl, fit: BoxFit.fitHeight),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin:const EdgeInsets.all(10),
              padding:const EdgeInsets.symmetric(vertical: 4.0, horizontal: 5.0),
              child: Text(
                'Price: ${loadedProduct.price} TK',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
