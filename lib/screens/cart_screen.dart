import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import '../widgets/cart_item_display.dart';

class CartScreen extends StatelessWidget {
  static String routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            elevation: 6,
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 6),
                    child: Chip(
                      label: Text(
                        '${cart.itemTotlAmount} TK',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      backgroundColor: const Color.fromRGBO(33, 158, 188, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.black45,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(238, 108, 77, 1),
                      ),
                    ),
                    child: const Text(
                      'Order Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Lato',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: ((context, index) => CartItemDisplay(
                ItemId: cart.items.values.toList()[index].id,
                ItemPrice: cart.items.values.toList()[index].price,
                ItemQuantity: cart.items.values.toList()[index].quantity,
                ItemTitle: cart.items.values.toList()[index].title,
                ProductId: cart.items.keys.toList()[index],
              )),
              itemCount: cart.itemCount,
            ),
          )
        ],
      ),
    );
  }
}
