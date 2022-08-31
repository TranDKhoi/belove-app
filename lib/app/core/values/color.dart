import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xffCE7BB0);

  final ThemeData lightTheme = ThemeData.light().copyWith(
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: "Comfortaa",
        ),
    colorScheme: const ColorScheme.light(primary: primaryColor),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
    ),
  );

  final ThemeData darkTheme = ThemeData.dark().copyWith(
    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: "Comfortaa",
        ),
    colorScheme: const ColorScheme.dark(primary: primaryColor),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
    ),
  );
}
