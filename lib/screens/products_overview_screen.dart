// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../widgets/product_grid_view.dart';

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
      ),
      body: ProductGridView(),
    );
  }
}

