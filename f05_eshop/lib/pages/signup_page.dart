import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';
import '../utils/app_routes.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _userName = TextEditingController();
  final _userPassword = TextEditingController();
  String _erro = "";
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    loadUsersFromDatabase();
  }

  _signup(BuildContext context) {
    if (autentication(_users, _userName.text)) {
      addUser(_userName.text, _userPassword.text);
      Navigator.of(context).pushNamed(AppRoutes.LOGIN_PAGE);
    } else {
      setState(() {
        _erro = "Usuário já cadastrado!";
      });
    }
  }

  autentication(List<User> users, String name) {
    bool exists = users.any((p) => p.name == name);
    if (exists) {
      return false;
    } else {
      return true;
    }
  }

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
      _users = users;
    } else {
      throw Exception('Failed to load Users');
    }
  }

  Future<void> addUser(String name, String password) async {
    final future = http.post(
        Uri.parse(
            'https://miniprojeto4-flutter-default-rtdb.firebaseio.com/users.json'),
        body: jsonEncode({
          "name": name,
          "password": password,
        }));
    return future.then((response) {
      print(jsonDecode(response.body));
      final id = jsonDecode(response.body)['name'];
      print(response.statusCode);
    });
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
                  'SignUp',
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
                            onPressed: () => {_signup(context)},
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ))),
                  ],
                ),
                Divider(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
                    onPressed: () =>
                        {Navigator.of(context).pushNamed(AppRoutes.LOGIN_PAGE)},
                    child: Text(
                      "Login Page",
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
