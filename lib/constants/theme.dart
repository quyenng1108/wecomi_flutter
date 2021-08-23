import 'package:flutter/material.dart';
const kPrimaryColor = Color(0xFF00BF6D);
class ThemeConfig {
  static Color lightPrimary = Colors.white;
  static Color darkPrimary = Color(0xff1f1f1f);
  static Color lightAccent = Color(0xff2ca8e2);
  static Color darkAccent = Color(0xff2ca8e2);
  static Color lightBG = Color(0xffF4F6F9);
  static Color darkBG = Color(0xff121212);
  static Color selectedPink = Color(0xffB85985);
  static Color colorText = Color(0xffF05A77);
  static Color bgComment = Color(0xffF4F6F9);
  static Color bgTextComment = Color(0xff7F7F7F);
  static Color bgColor = Color(0xffDE5A7C);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: "Helvetica Neue",
    highlightColor: selectedPink,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.pink,
    ),
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    splashColor: Colors.transparent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
    ), textSelectionTheme: TextSelectionThemeData(cursorColor: lightAccent),
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
