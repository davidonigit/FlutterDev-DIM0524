import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BMICalculator(),
      theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: const Color.fromARGB(255, 66, 6, 76),
                secondary: Color.fromARGB(255, 28, 6, 106),
              )),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String result = '';
  String faixa = '';
  Color corResultado = Colors.black;
  String imagem = 'assets/0.png';

  void indicarFaixa(imc) {
    if(imc<18.5){
      faixa = 'Abaixo do Peso';
      corResultado = Colors.blue;
      imagem = 'assets/1.png';
    } else if(imc<25){
      faixa = 'Peso Normal';
      corResultado = Colors.green;
      imagem = 'assets/2.png';
    } else if(imc<30){
      faixa = 'Sobrepeso';
      corResultado = Color.fromARGB(255, 255, 237, 79);
      imagem = 'assets/3.png';
    } else if(imc<35){
      faixa = 'Obesidade Grau I';
      corResultado = Color.fromARGB(255, 159, 143, 0);
      imagem = 'assets/4.png';
    } else if(imc<40){
      faixa = 'Obesidade Grau II';
      corResultado = Colors.orange;
      imagem = 'assets/5.png';
    } else {
      faixa = 'Obesidade Mórbida';
      corResultado = Colors.red;
      imagem = 'assets/6.png';
    }
  }

  void calculateBMI() {
    double height = double.tryParse(heightController.text) ?? 0.0;
    double weight = double.tryParse(weightController.text) ?? 0.0;

    if (height > 0 && weight > 0) {
      double bmi = weight / (height * height);
      indicarFaixa(bmi);
      result = 'Seu IMC é: ${bmi.toStringAsFixed(2)}';
    } else {
      result = 'Preencha altura e peso válidos.';
      faixa = '';
      imagem = 'assets/0.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: heightController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Altura (metros)'),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Peso (quilos)'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                calculateBMI();
                // Atualiza o resultado no estado do widget
                setState(() {});
              },
              child: Text('Calcular IMC'),
            ),
            SizedBox(height: 20.0),
            Text(result, style: TextStyle(fontSize: 25.0)),
            SizedBox(height: 10),
            Text(faixa, style: TextStyle(fontSize: 25.0, color: corResultado)),
            SizedBox(height: 10),
            Image.asset(imagem)
          ],
        ),
      ),
    );
  }
}