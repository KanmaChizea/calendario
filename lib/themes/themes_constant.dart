import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.purple,
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.purple, foregroundColor: Colors.white),
  cardColor: Colors.white,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.purpleAccent, foregroundColor: Colors.white),
  iconTheme: const IconThemeData(color: Colors.purple),
  checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all<Color>(Colors.white),
      fillColor: MaterialStateProperty.all<Color>(Colors.purpleAccent)),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          overlayColor: MaterialStateProperty.all<Color>(Colors.black),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))))),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
    primary: Colors.purpleAccent,
  )),
  dividerColor: Colors.purple,
  radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all<Color>(Colors.purpleAccent)),
  textTheme: const TextTheme(
    titleSmall: TextStyle(
        fontSize: 11, fontWeight: FontWeight.bold, color: Colors.purpleAccent),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black26,
  textTheme: const TextTheme(
    titleSmall: TextStyle(
        fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black12, foregroundColor: Colors.white),
  cardColor: Colors.black45,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      foregroundColor: Colors.purple,
      splashColor: Colors.black),
  iconTheme: const IconThemeData(color: Colors.purple),
  primarySwatch: Colors.purple,
  checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all<Color>(Colors.black),
      fillColor: MaterialStateProperty.all<Color>(Colors.white)),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          overlayColor: MaterialStateProperty.all<Color>(Colors.black),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))))),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
    primary: Colors.white,
  )),
  dividerColor: Colors.white,
  radioTheme:
      RadioThemeData(fillColor: MaterialStateProperty.all<Color>(Colors.white)),
);
