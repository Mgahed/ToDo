import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
              return Future<void>.delayed(const Duration(seconds: 2), () {
                checkUser(context, _token);
              });
            },
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todos[index]["todo"],
                      style: TextStyle(
                          decoration: todos[index]["status"]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none)),
                  subtitle: Text(todos[index]["category_id"].toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // _todoController.deleteTodo(todos[index]["id"]);
                    },
                  ),
                  leading: Checkbox(
                    value: todos[index]["status"],
                    activeColor: Theme.of(context).colorScheme.primary,
                    onChanged: (value) {
                      setState(() {
                        todos[index]["status"] = value;
                      });
                      _todoController.updateTodo(
                          todos[index]["id"],
                          todos[index]["category_id"],
                          todos[index]["todo"],
                          value,
                          _token);
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
