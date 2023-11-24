import 'package:f07_recursos_nativos/utils/app_routes.dart';
import 'package:f07_recursos_nativos/utils/autenticacao_service.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'places_list_screen.dart';

class BiometricLoginScreen extends StatefulWidget {
  @override
  _BiometricLoginScreenState createState() => _BiometricLoginScreenState();
}

class _BiometricLoginScreenState extends State<BiometricLoginScreen> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  final AutenticacaoService _serviceAuthentication = AutenticacaoService();
  String _biometricError = '';

  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  Future<void> _authenticate() async {
    try {
      // Verifica se o dispositivo suporta autenticação biométrica
      bool isBiometricAvailable = await _localAuthentication.canCheckBiometrics;

      if (isBiometricAvailable) {
        // Autentica usando o sensor biométrico
        bool isAuthenticated = await _localAuthentication.authenticate(
          localizedReason: 'Toque no sensor biométrico para autenticar',
        );

        if (isAuthenticated) {
          User? user = _serviceAuthentication.getCurrentUser();
          if (user != null) {
            Navigator.pushNamed(context, AppRoutes.PLACE_LIST);
          }
        } else {
          // Autenticação falhou
          setState(() {
            _biometricError = 'Autenticação biométrica falhou.';
          });
        }
      } else {
        // O dispositivo não suporta autenticação biométrica
        setState(() {
          _biometricError =
              'O dispositivo não suporta autenticação biométrica.';
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _autenticarLogin(String nome, String senha) async {
    _serviceAuthentication.loginUsuario(email: nome, senha: senha);
    User? user = _serviceAuthentication.getCurrentUser();
    if (user != null) {
      Navigator.pushNamed(context, AppRoutes.PLACE_LIST);
    } else {
      print('Erro no login.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Biométrico'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(children: [
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
                    String nome = _emailController.text;
                    String senha = _senhaController.text;

                    if (nome == '' || senha == '') {
                      return;
                    }
                    _autenticarLogin(nome, senha);
                  },
                  child: Text('Login'),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.REGISTER_SCREEN);
                  },
                  child: Text('Tela Registro'),
                ),
              ]),
            ),
            Text('Fazer login com Biometria.'),
            ElevatedButton(
              onPressed: _authenticate,
              child: Text('Biometria'),
            ),
            if (_biometricError.isNotEmpty)
              Text(
                _biometricError,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
