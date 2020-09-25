import 'package:app_todo/screens/login/login_screen.dart';
import 'package:app_todo/screens/welcome/widgets/background.dart';
import 'package:app_todo/utils/images.dart';
import 'package:app_todo/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Bem vindo ao Kanu Todo",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              Images.chat,
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "ENTRAR",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "REGISTRAR",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return SignUpScreen();
                //     },
                //   ),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
