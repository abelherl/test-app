import 'package:flutter/material.dart';

ThemeData mainTheme() {
  final fontFamily = 'Poppins';
  final accentColor = Colors.brown;
  final primaryColor = accentColor[200];

  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
      headline5: base.headline5.copyWith(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w900,
        fontSize: 17,
        color: Colors.black87
      ),
      subtitle1: base.subtitle1.copyWith(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.black38
      )
    );
  }

  final ThemeData base = ThemeData.light();

  return base.copyWith(
    textTheme: _basicTextTheme(base.textTheme),
    primaryColor: primaryColor,
    accentColor: accentColor
  );
}