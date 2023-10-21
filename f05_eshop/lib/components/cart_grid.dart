import 'package:f05_eshop/components/cart_item.dart';
import 'package:f05_eshop/components/product_item.dart';
import 'package:f05_eshop/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';

class CartGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartModel>(context);

    final List<Product> loadedProducts = provider.cartProducts;

    return GridView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: loadedProducts.length,
      //# ProductItem vai receber a partir do Provider
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        //create: (ctx) => Product(),
        value: loadedProducts[i],
        //child: ProductItem(product: loadedProducts[i]),
        child: CartItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //2 produtos por linha
        childAspectRatio: 3 / 2, //diemnsao de cada elemento
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
