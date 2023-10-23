import 'package:flutter/cupertino.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  int quantity;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
    this.quantity = 0,
  });

  Future<void> toggleFavorite() async {
    isFavorite = !isFavorite;
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'isFavorite': isFavorite,
    };
  }

  factory Product.fromJson(String id, Map<String, dynamic> json) {
    return Product(
        id: id,
        title: json['title'],
        description: json['description'],
        price: json['price'],
        imageUrl: json['imageUrl'],
        quantity: json['quantity'],
        isFavorite: json['isFavorite']);
  }
}
