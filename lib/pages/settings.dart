import 'package:flutter/material.dart';

import 'package:project/routes/routes.dart';

import '../components/settings_widgets/settings_element.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
          child: ListView(padding: EdgeInsets.zero, children: const [
            SettingsElement(
                title: 'Appearance', appRoutes: AppRoutes.appearance),
            Divider(
              height: 5.0,
            ),
            SettingsElement(
                title: 'Edit Course List', appRoutes: AppRoutes.editCourses),
            Divider(
              height: 5.0,
            ),
            SettingsElement(
                title: 'Set Priorities', appRoutes: AppRoutes.priorities),
            Divider(
              height: 5.0,
            ),
            SettingsElement(
                title: 'Notifications', appRoutes: AppRoutes.notifications),
            Divider(
              height: 5.0,
            ),
          ]),
        ));
  }
}
