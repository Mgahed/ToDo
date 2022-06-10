import 'package:flutter/material.dart';

SnackBar customSnackBar(text, label) {
  return SnackBar(
    content: Text(text),
    /*shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
    ),*/
    duration: const Duration(milliseconds: 2000),
    action: SnackBarAction(
      label: label,
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
}
