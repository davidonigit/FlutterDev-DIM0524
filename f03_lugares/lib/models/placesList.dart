import 'package:f03_lugares/data/my_data.dart';
import 'package:f03_lugares/models/place.dart';
import 'package:flutter/material.dart';

class PlacesList extends ChangeNotifier {
  final List<Place> places = DUMMY_PLACES;

  add(Place place) {
    places.add(place);
    notifyListeners();
  }

  remove(Place place) {
    places.remove(place);
    notifyListeners();
  }

  update(Place place, int index) {
    places[index] = place;
  }

  findIndex(Place place) {
    int index = places.indexWhere((item) => item.id == place.id);
    return index;
  }
}
