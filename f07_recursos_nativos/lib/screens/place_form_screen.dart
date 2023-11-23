import 'dart:io';

import 'package:f07_recursos_nativos/utils/location_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/image_input.dart';
import '../components/location_input.dart';
import '../provider/great_places.dart';

class PlaceFormScreen extends StatefulWidget {
  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  final _numeroController = TextEditingController();

  //deve receber a imagem
  File? _pickedImage;

  void _selectImage(File? pickedImage) {
    _pickedImage = pickedImage;
  }

  //

  void _submitForm() async {
    final provider = Provider.of<GreatPlaces>(context, listen: false);
    final latitude = provider.latitude!;
    final longitude = provider.longitude!;
    final address = await provider.getAddressFromLatLng(latitude, longitude);
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        latitude == null ||
        longitude == null) {
      return;
    }
    print('tem os dados');
    provider.addPlace(_titleController.text, _pickedImage!, latitude, longitude,
        address, _numeroController.text);
    provider.latitude = null;
    provider.longitude = null;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Lugar'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Título',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _numeroController,
                      decoration: InputDecoration(
                        labelText: 'Número Telefone',
                      ),
                    ),
                    SizedBox(height: 10),
                    ImageInput(this._selectImage),
                    SizedBox(height: 10),
                    LocationInput(),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Adicionar'),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).colorScheme.secondary,
              onPrimary: Colors.black,
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: _submitForm,
          ),
        ],
      ),
    );
  }
}
