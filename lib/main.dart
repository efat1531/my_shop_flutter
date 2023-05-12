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
          fontFamily: 'Lato',
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(92, 7, 253, 1.0),
            titleTextStyle: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
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
