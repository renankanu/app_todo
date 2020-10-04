import 'package:flutter/material.dart';

class Utils {
  void showSnack(BuildContext context, String message, Color backgroundColor) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
