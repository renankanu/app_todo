import 'package:app_todo/app/screens/register/register_screen.dart';
import 'package:app_todo/app/utils/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Não tem uma conta? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(14)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterScreen()),
            );
          },
          child: Text(
            "Registrar",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(14), color: kMatisse),
          ),
        ),
      ],
    );
  }
}
