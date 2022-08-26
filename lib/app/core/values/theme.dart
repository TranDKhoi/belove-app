import 'package:belove_app/app/core/values/color.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  textTheme: ThemeData.light().textTheme.apply(
        fontFamily: "Arima",
      ),
  colorScheme: const ColorScheme.light(primary: AppColors.primaryColor),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    foregroundColor: Colors.white,
  ),
);
