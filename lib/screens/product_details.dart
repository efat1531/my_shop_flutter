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
          crossAxisAlignment: CrossAxisAlignment.start,
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
              height: 8,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 5.0),
              width: double.infinity,
              child: Text(
                'Price: ${loadedProduct.price} TK',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              child: Text(
                'Description:',
                //textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
