import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:project/themes/theme_controller.dart';

import '../components/appearance_screen/appearance_header.dart';
import '../components/appearance_screen/color_settings.dart';

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
                const AppearanceHeader(title: 'EVENT COLORS'),
                const ColorSetting(title: 'Test'),
                const ColorSetting(title: 'Assignment'),
                const ColorSetting(title: 'Tutorial'),
                const AppearanceHeader(title: 'THEME'),
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
}
