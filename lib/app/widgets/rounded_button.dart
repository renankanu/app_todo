import 'package:flutter/material.dart';

import '../../constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final void Function() press;
  final Color color, textColor;
  final bool isLoading;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = kLuckyPoint,
    this.textColor = Colors.white,
    this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: color,
        onPressed: press,
        child: buildCircularProgressIndicatorOrText(),
      ),
    );
  }

  Widget buildCircularProgressIndicatorOrText() {
    if (isLoading) {
      return Container(
        width: 20,
        height: 20,
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 2.0,
        ),
      );
    }
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: textColor,
      ),
    );
  }
}
