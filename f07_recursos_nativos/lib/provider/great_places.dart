import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../models/place.dart';
import '../utils/db_util.dart';

class GreatPlaces with ChangeNotifier {
  double? latitude;
  double? longitude;
  List<Place> _items = [];

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places');
    _items = dataList
        .map(
          (item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              location: PlaceLocation(
                  latitude: item['location']['latitude'],
                  longitude: item['location']['latitude'],
                  address: item['location']['address']),
              numero: item['numero']),
        )
        .toList();
    notifyListeners();
  }

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  void addPlace(String title, File image, double latitude, double longitude,
      String address, String numero) {
    final newPlace = Place(
        id: Random().nextDouble().toString(),
        title: title,
        location: PlaceLocation(
            latitude: latitude, longitude: longitude, address: address),
        image: image,
        numero: numero);

    _items.add(newPlace);
    DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'latitude': newPlace.location!.latitude,
      'longitude': newPlace.location!.longitude,
      'address': newPlace.location!.address,
      'numero': newPlace.numero
    });
    print('newPlace!!! - ${newPlace.title}');
    print('newPlace address${newPlace.location!.address}');
    print('newPlace numero ${newPlace.numero}');
    notifyListeners();
  }

  Future<String> getAddressFromLatLng(double lat, double lng) async {
    final apiKey =
        'AIzaSyBMoR2hFCb4Hhq4KqqZdmzNaO4zbwoezcU'; // Substitua com sua chave de API do Google Maps
    final apiUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK' && data['results'].isNotEmpty) {
        return data['results'][0]['formatted_address'];
      } else {
        throw Exception(
            'Nenhum resultado encontrado para as coordenadas fornecidas.');
      }
    } else {
      throw Exception('Falha na solicitação ao serviço de geocoding.');
    }
  }
}
