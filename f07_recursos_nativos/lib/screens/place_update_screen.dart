import 'dart:io';

import 'package:f07_recursos_nativos/screens/place_detail_screen.dart';
import 'package:f07_recursos_nativos/utils/location_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/image_input.dart';
import '../components/location_input.dart';
import '../models/place.dart';
import '../provider/great_places.dart';

class UpdatePlaceScreen extends StatefulWidget {
  final Place place;

  UpdatePlaceScreen({required this.place});

  @override
  _UpdatePlaceScreenState createState() => _UpdatePlaceScreenState();
}

class _UpdatePlaceScreenState extends State<UpdatePlaceScreen> {
  late TextEditingController _titleController;
  late TextEditingController _numeroController;
  late File? _pickedImage;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.place.title);
    _numeroController = TextEditingController(text: widget.place.numero);
    _pickedImage = widget.place.image;
  }

  void _selectImage(File? pickedImage) {
    _pickedImage = pickedImage;
  }

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
    Place newPlace = Place(
        id: widget.place.id,
        title: _titleController.text,
        location: PlaceLocation(
            latitude: latitude, longitude: longitude, address: address),
        image: _pickedImage!,
        numero: _numeroController.text);
    print('tem os dados update');
    provider.updatePlace(newPlace.id, newPlace);
    provider.latitude = null;
    provider.longitude = null;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceDetailsScreen(place: newPlace),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atualizar Lugar'),
      ),
      body: Padding(
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
            ImageInput(
              _selectImage,
              initialImage: widget.place.image,
            ),
            SizedBox(height: 10),
            LocationInput(
              latitude: widget.place.location!.latitude,
              longitude: widget.place.location!.longitude,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        child: Icon(Icons.save),
      ),
    );
  }
}
