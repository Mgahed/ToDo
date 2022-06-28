import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../api/auth.dart';
import '../controller/todoController.dart';
import '../widgets/snackBar.dart';

final TodoController _todoController = Get.find();

checkUser(context, token) async {
  bool result = await InternetConnectionChecker().hasConnection;
  if (result == true) {
    print('YAY! Free cute dog pics!');
    getUserData(token).then((value) {
      if (!value['status']) {
        logout(token).then((response) {
          if (response["status"] || !value['status']) {
            Get.offNamed('/login');
          }
          final snackBar = customSnackBar(response["message"], "ok");
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      } else {
        var todos = value['todos'];
        _todoController.setTodo(todos);
      }
    });
  } else {
    print('No internet :( Reason:');
    final snackBar =
        customSnackBar("No internet connection please connect", "ok");
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
