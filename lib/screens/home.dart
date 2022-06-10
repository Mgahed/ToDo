import 'package:flutter/material.dart';
import 'package:mrttodo/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/drawerWidget.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _name = '';
  String _email = '';
  String _token = '';
  String _exp = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('_name') ?? '';
      _email = prefs.getString('_email') ?? '';
      _token = prefs.getString('_token') ?? '';
      _exp = prefs.getString('_exp') ?? '';
    });
    if (_token == '') {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Name: $_name'),
          Text('Email: $_email'),
          Text('Exp: $_exp'),
        ]),
      ),
    );
  }
}
