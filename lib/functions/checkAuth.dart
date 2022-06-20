import 'package:flutter/material.dart';

import '../api/auth.dart';
import '../widgets/snackBar.dart';

checkUser(context, token) {
  getUserData(token).then((value) {
    if (!value['status']) {
      logout(token).then((response) {
        if (response["status"]) {
          Navigator.pushReplacementNamed(context, '/login');
        }
        final snackBar = customSnackBar(response["message"], "ok");
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  });
}
