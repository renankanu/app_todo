import 'package:flutter/material.dart';

class Utils {
  void showSnack(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
