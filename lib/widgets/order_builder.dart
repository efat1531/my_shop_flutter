import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../provider/order_providers.dart';

class OrderBuilder extends StatelessWidget {
  final OrderItem order;
  OrderBuilder(this.order);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
            title: Text(
              order.amount.toString(),
            ),
            subtitle: Text(
              DateFormat('dd MMM, yyyy hh:mm AA').format(order.orderDateTime),
            ),
            trailing: IconButton(
              icon: Icon(Icons.expand_circle_down_outlined),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
