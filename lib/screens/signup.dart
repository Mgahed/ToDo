import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;

  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();

  final Map<String, String> _formData = {
    'name': '',
    'email': '',
    'password': '',
    'passwordConfirm': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            right: -getSmallDiameter(context) / 3,
            top: -getSmallDiameter(context) / 3,
            child: Container(
              width: getSmallDiameter(context),
              height: getSmallDiameter(context),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primaryContainer
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            left: -getBiglDiameter(context) / 4,
            top: -getBiglDiameter(context) / 4,
            child: Container(
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primaryContainer,
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Center(
                child: Text(
                  "SignUp",
                  style: TextStyle(
                    fontFamily: "Pacifico",
                    fontSize: Theme.of(context).textTheme.headline3?.fontSize,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        //border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.fromLTRB(20, 300, 20, 10),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _formData['name'] = value!;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.supervised_user_circle,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100)),
                            labelText: "Name",
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter valid email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _formData['email'] = value!;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100)),
                            labelText: "Email",
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                        TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 6) {
                              return 'Please enter valid password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _formData['password'] = value!;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.vpn_key,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100)),
                            labelText: "Password",
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value != _passwordController.text) {
                              return 'Password don\'t match';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _formData['passwordConfirm'] = value!;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.vpn_key_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100)),
                            labelText: "Confirm Password",
                            enabledBorder: InputBorder.none,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(25, 30, 25, 30),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: _submitSignup,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.fontSize),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "HAVE AN ACCOUNT ? ",
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _submitSignup() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState?.save();
    print(_formData);
  }
}
