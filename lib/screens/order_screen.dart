import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/order_providers.dart';
import '../widgets/order_builder.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'Your Orders',
        ),
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) => OrderBuilder(
              orderData.orders[index],
            )),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
