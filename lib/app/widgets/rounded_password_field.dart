import 'package:flutter/material.dart';

class RoundedPasswordField extends StatelessWidget {
  final TextEditingController controller;
  const RoundedPasswordField({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      controller: controller,
      decoration: const InputDecoration(
        hintText: "Password",
      ),
    );
  }
}
