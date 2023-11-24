import 'package:firebase_auth/firebase_auth.dart';

class AutenticacaoService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? getCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  loginUsuario({required String email, required String senha}) {
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: senha);
  }

  Future<void> registerUsuario(String email, String senha) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );
  }
}
