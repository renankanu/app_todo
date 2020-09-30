import 'package:app_todo/app/services/auth.dart';
import 'package:app_todo/app/utils/size_config.dart';
import 'package:app_todo/app/widgets/rounded_button.dart';
import 'package:app_todo/app/widgets/rounded_input_field.dart';
import 'package:app_todo/app/widgets/rounded_password_field.dart';
import 'package:app_todo/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text("Error"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Builder(builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              color: kMatisse,
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          RoundedInputField(
                            hintText: "Email",
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.02),
                          RoundedPasswordField(
                            controller: _passwordController,
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.04),
                          RoundedButton(
                            text: "Register",
                            press: () async {
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
                          ),
                        ],
                      ),
                    );
                  })),
            );
          }
          return const Scaffold(
            body: Center(
              child: Text("Loading..."),
            ),
          );
        });
  }
}
