import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/place.dart';
import '../utils/location_util.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final Place place;
  PlaceDetailsScreen({required this.place});

  @override
  Widget build(BuildContext context) {
    final imageUrl = LocationUtil.generateLocationPreviewImage(
        latitude: place.location!.latitude,
        longitude: place.location!.longitude);

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.file(
              place.image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () {
                _launchPhoneApp(place.numero);
              },
              child: Text(
                'Telefone: ${place.numero}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Latitude: ${place.location?.latitude ?? "N/A"}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Longitude: ${place.location?.longitude ?? "N/A"}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Endereço: ${place.location?.address ?? "N/A"}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  // Função para abrir o aplicativo de chamadas
  void _launchPhoneApp(String phoneNumber) async {
    final call = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(call)) {
      await launchUrl(call);
    } else {
      throw 'Não foi possível realizar a ligação para $phoneNumber';
    }
  }
}
