import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../model/user.dart';
import 'homescreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    final username = _usernameController.text.trim();
    if (username.isEmpty) return;

    final dbHelper = DatabaseHelper.instance;
    User? user = await dbHelper.getUser(username);

    if (user == null) {
      await dbHelper.insertUser(User(username: username, count: 0));
      user = User(username: username, count: 0);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(user: user!),
      ),
    );
  }
}