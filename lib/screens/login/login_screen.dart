import 'package:app_todo/services/auth.dart';
import 'package:app_todo/widgets/rounded_button.dart';
import 'package:app_todo/widgets/rounded_input_field.dart';
import 'package:app_todo/widgets/rounded_password_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class LoginScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const LoginScreen({Key key, @required this.auth, @required this.firestore})
      : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Builder(builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedInputField(
                  key: const ValueKey("username"),
                  hintText: "Your Email",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                RoundedPasswordField(
                  key: const ValueKey("password"),
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  color: Colors.black,
                  height: 20,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
                RoundedButton(
                  key: const ValueKey("signIn"),
                  text: "LOGIN",
                  press: () async {
                    final String returnValue =
                        await Auth(auth: widget.auth).signIn(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    if (returnValue == "Success") {
                      _emailController.clear();
                      _passwordController.clear();
                    } else {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(returnValue),
                        ),
                      );
                    }
                  },
                ),
                RoundedButton(
                  key: const ValueKey("createAccount"),
                  text: "Create Account",
                  color: kPrimaryLightColor,
                  textColor: Colors.black,
                  press: () async {
                    final String returnValue =
                        await Auth(auth: widget.auth).createAccount(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    if (returnValue == "Success") {
                      _emailController.clear();
                      _passwordController.clear();
                    } else {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(returnValue),
                        ),
                      );
                    }
                  },
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
