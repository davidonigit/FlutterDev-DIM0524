import 'package:flutter/material.dart';

void main() {
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Application'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => DoNothingAction,
              icon: Icon(Icons.arrow_back)
            ),
          actions: [
            IconButton(
              onPressed: () => DoNothingAction(),
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0), // Define a margem padrão de 20 em todas as direções
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personal info',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 20.0), // Espaçamento entre o texto e os campos de texto
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'First Name',
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Birthday',
                        helperText: 'MM/DD/YYYY'
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0), // Espaçamento entre os campos de texto
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Social Security',
                        helperText: '###-##-###'
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                'Residence Address',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 20.0),
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'City',
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0), // Espaçamento entre os campos de texto
                  Expanded(
                    child: DropdownButtonFormField(
                      value: null,
                      items: [
                        DropdownMenuItem(
                          value: 'Opção 1',
                          child: Text('Op1')
                        )
                        ],
                      onChanged: (value) => DoNothingAction(),
                      decoration: InputDecoration(
                        labelText: 'State',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'ZIP Code',
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0), // Espaçamento entre os campos de texto
                  Expanded(
                    child: DropdownButtonFormField(
                      value: null,
                      items: [
                        DropdownMenuItem(
                          value: 'Opção 1',
                          child: Text('Op1')
                        )
                        ],
                      onChanged: (value) => DoNothingAction(),
                      decoration: InputDecoration(
                        labelText: 'Country',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Color.fromARGB(255, 76, 73, 128),
                secondary: Colors.white,
              )),
    );
  }
}