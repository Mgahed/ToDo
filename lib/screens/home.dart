import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrttodo/controller/todoController.dart';

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
  final TodoController _todoController = Get.find();

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
      body: SafeArea(
        child: Obx(() {
          var todos = _todoController.todos.value;
          return RefreshIndicator(
            onRefresh: () async {
              // _todoController.getTodos();
            },
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todos[index]["todo"],
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough)),
                  subtitle: Text(todos[index]["category_id"].toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // _todoController.deleteTodo(todos[index]["id"]);
                    },
                  ),
                  leading: Checkbox(
                    value: todos[index]["status"],
                    onChanged: (value) {
                      // _todoController.updateTodo(todos[index]["id"], value);
                    },
                  ),
                );
              },
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed('/add-todo');
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Todo'),
      ),
    );
  }
}
