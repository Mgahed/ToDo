import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrttodo/screens/home.dart';

import '../api/todo.dart';
import '../functions/checkAuth.dart';
import '../widgets/snackBar.dart';

class TodoController extends GetxController {
  RxList todos = [].obs;

  void setTodo(comingTodos) {
    todos.value = comingTodos;
  }

  void updateTodo(todoId, categoryId, todo, status, token) {
    var data = {
      'id': todoId,
      'category_id': categoryId,
      'todo': todo,
      'status': status.toString(),
    };
    updateTodoApi(data, token).then((value) {
      if (value["status"]) {
        checkUser(Get.context, token);
      }
    });
  }

  void deleteTodo(todoId, token, context) {
    deleteTodoApi(todoId, token).then((value) {
      if (value["status"]) {
        checkUser(Get.context, token);
      }
      final snackBar = customSnackBar(value["message"], "ok");
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
