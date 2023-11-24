import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtenha o usuário atual
    User? user = FirebaseAuth.instance.currentUser;
    print(user);

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Center(
        child: user != null
            ? Text(
                'Bem-vindo, ${user.email ?? 'Usuário'}!',
                style: TextStyle(fontSize: 18),
              )
            : Text('Usuário não autenticado.'),
      ),
    );
  }
}
