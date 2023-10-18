import 'dart:convert';
import 'dart:ffi';

import 'package:f03_lugares/components/main_drawer.dart';
import 'package:f03_lugares/data/my_data.dart';
import 'package:f03_lugares/models/place.dart';
import 'package:f03_lugares/models/placesList.dart';
import 'package:f03_lugares/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPlaceModal extends StatefulWidget {
  @override
  State<EditPlaceModal> createState() => _EditPlaceModalState();
}

class _EditPlaceModalState extends State<EditPlaceModal> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final place = arg as Place;
        _formData['id'] = place.id;
        _formData['name'] = place.titulo;
        _formData['countries'] = place.paises;
        _formData['recomendation'] = place.recomendacoes;
        _formData['price'] = place.custoMedio;
        _formData['rate'] = place.avaliacao;
        _formData['imageUrl'] = place.imagemUrl;

        _imageUrlController.text = place.imagemUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();

    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    // bool endsWithFile = url.toLowerCase().endsWith('.png') ||
    //     url.toLowerCase().endsWith('.jpg') ||
    //     url.toLowerCase().endsWith('.jpeg');
    // return isValidUrl && endsWithFile;
    return isValidUrl;
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    final recomendations = _formData['recomendation'] as String;
    final List<String> recomendationsList = recomendations.split(',');
    final countries = _formData['countries'] as String;
    final List<String> countriesList = countries.split(',');

    Place newPlace = Place(
        id: _formData['id'] as String,
        paises: countriesList,
        titulo: _formData['name'] as String,
        imagemUrl: _formData['imageUrl'] as String,
        recomendacoes: recomendationsList,
        avaliacao: _formData['rate'] as double,
        custoMedio: _formData['price'] as double);

    var places = context.watch<PlacesList>();
    int index = places.findIndex(newPlace);
    places.update(newPlace, index);

    const snackBar = SnackBar(content: Text('Lugar Criado com Sucesso.'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Lugar'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formData['name']?.toString(),
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                onSaved: (name) => _formData['name'] = name ?? '',
                validator: (_name) {
                  final name = _name ?? '';

                  if (name.trim().isEmpty) {
                    return 'Nome é obrigatório';
                  }

                  if (name.trim().length < 3) {
                    return 'Nome precisa no mínimo de 3 letras.';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['id']?.toString(),
                decoration: InputDecoration(
                  labelText: 'ID',
                ),
                onSaved: (id) => _formData['id'] = id ?? '',
                validator: (_id) {
                  final id = _id ?? '';

                  if (id.trim().isEmpty) {
                    return 'ID é obrigatório';
                  }

                  if (id.trim().length < 2) {
                    return 'Nome precisa no mínimo de 2 caracteres.';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['countries']?.toString(),
                decoration: InputDecoration(
                  labelText: 'Paises',
                ),
                onSaved: (countries) =>
                    _formData['countries'] = countries ?? '',
                validator: (_countries) {
                  final countries = _countries ?? '';

                  if (countries.trim().isEmpty) {
                    return 'Paises é obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['price']?.toString(),
                decoration: InputDecoration(labelText: 'Custo Médio'),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                onSaved: (price) =>
                    _formData['price'] = double.parse(price ?? '0'),
                validator: (_price) {
                  final priceString = _price ?? '';
                  final price = double.tryParse(priceString) ?? -1;

                  if (price <= 0) {
                    return 'Informe um custo válido.';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['rate']?.toString(),
                decoration: InputDecoration(labelText: 'Avaliação'),
                textInputAction: TextInputAction.next,
                // focusNode: _priceFocus,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                // onFieldSubmitted: (_) {
                //   FocusScope.of(context).requestFocus(_descriptionFocus);
                // },
                onSaved: (rate) =>
                    _formData['rate'] = double.parse(rate ?? '0'),
                validator: (_rate) {
                  final rateString = _rate ?? '';
                  final rate = double.tryParse(rateString) ?? -1;

                  if (rate <= 0 || rate > 5) {
                    return 'Informe uma avaliação válida.';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['recomendation']?.toString(),
                decoration: InputDecoration(
                    labelText: 'Recomendações',
                    hintText: 'Dica 1, Dica 2, ...'),
                focusNode: _descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (description) =>
                    _formData['recomendation'] = description ?? '',
                validator: (_description) {
                  final description = _description ?? '';

                  if (description.trim().isEmpty) {
                    return 'Recomendação é obrigatória.';
                  }

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Url da Imagem'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocus,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) => _submitForm(),
                      onSaved: (imageUrl) =>
                          _formData['imageUrl'] = imageUrl ?? '',
                      validator: (_imageUrl) {
                        final imageUrl = _imageUrl ?? '';

                        if (!isValidImageUrl(imageUrl)) {
                          return 'Informe uma Url válida!';
                        }

                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? Text('Informe a Url')
                        : Image.network(_imageUrlController.text),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
