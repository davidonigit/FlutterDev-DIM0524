import 'package:f03_lugares/components/main_drawer.dart';
import 'package:f03_lugares/components/place_item.dart';
import 'package:f03_lugares/components/place_item_management.dart';
import 'package:f03_lugares/data/my_data.dart';
import 'package:f03_lugares/models/country.dart';
import 'package:f03_lugares/models/placesList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacesManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var countryPlaces = context.watch<PlacesList>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Lugares'),
      ),
      drawer: MainDrawer(),
      body: ListView.builder(
          itemCount: countryPlaces.places.length,
          itemBuilder: (ctx, index) {
            var place = countryPlaces.places[index];
            return PlaceItemManagement(place);
          }),
    );
  }
}
