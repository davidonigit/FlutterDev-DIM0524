import 'package:f03_lugares/models/place.dart';
import 'package:flutter/material.dart';

class FavoriteList extends ChangeNotifier {
  final List<Place> places = [];

  void add(Place place) {
    places.add(place);
    notifyListeners();
  }

  void remove(Place place) {
    places.remove(place);
    notifyListeners();
  }

  void toggleFavorite(Place place) {
    places.contains(place) ? places.remove(place) : places.add(place);
    notifyListeners();
  }

  bool isFavorite(Place place) {
    return places.contains(place);
  }
}
