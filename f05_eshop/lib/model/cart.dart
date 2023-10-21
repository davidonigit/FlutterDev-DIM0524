import 'dart:convert';
import 'dart:math';
import 'package:f05_eshop/model/product.dart';
import 'package:f05_eshop/model/product_list.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CartModel extends ChangeNotifier {
  final _baseUrl = 'https://miniprojeto4-flutter-default-rtdb.firebaseio.com/';
  List<Product> _cartProducts = [];
  final Map<String, int> _itemQuantity = {};

  List<Product> get cartProducts => _cartProducts;

  double get totalPrice => _cartProducts.fold(
      0,
      (total, itemCorrente) =>
          total + (itemCorrente.price * itemCorrente.quantity));

  Future<List<Product>> loadProductsFromDatabase() async {
    final response = await http.get(
      Uri.parse(
          'https://miniprojeto4-flutter-default-rtdb.firebaseio.com/cart.json'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<Product> products = [];

      jsonData.forEach((productId, productData) {
        products.add(Product.fromJson(productId, productData));
      });
      _cartProducts = products;
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> addProduct(Product product) async {
    bool exists = _cartProducts.any((p) => p.id == product.id);

    if (exists) {
      //already contains
      print('EXISTS: ${exists}');
      return;
    } else {
      final future = http.post(Uri.parse('$_baseUrl/cart.json'),
          body: jsonEncode({
            "title": product.title,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
            "isFavorite": product.isFavorite,
            "quantity": 1,
          }));
      return future.then((response) {
        _cartProducts.add(Product(
            id: product.id,
            title: product.title,
            description: product.description,
            price: product.price,
            quantity: 1,
            imageUrl: product.imageUrl));
        notifyListeners();
      });
    }
  }

  Future<void> updateQuantity(Product product, int value) async {
    if (product.quantity == 1 && value == (-1)) {
      return;
    }

    final response = await http.put(
      Uri.parse(
          'https://miniprojeto4-flutter-default-rtdb.firebaseio.com/cart/${product.id}.json'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'quantity': product.quantity + (value),
        'isFavorite': product.isFavorite,
      }),
    );
    product.quantity = product.quantity + (value);
    notifyListeners();
  }

  Future<void> removeProduct(Product product) async {
    final response = await http.delete(
      Uri.parse(
          'https://miniprojeto4-flutter-default-rtdb.firebaseio.com/cart/${product.id}.json'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    notifyListeners();
  }
}
