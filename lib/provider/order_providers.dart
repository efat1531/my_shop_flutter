import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/models/exceptions.dart';
import 'dart:convert';
import './cart_provider.dart';

class OrderItem {
  final String id;
  final int amount;
  final List<CartItem> products;
  final DateTime orderDateTime;
  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.orderDateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orderList = [];
  List<OrderItem> get orders {
    return [..._orderList];
  }

  Future<void> addOrder(List<CartItem> product_list, int totalAmount) async {
    final url = Uri.https(
      'my-shop-first-project-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/orders.json',
    );
    try {
      final timestamp = DateTime.now();
      final response = await http.post(
        url,
        body: json.encode(
          {
            'amount': totalAmount,
            'timestamp': timestamp.toIso8601String(),
            'products': product_list
                .map((e) => {
                      'id': e.id,
                      'title': e.title,
                      'quantity': e.quantity,
                      'price': e.price,
                    })
                .toList(),
          },
        ),
      );
      _orderList.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: totalAmount,
          products: product_list,
          orderDateTime: timestamp,
        ),
      );
      //print('Order Placed Successfully and amount = ${totalAmount}');
      notifyListeners();
    } catch (erroor) {
      throw HttpExceptions('An exception occured. Could not add the order');
    }
  }
}
