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
  late Map<String, CartItem> _items;
  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String Productid, int Price, String Title) {
    if (items.containsKey(Productid)) {
      _items.update(
        Productid,
        (value) => CartItem(
            id: value.id,
            price: value.price,
            title: value.title,
            quantity: value.quantity + 1),
      );
    } else {
      items.putIfAbsent(
        Productid,
        () => CartItem(
            id: DateTime.now().toString(),
            price: Price,
            title: Title,
            quantity: 1),
      );
    }
  }
}
