import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../api/category.dart';
import '../api/todo.dart';
import '../controller/categoryController.dart';
import '../functions/checkAuth.dart';
import '../functions/prefs.dart';
import '../widgets/snackBar.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final CategoryController _categoryController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {
    'todo': '',
    'category_id': '',
  };

  var categories = [];
  String _token = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    getDataPrefs().then((value) async {
      setState(() {
        _token = value['_token'] ?? '';
      });
      if (_token == '') {
        Get.offNamed('/login');
      }
      getCategories(_token).then((value) {
        setState(() {
          categories = _categoryController.categories;
        });
      });
      checkUser(context, _token);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          //border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter valid todo name';
                              }
                              return null;
                            },
                            onSaved: (value) => _formData['todo'] = value!,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.history_edu,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade100)),
                                labelText: "Todo Name",
                                enabledBorder: InputBorder.none,
                                labelStyle:
                                    const TextStyle(color: Colors.grey)),
                          ),
                          DropdownButtonFormField(
                            validator: (value) {
                              if (value == null) {
                                return 'Please select valid todo category';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.category,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              labelText: "Category",
                              enabledBorder: InputBorder.none,
                            ),
                            // value: "One",
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            onChanged: (newValue) {
                              setState(() {
                                _formData['category_id'] = newValue!.toString();
                              });
                            },
                            items: categories.map((category) {
                              return DropdownMenuItem<String>(
                                value: category["id"].toString(),
                                child: Text(category["name"]),
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                      child: SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitAddTodo,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Add Todo",
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.fontSize),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitAddTodo() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    createTodo(_formData, _token).then((response) {
      final snackBar = customSnackBar(response["message"], "ok");
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
