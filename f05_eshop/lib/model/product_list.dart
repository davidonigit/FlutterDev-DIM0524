import 'dart:convert';
import 'dart:math';

import 'package:f05_eshop/data/dummy_data.dart';
import 'package:f05_eshop/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductList with ChangeNotifier {
  final _baseUrl = 'https://miniprojeto4-flutter-default-rtdb.firebaseio.com/';

  List<Product> _items = [];

  bool _showFavoriteOnly = false;

  List<Product> get items {
    return [..._items];
  }

  Future<List<Product>> loadProductsFromDatabase() async {
    final response = await http.get(
      Uri.parse(
          'https://miniprojeto4-flutter-default-rtdb.firebaseio.com/products.json'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<Product> products = [];

      jsonData.forEach((productId, productData) {
        products.add(Product.fromJson(productId, productData));
      });
      _items = products;
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> toggleFavorite(Product product) async {
    product.isFavorite = !product.isFavorite;
    final response = await http.put(
      Uri.parse(
          'https://miniprojeto4-flutter-default-rtdb.firebaseio.com/products/${product.id}.json'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'quantity': product.quantity,
        'isFavorite': product.isFavorite,
      }),
    );
    notifyListeners();
  }

  Product getById(String id) {
    Product found = items.firstWhere((product) => product.id.contains(id));
    return found;
  }

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }

  Future<void> addProduct(Product product) {
    final future = http.post(Uri.parse('$_baseUrl/products.json'),
        body: jsonEncode({
          "title": product.title,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "quantity": 0,
          "isFavorite": product.isFavorite,
        }));
    return future.then((response) {
      //print('espera a requisição acontecer');
      print(jsonDecode(response.body));
      final id = jsonDecode(response.body)['name'];
      print(response.statusCode);
      _items.add(Product(
          id: id,
          title: product.title,
          description: product.description,
          price: product.price,
          quantity: 0,
          imageUrl: product.imageUrl));
      notifyListeners();
    });
    // print('executa em sequencia');
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      title: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> updateProduct(Product product) async {
    final response = await http.put(
      Uri.parse(
          'https://miniprojeto4-flutter-default-rtdb.firebaseio.com/products/${product.id}.json'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'quantity': product.quantity,
        'isFavorite': product.isFavorite,
      }),
    );
    notifyListeners();
  }

  Future<void> removeProduct(Product product) async {
    final response = await http.delete(
      Uri.parse(
          'https://miniprojeto4-flutter-default-rtdb.firebaseio.com/products/${product.id}.json'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    notifyListeners();
  }
}
