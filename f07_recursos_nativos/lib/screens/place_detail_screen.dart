import 'package:f07_recursos_nativos/screens/place_update_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../models/place.dart';
import '../provider/great_places.dart';
import '../utils/app_routes.dart';
import '../utils/location_util.dart';

class PlaceDetailsScreen extends StatefulWidget {
  final Place place;
  PlaceDetailsScreen({required this.place});

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _confirmDelete() async {
    bool confirmacao = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação',
              style: TextStyle(
                color: Colors.indigo,
              )),
          content: const Text(
            'Tem certeza de que deseja remover esse local?',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(false); // Cancelar a exclusão
              },
            ),
            TextButton(
              child: const Text(
                'Excluir',
                style: TextStyle(color: Colors.amber),
              ),
              onPressed: () {
                Navigator.of(context).pop(true); // Confirmar a exclusão
              },
            ),
          ],
        );
      },
    );

    if (confirmacao == true) {
      Provider.of<GreatPlaces>(context, listen: false)
          .deletePlace(widget.place.id);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = LocationUtil.generateLocationPreviewImage(
        latitude: widget.place.location!.latitude,
        longitude: widget.place.location!.longitude);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.place.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Provider.of<GreatPlaces>(context, listen: false).latitude =
                  widget.place.location!.latitude;
              Provider.of<GreatPlaces>(context, listen: false).longitude =
                  widget.place.location!.longitude;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdatePlaceScreen(place: widget.place),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _confirmDelete();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.file(
              widget.place.image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () {
                _launchPhoneApp(widget.place.numero);
              },
              child: Text(
                'Telefone: ${widget.place.numero}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Latitude: ${widget.place.location?.latitude ?? "N/A"}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Longitude: ${widget.place.location?.longitude ?? "N/A"}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Endereço: ${widget.place.location?.address ?? "N/A"}',
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
