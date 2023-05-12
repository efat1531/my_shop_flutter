// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/badge.dart';
import '../widgets/product_grid_view.dart';
import '../provider/cart_provider.dart';
import './cart_screen.dart';
import '../widgets/app_drawer.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavourites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _showFavourites?Text('Your Favourites'):Text('All Items'),
        actions: [
          Consumer<Cart>(
            builder: (context, cart, ch) => Badge(
              child: ch!,
              color: Color.fromRGBO(255, 114, 67, 1),
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions value) {
              setState(
                () {
                  if (value == FilterOptions.Favourites) {
                    _showFavourites = true;
                  } else if (value == FilterOptions.All) {
                    _showFavourites = false;
                  }
                },
              );
            },
            itemBuilder: ((context) => [
                  PopupMenuItem(
                    child: Text('Only Favourites'),
                    value: FilterOptions.Favourites,
                  ),
                  PopupMenuItem(
                    child: Text('Show All Items'),
                    value: FilterOptions.All,
                  ),
                ]),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductGridView(_showFavourites),
    );
  }
}
