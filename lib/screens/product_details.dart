import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  static String routeName = '/productdetail';

  @override
  Widget build(BuildContext context) {
    final String ProductId =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: Center(
        child: Text(ProductId),
      ),
    );
  }
}
