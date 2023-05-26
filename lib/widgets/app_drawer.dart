import 'package:flutter/material.dart';
import '../screens/order_screen.dart';
import '../screens/user_product_screen.dart';
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello User'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shopping_basket),
            title: const Text('Shop'),
            onTap: (() {
              Navigator.of(context).pushReplacementNamed('/home');
            }),
          ),
          const Divider(
            thickness: 1.5,
            color: Color.fromRGBO(192, 116, 132, 1),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Orders'),
            onTap: (() {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            }),
          ),
          const Divider(
            thickness: 1.5,
            color: Color.fromRGBO(192, 116, 132, 1),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Products'),
            onTap: (() {
              Navigator.of(context).pushReplacementNamed(UserProductScreen.routeName);
            }),
          ),
        ],
      ),
    );
  }
}
