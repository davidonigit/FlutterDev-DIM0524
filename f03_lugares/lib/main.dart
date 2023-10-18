import 'dart:ui';

import 'package:f03_lugares/models/favoriteList.dart';
import 'package:f03_lugares/models/place.dart';
import 'package:f03_lugares/models/placesList.dart';
import 'package:f03_lugares/screens/countries_places_screen.dart';
import 'package:f03_lugares/screens/form_places_screen.dart';
import 'package:f03_lugares/screens/place_detail_screen.dart';
import 'package:f03_lugares/screens/places_management.dart';
import 'package:f03_lugares/screens/settings_screen.dart';
import 'package:f03_lugares/screens/tabs_screen.dart';
import 'package:f03_lugares/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => PlacesList()),
      ChangeNotifierProvider(create: (context) => FavoriteList()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlacesToGo',
      theme: ThemeData(
        colorScheme: ThemeData()
            .colorScheme
            .copyWith(primary: Colors.purple, secondary: Colors.amber),
        fontFamily: 'Raleway',
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        AppRoutes.HOME: (ctx) => TabsScreen(),
        AppRoutes.COUNTRY_PLACES: (ctx) => CountryPlacesScreen(),
        AppRoutes.PLACES_DETAIL: (ctx) => PlaceDetailScreen(),
        AppRoutes.SETTINGS: (ctx) => SettingsScreen(),
        AppRoutes.FORM_PLACES: (ctx) => FormPlacesScreen(),
        AppRoutes.PLACES_MANAGEMENT: (ctx) => PlacesManagement(),
      },
    );
  }
}
