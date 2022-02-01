import 'package:flutter/material.dart';

final ThemeData kLightTheme = _buildLightTheme();

ThemeData _buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: Colors.white,
    canvasColor: Colors.transparent,
    primaryIconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 24),
      bodyText1: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 24),
      bodyText2: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 18),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
  );
}

final ThemeData kDarkTheme = _buildDarkTheme();

ThemeData _buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    primaryColor: const Color(0xff323639),
    canvasColor: Colors.transparent,
    primaryIconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 24),
      bodyText1: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 24),
      bodyText2: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 18),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue),
  );
}

final ThemeData kAmoledTheme = _buildAmoledTheme();

ThemeData _buildAmoledTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    primaryColor: Colors.black,
    canvasColor: Colors.transparent,
    primaryIconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 24),
      bodyText1: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 24),
      bodyText2: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 18),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
  );
}
