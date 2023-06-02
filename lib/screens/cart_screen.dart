import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import '../widgets/cart_item_display.dart';
import '../provider/order_providers.dart';

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
            color: const Color.fromRGBO(251, 234, 255, 1),
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
                      backgroundColor: const Color.fromRGBO(255, 0, 116, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: const BorderSide(
                          color: Colors.black45,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  addOrderButtonWidget(cart: cart)
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

class addOrderButtonWidget extends StatefulWidget {
  const addOrderButtonWidget({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<addOrderButtonWidget> createState() => _addOrderButtonWidgetState();
}

class _addOrderButtonWidgetState extends State<addOrderButtonWidget> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return ElevatedButton(
      onPressed: (cart.itemTotlAmount == 0 || _isLoading == true)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.items.values.toList(),
                  widget.cart.itemTotlAmount);
              widget.cart.delteCart();
            },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.black45,
              width: 1.5,
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
          fontFamily: 'Raleway',
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
