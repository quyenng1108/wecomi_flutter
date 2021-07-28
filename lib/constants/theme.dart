import 'package:flutter/material.dart';

class ThemeConfig {
  static Color lightPrimary = Colors.white;
  static Color darkPrimary = Color(0xff1f1f1f);
  static Color lightAccent = Color(0xff2ca8e2);
  static Color darkAccent = Color(0xff2ca8e2);
  static Color lightBG = Color(0xffF4F6F9);
  static Color darkBG = Color(0xff121212);
  static Color selectedPink = Color(0xffB85985);

  static ThemeData lightTheme = ThemeData(
    fontFamily: "Helvetica Neue",
    highlightColor: selectedPink,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.pink,
    ),
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    splashColor: Colors.transparent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: "Helvetica Neue",
    highlightColor: selectedPink,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.pink,
    ),
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    splashColor: Colors.transparent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
    ),
  );

}