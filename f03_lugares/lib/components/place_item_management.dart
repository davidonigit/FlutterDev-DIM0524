import 'package:f03_lugares/components/edit_place_modal.dart';
import 'package:f03_lugares/models/place.dart';
import 'package:f03_lugares/models/placesList.dart';
import 'package:f03_lugares/screens/form_places_screen.dart';
import 'package:f03_lugares/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceItemManagement extends StatefulWidget {
  final Place place;

  const PlaceItemManagement(this.place);

  @override
  State<PlaceItemManagement> createState() => _PlaceItemManagementState();
}

class _PlaceItemManagementState extends State<PlaceItemManagement> {
  Future<void> _deletePlace(Place place) async {
    bool confirmacao = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirmação',
          ),
          content: const Text(
            'Tem certeza de que deseja remover esse lugar?',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(false); // Cancelar a exclusão
              },
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () {
                Navigator.of(context).pop(true); // Confirmar a exclusão
              },
            ),
          ],
        );
      },
    );

    if (confirmacao == true) {
      Provider.of<PlacesList>(context, listen: false).remove(place);
    }
  }

  _editModal() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return EditPlaceModal();
        });
  }

  void _selectPlace(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
          AppRoutes.PLACES_DETAIL,
          arguments: widget.place,
        )
        .then((value) => {
              if (value == null) {} else {print(value)}
            });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectPlace(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(children: <Widget>[
              ClipRRect(
                //bordas na imagem
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  widget.place.imagemUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                //só funciona no contexto do Stack - posso posicionar o elemento
                right: 10,
                bottom: 20,
                child: Container(
                  width: 300,
                  color: Colors.black54,
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 20,
                  ),
                  child: Text(
                    widget.place.titulo,
                    style: TextStyle(fontSize: 26, color: Colors.white),
                    softWrap: true, //quebra de lina
                    overflow: TextOverflow.fade, //case de overflow
                  ),
                ),
              )
            ]),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.star),
                      SizedBox(
                        width: 6,
                      ),
                      Text('${widget.place.avaliacao}/5')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.attach_money),
                      SizedBox(
                        width: 6,
                      ),
                      Text('R\$${widget.place.custoMedio}')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                          onPressed: () => _deletePlace(widget.place),
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                          onPressed: () => _editModal(),
                          icon: const Icon(Icons.edit))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
