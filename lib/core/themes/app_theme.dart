import 'package:flutter/material.dart';

const double FONT_LARGE = 18;
const double FONT_BODY1 = 18;
const primaryColor = Color(0xff082659);
const secondaryColor = Color(0xff51eec2);
final appTheme = ThemeData(
  textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontSize: FONT_LARGE,
          fontWeight: FontWeight.w700,
          color: Colors.white),
      titleMedium: TextStyle(
          fontSize: FONT_BODY1,
          fontWeight: FontWeight.normal,
          color: Colors.black),
      displayLarge: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
      displayMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor,
    centerTitle: true,
  ),
  brightness: Brightness.light,
  primaryColor: primaryColor,
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: primaryColor),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: secondaryColor,
  ),
  inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 2, color: Colors.grey),
      ),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.red)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 2, color: Colors.blue),
      )),
);
