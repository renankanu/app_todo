import 'package:app_todo/app/services/auth.dart';
import 'package:app_todo/app/utils/size_config.dart';
import 'package:app_todo/app/utils/utils.dart';
import 'package:app_todo/app/widgets/rounded_button.dart';
import 'package:app_todo/app/widgets/rounded_input_field.dart';
import 'package:app_todo/app/widgets/rounded_password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
    @required TextEditingController emailController,
    @required TextEditingController passwordController,
    @required TextEditingController confirmPasswordController,
    @required FirebaseAuth auth,
  })  : _emailController = emailController,
        _passwordController = passwordController,
        _confirmPasswordController = confirmPasswordController,
        _auth = auth,
        super(key: key);

  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _confirmPasswordController;
  final FirebaseAuth _auth;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isLoading = false;

  void changStateIsloading({bool isloading}) {
    setState(() {
      _isLoading = isloading;
    });
  }

  Future validPassword(BuildContext context) async {
    if (widget._emailController.text.isEmpty) {
      Utils().showSnack(context, "Informe o email.", kPersimmon);
      changStateIsloading(isloading: false);
      return;
    }
    if (!emailValidatorRegExp.hasMatch(widget._emailController.text)) {
      Utils().showSnack(context, "Informe um email válido.", kPersimmon);
      changStateIsloading(isloading: false);
      return;
    }
    if (widget._passwordController.text !=
        widget._confirmPasswordController.text) {
      Utils().showSnack(context, "As senhas não coincidem.", kPersimmon);
      changStateIsloading(isloading: false);
      return;
    }
    final String returnValue = await Auth(auth: widget._auth).createAccount(
      email: widget._emailController.text,
      password: widget._passwordController.text,
    );
    if (returnValue == "Success") {
      widget._emailController.clear();
      widget._passwordController.clear();
      changStateIsloading(isloading: false);
      Navigator.pop(context);
    } else {
      Utils().showSnack(context, returnValue, kPersimmon);
      changStateIsloading(isloading: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                children: [
                  const Text(
                    'Cadastro',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      color: kMatisse,
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  RoundedInputField(
                    hintText: "Email",
                    controller: widget._emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  RoundedPasswordField(
                    hintText: "Senha",
                    controller: widget._passwordController,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  RoundedPasswordField(
                    hintText: "Confire a Senha",
                    controller: widget._confirmPasswordController,
                  ),
                  Expanded(child: Container()),
                  RoundedButton(
                    isLoading: _isLoading,
                    text: "Cadastro",
                    press: () async {
                      changStateIsloading(isloading: true);
                      await validPassword(context);
                    },
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Já possui uma conta? ",
                        style: TextStyle(fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Entrar",
                          style: TextStyle(fontSize: 14, color: kMatisse),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
