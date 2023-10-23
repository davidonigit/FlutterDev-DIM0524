import 'product.dart';

class Order {
  String id;
  List<Product> products;
  double totalValue;
  DateTime orderDate;

  Order({
    required this.id,
    required this.products,
    required this.totalValue,
    required this.orderDate,
  });

  factory Order.fromJson(String id, Map<String, dynamic> json) {
    return Order(
      id: id,
      products: json['products'],
      totalValue: json['totalValue'],
      orderDate: json['orderDate'],
    );
  }
}
