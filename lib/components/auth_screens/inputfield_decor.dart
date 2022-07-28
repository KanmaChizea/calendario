import 'package:flutter/material.dart';

buildDecoration(IconData icon, String hintText, BuildContext context) {
  return InputDecoration(
    prefixIcon: Icon(
      icon,
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1.0,
          style: BorderStyle.solid),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
    ),
    contentPadding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
    hintText: hintText,
  );
}
