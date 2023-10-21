import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:f05_eshop/model/cart.dart';
import 'package:f05_eshop/model/product_list.dart';
import 'package:f05_eshop/model/product.dart';

class CardTile extends StatelessWidget {
  final Product product;

  CardTile(this.product);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final cart = Provider.of<CartModel>(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.pink, width: 3),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Preço: ${product.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 15),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        cart.updateQuantity(product, -1);
                      },
                    ),
                    Text(
                      "${product.quantity}",
                      style: TextStyle(color: Colors.black),
                    ),
                    IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          cart.updateQuantity(product, 1);
                        }),
                    IconButton(
                      onPressed: () {
                        cart.removeProduct(product);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
