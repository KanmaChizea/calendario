import 'package:flutter/material.dart';
import 'package:project/routes/routes.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
          child: ListView(padding: EdgeInsets.zero, children: [
            settingsElements(context, 'Appearance', AppRoutes.appearance),
            const Divider(
              height: 5.0,
            ),
            settingsElements(
                context, 'Edit Course List', AppRoutes.editCourses),
            const Divider(
              height: 5.0,
            ),
            settingsElements(context, 'Set Priorities', AppRoutes.priorities),
            const Divider(
              height: 5.0,
            ),
            settingsElements(context, 'Notifications', AppRoutes.notifications),
            const Divider(
              height: 5.0,
            ),
          ]),
        ));
  }

  ListTile settingsElements(
      BuildContext context, String title, String appRoutes) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pushNamed(context, appRoutes);
      },
    );
  }
}
