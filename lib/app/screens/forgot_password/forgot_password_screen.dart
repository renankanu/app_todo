import 'package:app_todo/app/utils/size_config.dart';
import 'package:app_todo/app/widgets/rounded_button.dart';
import 'package:app_todo/app/widgets/rounded_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();

    Future validEmail(BuildContext context) async {
      if (_emailController.text.isEmpty) {
        Scaffold.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter your email"),
          ),
        );
        return;
      }
      if (!emailValidatorRegExp.hasMatch(_emailController.text)) {
        Scaffold.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter valid email"),
          ),
        );
        return;
      }
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text);
        Navigator.pop(context);
      } on Exception catch (error) {
        Scaffold.of(context).showSnackBar(
          const SnackBar(
            content: Text("Opps! 😕"),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Builder(builder: (BuildContext context) {
            return Column(
              children: [
                const Text(
                  "Esqueceu a Senha",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: kMatisse,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                const Text(
                  "Enviaremos um link em seu e-mail para redefinir sua senha",
                  style: TextStyle(color: kLuckyPoint),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                RoundedInputField(
                  hintText: "Email",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                RoundedButton(
                  text: "Me envie o link",
                  press: () async {
                    await validEmail(context);
                  },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
