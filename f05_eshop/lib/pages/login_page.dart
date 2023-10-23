import 'package:f05_eshop/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../model/user.dart';
import '../utils/app_routes.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userName = TextEditingController();
  final _userPassword = TextEditingController();
  String _erro = "";
  List<User> _users = [];

  Future<void> loadUsersFromDatabase() async {
    final response = await http.get(
      Uri.parse(
          'https://miniprojeto4-flutter-default-rtdb.firebaseio.com/users.json'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<User> users = [];

      jsonData.forEach((userId, userData) {
        users.add(User.fromJson(userId, userData));
      });
      setState(() {
        _users = users;
      });
    } else {
      throw Exception('Failed to load Users');
    }
  }

  _login(BuildContext context) {
    loadUsersFromDatabase();

    if (autentication(_users, _userName.text, _userPassword.text)) {
      Navigator.of(context).pushNamed(AppRoutes.PRODUCTS_PAGE);
    } else {
      setState(() {
        _erro = "Usuário ou senha incorretos!";
      });
    }
  }

  autentication(List<User> users, String name, String password) {
    final userController = Provider.of<UserController>(context, listen: false);
    bool exists = users.any((u) => u.name == name && u.password == password);
    if (exists) {
      User user =
          users.singleWhere((u) => u.name == name && u.password == password);
      userController.setUserId(user.id);
    }
    return exists;
  }

  @override
  void initState() {
    super.initState();
    loadUsersFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(40.0),
            child: Column(
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _userName,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      floatingLabelStyle:
                          TextStyle(color: Colors.grey, fontSize: 18),
                      labelText: "Usuário",
                      filled: true,
                      prefixIcon: Icon(Icons.person),
                      prefixIconColor: Colors.grey,
                      fillColor: Colors.white),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _userPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      floatingLabelStyle:
                          TextStyle(color: Colors.grey, fontSize: 18),
                      labelText: "Senha",
                      filled: true,
                      prefixIcon: Icon(Icons.key),
                      prefixIconColor: Colors.grey,
                      fillColor: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  _erro,
                  style: TextStyle(color: Colors.red[700]),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
                            onPressed: () => _login(context),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ))),
                  ],
                ),
                Divider(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
                    onPressed: () => {
                          Navigator.of(context).pushNamed(AppRoutes.SIGNUP_PAGE)
                        },
                    child: Text(
                      "SignUp Page",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
