import 'package:app_todo/utils/images.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                Images.mainTop,
                width: size.width * 0.3,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                Images.mainBottom,
                width: size.width * 0.2,
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
