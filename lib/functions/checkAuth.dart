import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../api/auth.dart';
import '../controller/todoController.dart';
import '../widgets/snackBar.dart';

final TodoController _todoController = Get.find();

checkUser(context, token) {
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
}
