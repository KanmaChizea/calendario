import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

import '../../services/database.dart';
import '../../services/database.dart';
import '../../services/utils.dart';

class ColourPicker extends StatelessWidget {
  final String data;
  final String eventType;
  const ColourPicker({
    Key? key,
    required this.data,
    required this.eventType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _db = DatabaseService();
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 160),
      alignment: Alignment.center,
      clipBehavior: Clip.hardEdge,
      child: Column(children: [
        const CloseButton(
          color: Colors.white,
        ),
        ColorPicker(
            title: const Center(
                child: Text(
              'Select Colour',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            )),
            subheading: const Center(
                child: Text(
              'Select Colour Shade',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            )),
            color: Color(int.parse(data)),
            customColorSwatchesAndNames: colorsNameMap,
            pickersEnabled: const {
              ColorPickerType.accent: false,
              ColorPickerType.primary: false,
              ColorPickerType.custom: true
            },
            onColorChanged: (color) {
              _db.changeColor(color.toString(), eventType);
            }),
      ]),
    );
  }
}
