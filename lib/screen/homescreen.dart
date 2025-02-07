import 'package:counter_app/screen/login_screen.dart';
import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../model/user.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.user.count;
  }

  void _increment() async {
    setState(() => _count++);
    await DatabaseHelper.instance.updateCount(widget.user.username, _count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen())),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${widget.user.username}'),
            Text('Count: $_count'),
            ElevatedButton(
              onPressed: _increment,
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}