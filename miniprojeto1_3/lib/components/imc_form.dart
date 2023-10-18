import 'package:flutter/material.dart';

class FormIMC extends StatelessWidget {
  Function(String, String) onSubmit;
  FormIMC(this.onSubmit);
  TextEditingController value1Controller = TextEditingController();
  TextEditingController value2Controller = TextEditingController();

  _submitForm() {
      if (value1Controller.text.isEmpty || value1Controller.text.isEmpty) {
        return;
      }
      //passando dado para componente pai
      onSubmit(value1Controller.text, value2Controller.text);
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: value1Controller,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Peso (kg)'),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: value2Controller,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Altura (metros)'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  double value1 = double.tryParse(value1Controller.text) ?? 0.0;
                  double value2 = double.tryParse(value2Controller.text) ?? 0.0;

                  // Faça algo com os valores double (value1 e value2) aqui
                  print('Valor 1: $value1');
                  print('Valor 2: $value2');
                },
                child: Text('Calcular'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}