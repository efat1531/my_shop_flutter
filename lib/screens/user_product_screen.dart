import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';
import '../widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static String routeName = '/user_product';
  @override
  Widget build(BuildContext context) {
    final pProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your product Screen'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_circle_outline_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (context, index) => Column(
            children: [
              UserProductItem(
                title: pProvider.items[index].title,
                imageURL: pProvider.items[index].imageUrl,
              ),
              Divider(),
            ],
          ),
          itemCount: pProvider.items.length,
        ),
      ),
    );
  }
}
