import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';
import '../widgets/user_product_item.dart';
import '../screens/edit_products.dart';

class UserProductScreen extends StatelessWidget {
  static String routeName = '/user_product';

  Future<void> _onRefreshFunction(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final pProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your product Screen'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: Icon(Icons.add_circle_outline_rounded),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _onRefreshFunction(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (context, index) => Column(
              children: [
                UserProductItem(
                  title: pProvider.items[index].title,
                  imageURL: pProvider.items[index].imageUrl,
                  id: pProvider.items[index].id,
                ),
                Divider(),
              ],
            ),
            itemCount: pProvider.items.length,
          ),
        ),
      ),
    );
  }
}
