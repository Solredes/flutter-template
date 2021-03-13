import 'package:flutter/material.dart';

class AppThemeData {
  static const MaterialColor colorApp = MaterialColor(0xFF00244D, <int, Color>{
    50: Color(0xFFE0E5EA),
    100: Color(0xFFB3BDCA),
    200: Color(0xFF8092A6),
    300: Color(0xFF4D6682),
    400: Color(0xFF264568),
    500: Color(0xFF00244D),
    600: Color(0xFF002046),
    700: Color(0xFF001B3D),
    800: Color(0xFF001634),
    900: Color(0xFF000D25),
  });

  static const MaterialColor colorAccentApp =
      MaterialColor(0xFF8BB717, <int, Color>{
    100: Color(0xFFDCE9B9),
    200: Color(0xFFC5DB8B),
    400: Color(0xFF8BB717),
    700: Color(0xFF78A711),
  });

  static ThemeData darkThemeData = ThemeData(
    brightness: Brightness.dark,
    primaryColor: colorApp,
    accentColor: colorAccentApp,
    primarySwatch: colorApp,
    buttonTheme: ButtonThemeData(
      buttonColor: colorApp,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
  );

  static ThemeData lightThemeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: colorApp,
    accentColor: colorAccentApp,
    primarySwatch: colorApp,
    buttonTheme: ButtonThemeData(
      buttonColor: colorApp,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
  );
}
