import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../api/auth.dart';
import '../functions/checkAuth.dart';
import '../functions/prefs.dart';
import '../widgets/drawerWidget.dart';
import '../widgets/snackBar.dart';

class EditUserData extends StatefulWidget {
  const EditUserData({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<EditUserData> createState() => _EditUserDataState();
}

class _EditUserDataState extends State<EditUserData> {
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

  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {
    'username': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: _name);
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return Future<void>.delayed(const Duration(seconds: 3), () {
            setState(() {});
            getData();
          });
        },
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
                      margin: EdgeInsets.fromLTRB(
                          20, MediaQuery.of(context).size.height / 4, 20, 10),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter valid name';
                              }
                              return null;
                            },
                            onEditingComplete: () {
                              _name = nameController.text;
                            },
                            onSaved: (value) => _formData['username'] = value!,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.person,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade100)),
                                labelText: "Name",
                                enabledBorder: InputBorder.none,
                                labelStyle:
                                    const TextStyle(color: Colors.grey)),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            onSaved: (value) => _formData['password'] = value!,
                            obscureText: true,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.vpn_key,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade100)),
                                labelText: "Password",
                                enabledBorder: InputBorder.none,
                                labelStyle:
                                    const TextStyle(color: Colors.grey)),
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
                          onPressed: _submitEditData,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Edit Data",
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(20),
                width: double.infinity,
                height: 40,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Delete Account',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _submitEditData() {
    /*if (!_formKey.currentState!.validate()) {
      return;
    }*/
    _formKey.currentState?.save();
    updateUserData(_token, _formData).then((response) {
      final snackBar = customSnackBar(response["message"], "ok");
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      /*setState(() {});*/
    });
  }
}
