import 'package:app_todo/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Lato",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    cupertinoOverrideTheme: const CupertinoThemeData(
      primaryColor: kGreenPea,
    ),
    cursorColor: kGreenPea,
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: kGreenPea, width: 0.7),
  );
  return InputDecorationTheme(
    labelStyle: const TextStyle(color: kGreenPea),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
    hintStyle: const TextStyle(color: kGreenPea),
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    centerTitle: true,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: kGreenPea),
    textTheme: TextTheme(
      headline6: TextStyle(color: kGreenPea, fontSize: 18),
    ),
  );
}
