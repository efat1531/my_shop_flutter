// ignore_for_file: prefer_final_fields

import 'package:flutter/widgets.dart';

class CartItem {
  String id;
  String title;
  final int quantity;
  int price;
  CartItem({
    required this.id,
    required this.price,
    required this.title,
    required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(
    String Productid,
    int Price,
    String Title,
  ) {
    if (_items.containsKey(Productid)) {
      _items.update(
        Productid,
        (value) => CartItem(
            id: value.id,
            price: value.price,
            title: value.title,
            quantity: value.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
        Productid,
        () => CartItem(
            id: DateTime.now().toString(),
            price: Price,
            title: Title,
            quantity: 1),
      );
    }
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  int get itemTotlAmount {
    int totalAmount = 0;
    _items.forEach(
      (key, value) {
        totalAmount += value.price * value.quantity;
      },
    );
    return totalAmount;
  }

  void removeItem(String ProductId) {
    _items.remove(ProductId);
    notifyListeners();
  }

  void delteCart() {
    _items = {};
    //print('Order Deleted');
    notifyListeners();
  }
}
