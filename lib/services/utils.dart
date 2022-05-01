import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static String toDateTime(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);
    final time = DateFormat.Hm().format(dateTime);

    return '$date $time';
  }

  static String toDate(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);

    return date;
  }

  static String toTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);

    return time;
  }
}

//snackbar for showing errors
showSnackBar(BuildContext context, String snackText) {
  final snackBar =
      SnackBar(content: Text(snackText), duration: const Duration(seconds: 2));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

verticalSpace(double x) => SizedBox(height: x);

const Color black = Color(0xFF000000);
const Color red = Color(0xFFFF0000);
const Color green = Color(0xFF00FF00);
const Color blue = Color(0xFF0000FF);
const Color violet = Color(0xFF3B053D);
const Color pink = Color(0xFFE40D35);
const Color darkGreen = Color(0xFF185024);
const Color yellow = Color(0xFFC9DB23);
const Color orange = Color(0xFFFF7300);
const Color torquoise = Color(0xFF1BC7D3);

// Make a custom ColorSwatch to name map from the above custom colors.
final Map<ColorSwatch<Object>, String> colorsNameMap =
    <ColorSwatch<Object>, String>{
  ColorTools.createPrimarySwatch(black): 'Black',
  ColorTools.createPrimarySwatch(red): 'Red',
  ColorTools.createAccentSwatch(green): 'Green',
  ColorTools.createAccentSwatch(blue): 'Blue',
  ColorTools.createPrimarySwatch(violet): 'Purple',
  ColorTools.createPrimarySwatch(pink): 'Pink',
  ColorTools.createPrimarySwatch(darkGreen): 'Dark Green',
  ColorTools.createPrimarySwatch(yellow): 'Yellow',
  ColorTools.createPrimarySwatch(orange): 'Orange',
  ColorTools.createPrimarySwatch(torquoise): 'Light blue',
};
