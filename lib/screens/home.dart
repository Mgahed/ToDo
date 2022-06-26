import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../functions/checkAuth.dart';
import '../functions/prefs.dart';
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
    getDataPrefs().then((value) {
      setState(() {
        _name = value['_name'] ?? '';
        _email = value['_email'] ?? '';
        _token = value['_token'] ?? '';
        _exp = value['_exp'] ?? '';
      });
      if (_token == '') {
        Get.offNamed('/login');
      }
      checkUser(context, _token);
    });
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/add-todo');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
