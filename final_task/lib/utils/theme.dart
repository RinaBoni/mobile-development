import 'package:flutter/material.dart';

ThemeData basicTheme() => ThemeData(
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blueAccent,
    textTheme: ButtonTextTheme.accent,
  ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
);