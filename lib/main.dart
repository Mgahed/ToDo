import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mrttodo/screens/addTodo.dart';
import 'package:mrttodo/screens/editUserData.dart';
import 'package:mrttodo/screens/home.dart';
import 'package:mrttodo/screens/login.dart';
import 'package:mrttodo/screens/signup.dart';
import 'package:mrttodo/screens/splashScreen.dart';
import 'package:mrttodo/theme/my_theme.dart';

import 'controller/todoController.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TodoController());
    return GetMaterialApp(
      title: 'Todo List',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: lightTheme,
      ),
      darkTheme: ThemeData(
        colorScheme: darkTheme,
      ),
      // initialRoute: '/splash',
      home: const MySplashScreen(title: 'Todo App'),
      /*routes: {
        '/splash': (context) => const MySplashScreen(title: 'Todo App'),
        '/login': (context) => const Login(title: 'Login'),
        '/signup': (context) => const Signup(title: 'Login'),
        '/home': (context) => const Home(title: 'Todo App'),
        '/profile': (context) => const EditUserData(title: 'Edit Profile'),
      },*/
      getPages: [
        GetPage(
            name: '/splash',
            page: () => const MySplashScreen(title: 'Todo App')),
        GetPage(name: '/login', page: () => const Login(title: 'Login')),
        GetPage(name: '/signup', page: () => const Signup(title: 'Login')),
        GetPage(name: '/home', page: () => const Home(title: 'Todo App')),
        GetPage(
            name: '/profile',
            page: () => const EditUserData(title: 'Edit Profile')),
        GetPage(
            name: '/add-todo', page: () => const AddTodo(title: 'Add a Todo')),
      ],
    );
  }
}
