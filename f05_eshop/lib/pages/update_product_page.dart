import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/product.dart';
import '../model/product_list.dart';

class UpdateProductPage extends StatefulWidget {
  final Product product;

  UpdateProductPage({required this.product});

  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.product.title;
    _descriptionController.text = widget.product.description;
    _priceController.text = widget.product.price.toStringAsFixed(2);
    _imageUrlController.text = widget.product.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<ProductList>(context);

    void _saveChanges() {
      final updatedProduct = Product(
        id: widget.product.id,
        title: _titleController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        imageUrl: _imageUrlController.text,
        isFavorite: widget.product.isFavorite,
      );

      productList.updateProduct(updatedProduct);
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Preço'),
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'URL da Imagem'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
