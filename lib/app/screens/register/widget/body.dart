import 'package:app_todo/app/services/auth.dart';
import 'package:app_todo/app/utils/size_config.dart';
import 'package:app_todo/app/utils/utils.dart';
import 'package:app_todo/app/widgets/rounded_button.dart';
import 'package:app_todo/app/widgets/rounded_input_field.dart';
import 'package:app_todo/app/widgets/rounded_password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class Body extends StatelessWidget {
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

  Future validPassword(BuildContext context) async {
    if (_emailController.text.isEmpty) {
      Utils().showSnack(context, "Informe o email.", kPersimmon);
      return;
    }
    if (!emailValidatorRegExp.hasMatch(_emailController.text)) {
      Utils().showSnack(context, "Informe um email válido.", kPersimmon);
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      Utils().showSnack(context, "As senhas não coincidem.", kPersimmon);
      return;
    }
    final String returnValue = await Auth(auth: _auth).createAccount(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (returnValue == "Success") {
      _emailController.clear();
      _passwordController.clear();
      Navigator.pop(context);
    } else {
      Utils().showSnack(context, returnValue, kPersimmon);
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
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  RoundedPasswordField(
                    hintText: "Senha",
                    controller: _passwordController,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  RoundedPasswordField(
                    hintText: "Confire a Senha",
                    controller: _confirmPasswordController,
                  ),
                  Expanded(child: Container()),
                  RoundedButton(
                    text: "Cadastro",
                    press: () async {
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
