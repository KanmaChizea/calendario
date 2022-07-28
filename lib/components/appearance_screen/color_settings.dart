import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/userinfo.dart';
import 'color_picker.dart';

class ColorSetting extends StatelessWidget {
  const ColorSetting({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 7),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16.5),
        ),
        Consumer<UserInformation>(builder: (_, value, __) {
          String data = (title == 'Test')
              ? value.test
              : (title == 'Tutorial')
                  ? value.tutorial
                  : value.assignment;
          return GestureDetector(
            onTap: () => showDialog(
                context: context,
                builder: (context) =>
                    ColourPicker(data: data, eventType: title)),
            child: Stack(children: [
              Container(
                  padding: const EdgeInsets.all(12),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).textTheme.headline1?.color)),
              Positioned(
                left: 2.5,
                top: 2.5,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(int.parse(data))),
                ),
              ),
            ]),
          );
        })
      ]),
    );
  }
}
