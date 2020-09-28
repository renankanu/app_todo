import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.controller,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
