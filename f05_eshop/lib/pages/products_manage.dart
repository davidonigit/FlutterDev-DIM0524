import 'package:f05_eshop/components/manage_tile.dart';
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

class ProductsManage extends StatefulWidget {
  @override
  State<ProductsManage> createState() => _ProductsManageState();
}

class _ProductsManageState extends State<ProductsManage> {
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
                title: Text('Gerenciar Produtos'),
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
                title: Text('Gerenciar Produtos'),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.PRODUCT_FORM,
                        );
                      },
                      icon: Icon(Icons.add)),
                ],
              ),
              body: ListView.builder(
                itemCount: products!.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  if ((_showOnlyFavorites && product.isFavorite) ||
                      !_showOnlyFavorites) {
                    return ManageTile(product);
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
