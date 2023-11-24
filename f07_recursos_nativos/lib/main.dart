import 'package:f07_recursos_nativos/models/place.dart';
import 'package:f07_recursos_nativos/screens/biometric_login_screen.dart';
import 'package:f07_recursos_nativos/screens/place_detail_screen.dart';
import 'package:f07_recursos_nativos/screens/profile_screen.dart';
import 'package:f07_recursos_nativos/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'provider/great_places.dart';
import 'screens/place_form_screen.dart';
import 'screens/places_list_screen.dart';
import 'utils/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData().copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: Colors.indigo,
                  secondary: Colors.amber,
                )),
        home: BiometricLoginScreen(),
        routes: {
          AppRoutes.PLACE_FORM: (ctx) => PlaceFormScreen(),
          AppRoutes.PLACE_LIST: (ctx) => PlacesListScreen(),
          AppRoutes.LOGIN_SCREEN: (ctx) => BiometricLoginScreen(),
          AppRoutes.REGISTER_SCREEN: (ctx) => RegisterScreen(),
          AppRoutes.PROFILE_SCREEN: (ctx) => ProfileScreen(),
        },
      ),
    );
  }
}
