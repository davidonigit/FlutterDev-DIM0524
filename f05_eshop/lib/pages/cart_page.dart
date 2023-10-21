import 'package:f05_eshop/components/cart_tile.dart';
import 'package:f05_eshop/model/cart.dart';
import 'package:f05_eshop/model/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/product_tile.dart';
import '../model/product.dart';
import '../utils/app_routes.dart';

enum FilterOptions {
  Favorite,
  All,
}

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return FutureBuilder<List<Product>>(
      future: cart
          .loadProductsFromDatabase(), // Função para carregar dados do banco de dados
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Carrinho'),
              ),
              body: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Carrinho'),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.pink),
                  ),
                  Text(
                    'Nenhum Item adicionado no carrinho!',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ));
        } else {
          final products = snapshot.data;
          return Scaffold(
              appBar: AppBar(
                title: Text('Carrinho'),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: products!.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return CardTile(product);
                      },
                    ),
                  ),
                  Divider(),
                  Text(
                    'Total ${cart.totalPrice}',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ));
        }
      },
    );
  }
}
