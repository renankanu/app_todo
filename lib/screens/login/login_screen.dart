import 'package:app_todo/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Builder(builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(hintText: "Username"),
                  controller: _emailController,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(hintText: "Password"),
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () async {
                    final String returnValue = await Auth(auth: _auth).signIn(
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
                  child: const Text("Sign In"),
                ),
                FlatButton(
                  onPressed: () async {
                    final String returnValue =
                        await Auth(auth: _auth).createAccount(
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
                  child: const Text("Create Account"),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
