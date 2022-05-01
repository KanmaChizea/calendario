import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:project/model/userinfo.dart';
import 'package:project/services/database.dart';
import 'package:project/services/utils.dart';
import 'package:project/themes/theme_controller.dart';
import 'package:provider/provider.dart';

late String updater;

class Appearance extends StatefulWidget {
  const Appearance({Key? key}) : super(key: key);

  @override
  State<Appearance> createState() => _AppearanceState();
}

class _AppearanceState extends State<Appearance> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    var groupValue = theme.currentTheme;

    return Scaffold(
        appBar: AppBar(title: const Text('Appearance')),
        body: Container(
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader('EVENT COLORS'),
                buildColorSetting('Test', context),
                buildColorSetting('Assignment', context),
                buildColorSetting('Tutorial', context),
                buildHeader('THEME'),
                RadioListTile(
                  value: ThemeMode.light,
                  groupValue: groupValue,
                  onChanged: (_) {
                    theme.toggleTheme(true);
                  },
                  title: const Text('Light mode'),
                ),
                RadioListTile(
                  value: ThemeMode.dark,
                  groupValue: groupValue,
                  onChanged: (_) {
                    theme.toggleTheme(false);
                  },
                  title: const Text('Dark mode'),
                ),
                RadioListTile(
                  value: 'system',
                  groupValue: groupValue,
                  onChanged: (_) {
                    theme.useSystemTheme();
                  },
                  title: const Text('Use system default'),
                )
              ],
            )));
  }

  Container buildColorSetting(String title, BuildContext context) {
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
            onTap: () => showColorPicker(context, data, title),
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

  buildHeader(String s) {
    return Text(
      s,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }

  showColorPicker(BuildContext context, String data, String key) {
    final _db = DatabaseService();
    return showDialog(
      context: context,
      builder: (context) => Dialog(
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
                _db.changeColor(color.toString(), key);
              }),
        ]),
      ),
    );
  }
}
