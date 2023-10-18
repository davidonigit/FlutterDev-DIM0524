import 'package:flutter/material.dart';
import 'package:f02_todolist/models/tarefa.dart';
import 'package:intl/intl.dart';

class ListaTarefa extends StatefulWidget {
  final List<Tarefa> listaTarefas;

  ListaTarefa({
    required this.listaTarefas,
  });

  @override
  _ListaTarefaState createState() => _ListaTarefaState();
}

class _ListaTarefaState extends State<ListaTarefa> {
  Color corPrioridade = Colors.blue;

  void _chooseColor(String prioridade) {
    switch (prioridade) {
      case 'BAIXA':
        corPrioridade = Colors.blue;
        break;
      case 'NORMAL':
        corPrioridade = Colors.yellow;
        break;
      case 'ALTA':
        corPrioridade = Colors.red;
        break;
    }
  }

  Future<void> _confirmDelete(int index) async {
    bool confirmacao = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação'),
          content: Text('Tem certeza de que deseja excluir esta tarefa?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(false); // Cancelar a exclusão
              },
            ),
            TextButton(
              child: Text('Excluir'),
              onPressed: () {
                Navigator.of(context).pop(true); // Confirmar a exclusão
              },
            ),
          ],
        );
      },
    );

    if (confirmacao == true) {
      setState(() {
        widget.listaTarefas.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(widget.listaTarefas.isEmpty){
      return Center(
        child: Text('Nenhuma tarefa cadastrada...')
      );
    }
    else{
      return Container(
        height: 300,
        child: ListView.builder(
          itemCount: widget.listaTarefas.length,
          itemBuilder: (context, index) {
            final tarefa = widget.listaTarefas[index];
            _chooseColor(tarefa.prioridade);
            return Card(
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: tarefa.dataExecucao.day >= DateTime.now().day
                            ? (tarefa.dataExecucao.day == DateTime.now().day
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.primary)
                            : Colors.red,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      DateFormat('dd/MM/y').format(tarefa.dataExecucao),
                      style: TextStyle(
                        color: tarefa.dataExecucao.day >= DateTime.now().day
                            ? (tarefa.dataExecucao.day == DateTime.now().day
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.primary)
                            : Colors.red,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tarefa.titulo),
                      Text('Prioridade ${tarefa.prioridade}',
                          style: TextStyle(color: corPrioridade)),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _confirmDelete(index); // Exibir diálogo de confirmação
                    },
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }
}