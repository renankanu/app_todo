import 'package:app_todo/app/screens/login/widget/no_account_text.dart';
import 'package:app_todo/app/screens/login/widget/social_icon.dart';
import 'package:app_todo/app/services/auth.dart';
import 'package:app_todo/app/utils/size_config.dart';
import 'package:app_todo/app/widgets/rounded_button.dart';
import 'package:app_todo/app/widgets/rounded_input_field.dart';
import 'package:app_todo/app/widgets/rounded_password_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

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
    SizeConfig().init(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Builder(builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/login.svg",
                    height: size.height * 0.20,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  RoundedInputField(
                    key: const ValueKey("username"),
                    hintText: "Email",
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  RoundedPasswordField(
                    key: const ValueKey("password"),
                    controller: _passwordController,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        // onTap: () => Navigator.pushNamed(
                        //     context, ForgotPasswordScreen.routeName),
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: kMatisse, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  RoundedButton(
                    key: const ValueKey("signIn"),
                    text: "Login",
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
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Expanded(
                        child: Divider(thickness: 1, color: kMatisse),
                      ),
                      SizedBox(width: SizeConfig.screenWidth * 0.02),
                      const Text(
                        'or',
                        style: TextStyle(
                            color: kMatisse, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: SizeConfig.screenWidth * 0.02),
                      const Expanded(
                        child: Divider(thickness: 1, color: kMatisse),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocalIcon(
                        iconSrc: "assets/icons/google.svg",
                        press: () {},
                      ),
                      SocalIcon(
                        iconSrc: "assets/icons/facebook.svg",
                        press: () {},
                      ),
                      SocalIcon(
                        iconSrc: "assets/icons/apple.svg",
                        press: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  const NoAccountText(),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
