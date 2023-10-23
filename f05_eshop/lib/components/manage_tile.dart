import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:f05_eshop/model/cart.dart';
import 'package:f05_eshop/model/product_list.dart';
import 'package:f05_eshop/model/product.dart';

import '../pages/update_product_page.dart';

class ManageTile extends StatefulWidget {
  final Product product;

  ManageTile(this.product);

  @override
  State<ManageTile> createState() => _ManageTileState();
}

class _ManageTileState extends State<ManageTile> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final cartProvider = Provider.of<CartModel>(context);

    Future<void> _confirmRemove(Product product) async {
      bool confirmacao = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 44, 44, 44),
            title: const Text(
              'Confirmação',
              style: TextStyle(color: Colors.pink),
            ),
            content: const Text(
              'Tem certeza de que deseja remover esse produto?\nA ação não pode ser desfeita',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop(false); // Cancelar a exclusão
                },
              ),
              TextButton(
                child: const Text('Excluir'),
                onPressed: () {
                  Navigator.of(context).pop(true); // Confirmar a exclusão
                },
              ),
            ],
          );
        },
      );

      if (confirmacao == true) {
        setState(() {
          provider.removeProduct(product);
        });
      }
    }

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
              widget.product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Preço: ${widget.product.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 15),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UpdateProductPage(product: widget.product),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        _confirmRemove(widget.product);
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
