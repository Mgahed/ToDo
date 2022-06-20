import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('_name') ?? '';
      _email = prefs.getString('_email') ?? '';
      _token = prefs.getString('_token') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      backgroundColor: Theme.of(context).colorScheme.background,
      loaderColor: Theme.of(context).colorScheme.secondary,
      logo: Image.network(
          'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/25425fb2-bc94-4349-8d8a-6eabb4d6ccd2/dbww48m-e74bf3fc-83e1-469d-bfd4-0c64c6db2965.gif?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzI1NDI1ZmIyLWJjOTQtNDM0OS04ZDhhLTZlYWJiNGQ2Y2NkMlwvZGJ3dzQ4bS1lNzRiZjNmYy04M2UxLTQ2OWQtYmZkNC0wYzY0YzZkYjI5NjUuZ2lmIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.0xUgvsA4QUzPfzS05r9zSAaekcd7Sh0xXf5eb2EN3E0'),
      logoSize: MediaQuery.of(context).size.width * 0.5,
      title: const Text(
        "Todo",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      showLoader: true,
      loadingText: const Text("Loading..."),
      navigator: _token == ''
          ? const Login(title: 'Login')
          : const Home(title: 'Todo App'),
      durationInSeconds: 5,
    );
  }
}
