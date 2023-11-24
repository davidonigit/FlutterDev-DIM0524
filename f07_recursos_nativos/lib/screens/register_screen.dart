import 'package:f07_recursos_nativos/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/autenticacao_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _errorController = TextEditingController();
  final AutenticacaoService _serviceAuthentication = AutenticacaoService();

  Future<void> _autenticarRegistro(String email, String senha) async {
    _serviceAuthentication.registerUsuario(email, senha);
    User? user = _serviceAuthentication.getCurrentUser();
    if (user != null) {
      Navigator.pushNamed(context, AppRoutes.LOGIN_SCREEN);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _senhaController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode acessar os valores inseridos nos campos
                String email = _emailController.text;
                String senha = _senhaController.text;

                if (email == '' || senha == '') {
                  return;
                }
                _autenticarRegistro(email, senha);
              },
              child: Text('Registrar'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.LOGIN_SCREEN);
              },
              child: Text('Tela Login'),
            ),
          ],
        ),
      ),
    );
  }
}
