// ignore_for_file: prefer_final_fields

import 'package:flutter/widgets.dart';
import './Product_model_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/exceptions.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 500,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 600,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 500,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 100,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((element) => element.isFavourite).toList();
  }

  Product FindById(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchProducts() async {
    final url = Uri.https(
      'my-shop-first-project-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/products.json',
    );
    try {
      final response = await http.get(url);
      //print(response.body);
      final extractedData =
          await json.decode(response.body) as Map<String, dynamic>;
      //print(extractedData);
      final List<Product> loadedProducts = [];
      extractedData.forEach(
        (productID, value) {
          loadedProducts.add(
            Product(
              id: productID,
              title: value['title'],
              description: value['description'],
              imageUrl: value['imageurl'],
              price: value['amount'],
              isFavourite: value['isFavourite'],
            ),
          );
        },
      );
      _items = loadedProducts;
      //print(_items);
    } catch (error) {
      print(error);
    }
  }

  Future<void> add_item(Product receivedProduct) async {
    final url = Uri.https(
      'my-shop-first-project-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/products.json',
    );
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'},
        body: json.encode(
          {
            'title': receivedProduct.title,
            'description': receivedProduct.description,
            'amount': receivedProduct.price,
            'imageurl': receivedProduct.imageUrl,
            'isFavourite': receivedProduct.isFavourite,
          },
        ),
      );

      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: receivedProduct.title,
          description: receivedProduct.description,
          imageUrl: receivedProduct.imageUrl,
          price: receivedProduct.price,
          isFavourite: receivedProduct.isFavourite);
      print(newProduct);
      _items.insert(0, newProduct);
      //notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> removeProduct(String id) async {
    final removedItemIndex = _items.indexWhere((element) => element.id == id);
    Product? removedProduct = _items[removedItemIndex];
    _items.removeAt(removedItemIndex);
    notifyListeners();
    final url = Uri.https(
      'my-shop-first-project-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/products/$id.json',
    );
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(removedItemIndex, removedProduct);
      notifyListeners();
      throw HttpExceptions('Could not delete the product');
    }
    removedProduct = null;
  }
}
