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

class ProductsPage extends StatefulWidget {
  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<ProductList>(context);

    return FutureBuilder<List<Product>>(
      future: productList
          .loadProductsFromDatabase(), // Função para carregar dados do banco de dados
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Minha Loja'),
              ),
              body: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Scaffold(
              appBar: AppBar(actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.PRODUCT_FORM,
                      );
                    },
                    icon: Icon(Icons.add)),
              ]),
              body: Text('Erro ao carregar os dados: ${snapshot.error}'));
        } else {
          final products = snapshot.data;
          return Scaffold(
              appBar: AppBar(
                title: Text('Minha Loja'),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.PRODUCT_FORM,
                        );
                      },
                      icon: Icon(Icons.add)),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.CART_PAGE,
                        );
                      },
                      icon: Icon(Icons.shopping_cart)),
                  PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        child: Text('Somente Favoritos'),
                        value: FilterOptions.Favorite,
                      ),
                      PopupMenuItem(
                        child: Text('Todos'),
                        value: FilterOptions.All,
                      ),
                    ],
                    onSelected: (FilterOptions selectedValue) {
                      setState(() {
                        if (selectedValue == FilterOptions.Favorite) {
                          _showOnlyFavorites = true;
                        } else {
                          _showOnlyFavorites = false;
                        }
                      });
                    },
                  ),
                ],
              ),
              body: ListView.builder(
                itemCount: products!.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  if ((_showOnlyFavorites && product.isFavorite) ||
                      !_showOnlyFavorites) {
                    return ProductTile(product);
                  } else {
                    return Container();
                  }
                },
              ));
        }
      },
    );
  }
}
