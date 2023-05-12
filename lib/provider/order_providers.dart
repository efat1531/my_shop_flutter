import 'package:flutter/widgets.dart';

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

  void addOrder(List<CartItem> product_list, int totalAmount) {
    _orderList.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: totalAmount,
        products: product_list,
        orderDateTime: DateTime.now(),
      ),
    );
    //print('Order Placed Successfully and amount = ${totalAmount}');
    notifyListeners();
  }
}
