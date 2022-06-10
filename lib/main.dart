import 'package:flutter/material.dart';
import 'package:mrttodo/screens/home.dart';
import 'package:mrttodo/screens/login.dart';
import 'package:mrttodo/screens/signup.dart';
import 'package:mrttodo/screens/splashScreen.dart';
import 'package:mrttodo/theme/my_theme.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: lightTheme,
      ),
      darkTheme: ThemeData(
        colorScheme: darkTheme,
      ),
      initialRoute: '/splash',
      // home: MyHomePage(),
      routes: {
        '/splash': (context) => const MySplashScreen(title: 'Todo App'),
        '/login': (context) => const Login(title: 'Login'),
        '/signup': (context) => const Signup(title: 'Login'),
        '/home': (context) => const Home(title: 'Todo App'),
      },
    );
  }
}
