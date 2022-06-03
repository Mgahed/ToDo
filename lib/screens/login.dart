import 'package:flutter/material.dart';

import '../googleSignIn.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;

  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {
    'email': '',
    'password': '',
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
                  "Login",
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
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter valid email';
                            }
                            return null;
                          },
                          onSaved: (value) => _formData['email'] = value!,
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
                              labelStyle: const TextStyle(color: Colors.grey)),
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
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade100)),
                              labelText: "Password",
                              enabledBorder: InputBorder.none,
                              labelStyle: const TextStyle(color: Colors.grey)),
                        )
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                          child: TextButton(
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.fontSize),
                            ),
                            onPressed: () {},
                          ))),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: _submitLogin,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.fontSize),
                            ),
                          ),
                        ),
                        FloatingActionButton(
                          backgroundColor: Colors.transparent,
                          onPressed: () {},
                          mini: true,
                          elevation: 0,
                          child: const Image(
                            image: AssetImage("assets/images/facebook.png"),
                          ),
                        ),
                        FloatingActionButton(
                          backgroundColor: Colors.transparent,
                          onPressed: () {
                            GooglSignInApi.login().then((user) {
                              if (user != null) {
                                print(user.displayName);
                                print(user.email);
                                print(user.photoUrl);
                                print(user.id);
                              }
                            });
                            // GooglSignInApi.logout();
                          },
                          mini: true,
                          elevation: 0,
                          child: const Image(
                            image: AssetImage("assets/images/google.png"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "DON'T HAVE AN ACCOUNT ? ",
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                        child: const Text(
                          "SIGN UP",
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/signup');
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

  void _submitLogin() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState?.save();
    print(_formData);
  }
}
