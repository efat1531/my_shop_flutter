import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './provider/cart_provider.dart';
import './provider/product_provider.dart';
import './screens/products_overview_screen.dart';
import './screens/product_details.dart';
import './screens/cart_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: ((context) => Cart()),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Color.fromRGBO(251, 133, 0, 1),
          fontFamily: 'Lato',
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetails.routeName: (context) => ProductDetails(),
          CartScreen.routeName: (context) => CartScreen(),
        },
      ),
    );
  }
}
