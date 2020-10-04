import 'package:app_todo/app/utils/size_config.dart';
import 'package:app_todo/app/utils/utils.dart';
import 'package:app_todo/app/widgets/rounded_button.dart';
import 'package:app_todo/app/widgets/rounded_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();

    void changStateIsloading({bool isloading}) {
      setState(() {
        _isLoading = isloading;
      });
    }

    Future validEmail(BuildContext context) async {
      if (_emailController.text.isEmpty) {
        Utils().showSnack(context, "Informe o email.", kPersimmon);
        changStateIsloading(isloading: false);
        return;
      }
      if (!emailValidatorRegExp.hasMatch(_emailController.text)) {
        Utils().showSnack(context, "Informe um email válido.", kPersimmon);
        changStateIsloading(isloading: false);
        return;
      }
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text);
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Utils().showSnack(context, "Usuário não encontrado.", kPersimmon);
          changStateIsloading(isloading: false);
          return;
        }
        Utils().showSnack(
            context, "Opps, não foi possível enviar o link. 😕", kPersimmon);
        changStateIsloading(isloading: false);
      } catch (e) {
        rethrow;
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
                  isLoading: _isLoading,
                  text: "Me envie o link",
                  press: () async {
                    changStateIsloading(isloading: true);
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
