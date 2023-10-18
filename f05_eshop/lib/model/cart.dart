import 'package:f05_eshop/model/product.dart';
import 'package:f05_eshop/model/product_list.dart';
import 'package:flutter/foundation.dart';

class CartModel extends ChangeNotifier {
  late ProductList _productList;

  final List<String> _productIds = [];

  ProductList get productList => _productList;

  set productList(ProductList newList) {
    _productList = newList;
    notifyListeners();
  }

  List<Product> get products =>
      _productIds.map((id) => _productList.getById(id)).toList();

  double get totalPrice =>
      products.fold(0, (total, itemCorrente) => total + itemCorrente.price);

  void add(Product product) {
    _productIds.add(product.id);
    notifyListeners();
  }

  void remove(Product item) {
    _productIds.remove(item.id);
    notifyListeners();
  }
}
