import 'package:f05_eshop/model/cart.dart';
import 'package:f05_eshop/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';

class CartItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //PEGANDO CONTEUDO PELO PROVIDER
    //
    final product = Provider.of<Product>(
      context,
      listen: false,
    );

    final cart = context.watch<CartModel>();

    var isFavorite =
        context.select<Product, bool>((produto) => produto.isFavorite);

    return ClipRRect(
      //corta de forma arredondada o elemento de acordo com o BorderRaius
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.PRODUCT_DETAIL, arguments: product);
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black,
          leading: Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  // cart.decreaseQuantity(product);
                },
              ),
              Text(
                "oi",
                style: TextStyle(color: Colors.white),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // cart.addQuantity(product);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.orangeAccent,
                ),
                onPressed: () {
                  // cart.remove(product);
                },
                iconSize: 20,
              ),
            ],
          ),
        ),
        header: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            onPressed: () {
              //adicionando metodo ao clique do botão
              product.toggleFavorite();
            },
            //icon: Icon(Icons.favorite),
            //pegando icone se for favorito ou não
            icon: Consumer<Product>(
              builder: (context, product, child) => Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
            ),
            //isFavorite ? Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
