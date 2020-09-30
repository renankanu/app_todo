import 'package:flutter/material.dart';

class RoundedPasswordField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const RoundedPasswordField({
    Key key,
    this.controller,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
