import 'package:flutter/material.dart';

import 'local_variables.dart';

ThemeData darkTheme = ThemeData(
  primaryColor: kDark,
  secondaryHeaderColor: Colors.white,
  focusColor: kMainBorderColor,
  disabledColor: kDarkModeCardColor,
  appBarTheme: AppBarTheme(
    backgroundColor: kDarkAppBar,
    titleTextStyle: TextStyle(
      color: kDarkModeMainTextColor,
    ),
  ),
  bottomAppBarTheme: BottomAppBarThemeData(
    color: kDarkModeBottomAppBar,
  ),
  scaffoldBackgroundColor: kDark,
  cardColor: kDarkModeCardColor,
  //
  primaryTextTheme: TextTheme(
    displayLarge: TextStyle(
      color: kDarkModeMainTextColor,
    ),
    bodyLarge: TextStyle(
      color: kDarkModeMainTextColor,
    ),
    bodyMedium: TextStyle(
      color: kDarkModeMainTextColor,
    ),
  ),
);
