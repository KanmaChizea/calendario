import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.indigo,
  primaryColor: const Color(0xff153258),
  appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff153258), foregroundColor: Colors.white),
  cardColor: Colors.white,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xff283541), foregroundColor: Colors.white),
  iconTheme: const IconThemeData(color: Colors.black),
  checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all<Color>(Colors.white),
      fillColor: MaterialStateProperty.all<Color>(const Color(0xff153258))),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xff153258)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          overlayColor: MaterialStateProperty.all<Color>(Colors.black),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))))),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
    primary: const Color(0xff283541),
  )),
  dividerColor: const Color(0xFFC9D8E6),
  radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all<Color>(const Color(0xff153258))),
  textTheme: const TextTheme(
    titleSmall: TextStyle(
        fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xff283541)),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black26,
  primaryColor: Colors.white,
  textTheme: const TextTheme(
    titleSmall: TextStyle(
        fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black12, foregroundColor: Colors.white),
  cardColor: Colors.black45,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      foregroundColor: Colors.grey.shade900,
      splashColor: Colors.black),
  iconTheme: const IconThemeData(color: Colors.white),
  primarySwatch: Colors.grey,
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
