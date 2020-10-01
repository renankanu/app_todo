import 'package:app_todo/app/utils/my_icons.dart';
import 'package:app_todo/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoundedPasswordField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  const RoundedPasswordField({
    Key key,
    this.controller,
    this.hintText,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _passwordVisible;
  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !_passwordVisible,
      controller: widget.controller,
      decoration: InputDecoration(
        border: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        enabledBorder: outlineInputBorder(),
        hintText: widget.hintText,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(
              () {
                _passwordVisible = !_passwordVisible;
              },
            );
          },
          child: _passwordVisible
              ? Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SvgPicture.asset(
                    MyIcons.show,
                    color: kMatisse,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SvgPicture.asset(
                    MyIcons.hide,
                    color: kMatisse,
                  ),
                ),
        ),
      ),
    );
  }
}
