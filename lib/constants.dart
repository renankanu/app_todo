import 'package:app_todo/app/utils/size_config.dart';
import 'package:flutter/material.dart';

const kLuckyPoint = Color(0xFF163172);
const kMatisse = Color(0xFF1E56A0);
const kLinkWater = Color(0xFFD6E4F0);
const kWildSand = Color(0xFFF6F6F6);
const kWhite = Color(0xFFFFFFFF);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: kMatisse),
  );
}
