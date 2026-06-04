import 'package:flutter/material.dart';
import 'package:bmi_calculator/utils/local_variables.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: kBlue,
  secondaryHeaderColor: kMainTextColor,
  bottomAppBarTheme: BottomAppBarThemeData(
    color: kBlue,
  ),
  focusColor: kMainTextColor,
  disabledColor: kMainBorderColor,
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.white,
  //
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    shadowColor: null,
    titleTextStyle: TextStyle(
      color: kMainTextColor,
    ),
  ),
  //
  primaryTextTheme: TextTheme(
    displayLarge: TextStyle(
      color: kMainTextColor,
    ),
    bodyLarge: TextStyle(
      color: kMainTextColor,
    ),
    bodyMedium: TextStyle(
      color: kMainTextColor,
    ),
  ),
);
