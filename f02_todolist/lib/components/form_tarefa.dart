import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormTarefa extends StatefulWidget {
  Function(String, String, String, DateTime) onSubmit;
  FormTarefa(this.onSubmit);

  @override
  State<FormTarefa> createState() => _FormTarefaState();
}

class _FormTarefaState extends State<FormTarefa> {
  final _tarefaController = TextEditingController();
  //final _comentarioController = TextEditingController();
  final _descricaoController = TextEditingController();
  DateTime _dataSelecionada = DateTime.now();
  final List<String> prioridades = ['BAIXA', 'NORMAL', 'ALTA'];
  String selectedPriority = 'BAIXA';
  Color corPrioridade = Colors.blue;
  @override
  Widget build(BuildContext context) {

    _submitForm() {
      final titulo = _tarefaController.text;
      //final comentario = _comentarioController.text;
      final descricao = _descricaoController.text;
      final prioridade = selectedPriority;
      if (_tarefaController.text.isEmpty) {
        return;
      }
      //passando dado para componente pai
      widget.onSubmit(titulo, descricao, prioridade, _dataSelecionada);
    }

    _showDatePicker() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2023),
              lastDate: DateTime(2024))
          .then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _dataSelecionada = pickedDate;
        });
      });
    }

    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          TextField(
            controller: _tarefaController,
            decoration: const InputDecoration(labelText: 'nova tarefa...'),
          ),
          TextField(
            controller: _descricaoController,
            decoration: const InputDecoration(labelText: 'descrição da tarefa...'),
          ),
          DropdownButtonFormField<String>(
                  value: selectedPriority,
                  items: prioridades.map((prioridade) {
                    return DropdownMenuItem<String>(
                      value: prioridade,
                      child: Text(prioridade),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedPriority = newValue ?? 'BAIXA';
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Prioridade',
                  ),
                ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                      'Data selecionada ${DateFormat('dd/MM/y').format(_dataSelecionada)}'),
                ),
                TextButton(
                    onPressed: _showDatePicker, child: Text('Selecionar data'))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: _submitForm, child: Text('Cadastrar tarefa')),
          )
        ],
      ),
    );
  }
}
