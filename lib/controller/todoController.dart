import 'package:get/get.dart';

class TodoController extends GetxController {
  RxList todos = [].obs;

  void setTodo(comingTodos) {
    todos.value = comingTodos;
  }
}
