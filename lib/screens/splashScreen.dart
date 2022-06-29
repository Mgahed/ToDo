import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../functions/checkAuth.dart';
import '../functions/prefs.dart';
import 'home.dart';
import 'login.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  String _name = '';
  String _email = '';
  String _token = '';

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
      });
      checkUser(context, _token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      backgroundColor: Theme.of(context).colorScheme.background,
      loaderColor: Theme.of(context).colorScheme.secondary,
      logo: Image.asset(
        'assets/images/logo.png',
        width: MediaQuery.of(context).size.width * 0.5,
      ),
      // logoSize: MediaQuery.of(context).size.width * 0.5,
      title: const Text(
        "Todo List",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      showLoader: false,
      // loadingText: const Text("Loading..."),
      navigator: _token == ''
          ? const Login(title: 'Login')
          : const Home(title: 'Todo App'),
      durationInSeconds: 5,
    );
  }
}
