// ignore_for_file: sort_child_properties_last, prefer_const_constructors, non_constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/Product_model_provider.dart';
import '../screens/product_details.dart';
import '../provider/cart_provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductReceived = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetails.routeName,
              arguments: ProductReceived.id,
            );
          },
          child: Image.network(
            ProductReceived.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            color: Color.fromRGBO(255, 190, 57, 1),
            icon: Consumer<Product>(
              builder: (context, value, _) => Icon(
                ProductReceived.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
              ),
            ),
            onPressed: () => ProductReceived.isFavouriteToggle(),
          ),
          title: Text(
            ProductReceived.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(
                ProductReceived.id,
                ProductReceived.price,
                ProductReceived.title,
              );
            },
          ),
        ),
      ),
    );
  }
}
