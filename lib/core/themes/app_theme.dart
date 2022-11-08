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
            color: Colors.black)),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      centerTitle: true,
    ),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: secondaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: primaryColor),
        iconColor: secondaryColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: secondaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(8),
        )));
