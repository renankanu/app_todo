import 'package:app_todo/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: "Poppins",
      appBarTheme: appBarTheme(),
      textTheme: textTheme(),
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: kMatisse,
      ),
      cursorColor: kMatisse,
      inputDecorationTheme: inputDecorationTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      unselectedWidgetColor: kLuckyPoint);
}

InputDecorationTheme inputDecorationTheme() {
  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: kMatisse, width: 0.7),
  );
  return InputDecorationTheme(
    labelStyle: const TextStyle(color: kMatisse),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
    hintStyle: const TextStyle(color: kAzure),
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: Colors.black),
    bodyText2: TextStyle(color: Colors.black),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    centerTitle: true,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: kMatisse),
    textTheme: TextTheme(
      headline6: TextStyle(color: kMatisse, fontSize: 18),
    ),
  );
}
