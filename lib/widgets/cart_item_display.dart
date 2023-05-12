// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';

class CartItemDisplay extends StatelessWidget {
  final String ItemId;
  final String ItemTitle;
  final int ItemPrice;
  final int ItemQuantity;
  final String ProductId;
  CartItemDisplay({
    required this.ItemId,
    required this.ItemPrice,
    required this.ItemTitle,
    required this.ItemQuantity,
    required this.ProductId,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Dismissible(
        key: ValueKey(ItemId),
        onDismissed: (direction) {
          Provider.of<Cart>(context,listen: false).removeItem(ProductId);
        },
        background: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            color: Colors.red,
          ),
          alignment: Alignment.centerRight,
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(
              Icons.delete_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
        direction: DismissDirection.endToStart,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: ListTile(
            leading: CircleAvatar(
              radius: 35,
              backgroundColor: const Color.fromRGBO(77, 207, 238, 1),
              foregroundColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: FittedBox(
                  child: Text('$ItemPrice TK'),
                ),
              ),
            ),
            title: Text(ItemTitle),
            subtitle: Text('Total: ${(ItemPrice * ItemQuantity)} Tk'),
            trailing: Text('$ItemQuantity x'),
          ),
        ),
      ),
    );
  }
}
