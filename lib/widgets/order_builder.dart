import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../provider/order_providers.dart';

class OrderBuilder extends StatefulWidget {
  final OrderItem order;
  OrderBuilder(this.order);

  @override
  State<OrderBuilder> createState() => _OrderBuilderState();
}

class _OrderBuilderState extends State<OrderBuilder> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.order.amount.toString(),
            ),
            subtitle: Text(
              DateFormat('dd MMM, yyyy hh:mm AA')
                  .format(widget.order.orderDateTime),
            ),
            trailing: IconButton(
              icon: !_expanded
                  ? Icon(Icons.expand_more_rounded)
                  : Icon(Icons.expand_less_rounded),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.order.products.length * 20.0 + 10, 100),
              child: ListView(
                children: widget.order.products
                    .map(
                      (prod) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            prod.title,
                            style:const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${prod.quantity}x \$${prod.price}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
