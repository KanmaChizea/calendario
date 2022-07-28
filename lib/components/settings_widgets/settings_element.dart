import 'package:flutter/material.dart';

class SettingsElement extends StatelessWidget {
  final String title;
  final String appRoutes;
  const SettingsElement({
    Key? key,
    required this.title,
    required this.appRoutes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pushNamed(context, appRoutes);
      },
    );
  }
}
