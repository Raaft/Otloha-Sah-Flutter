import 'package:flutter/material.dart';

class AppThemes {
  ThemeData get lightTheme => ThemeItem.getThemeItems()[1].themeData;

  ThemeData get darkTheme => ThemeItem.getThemeItems()[3].themeData;
}

class ThemeItem {
  int id;
  String name, slug;
  ThemeData themeData;

  ThemeItem(this.id, this.name, this.slug, this.themeData);

  static List<ThemeItem> getThemeItems() {
    return <ThemeItem>[
      ThemeItem(
          1,
          'Dark Purple & Amber(Light)',
          'light-purple-amber',
          ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.purple,
              primarySwatch: Colors.amber,
              iconTheme: const IconThemeData(color: Colors.amber),
              textTheme: const TextTheme(
                  subtitle1: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  subtitle2: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54)))),
      ThemeItem(
          2,
          'Indigo & Pink(Light)',
          'light-indigo-pink',
          ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.indigo,
              primarySwatch: Colors.pink,
              iconTheme: const IconThemeData(color: Colors.pink),
              textTheme: const TextTheme(
                  subtitle1: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  subtitle2: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54)))),
      ThemeItem(
          3,
          'Pink & BlueGrey(Dark)',
          'dark-pink-bluegrey',
          ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.blueGrey,
              primaryColor: Colors.pink,
              iconTheme: const IconThemeData(color: Colors.blueGrey),
              textTheme: const TextTheme(
                  subtitle1: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  subtitle2: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.white70)))),
      ThemeItem(
          4,
          'Purple & Green(Dark)',
          'dark-purple-green',
          ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.purple,
              primarySwatch: Colors.green,
              iconTheme: const IconThemeData(color: Colors.green),
              textTheme: const TextTheme(
                  subtitle1: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  subtitle2: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.white70)))),
    ];
  }
}
