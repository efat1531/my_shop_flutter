// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../widgets/product_grid_view.dart';

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
        title: Text('My Shop'),
        actions: [
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
      body: ProductGridView(_showFavourites),
    );
  }
}
