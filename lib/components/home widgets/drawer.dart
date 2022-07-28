import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/routes/routes.dart';
import 'package:project/services/auth.dart';

final AuthService _auth = AuthService();

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      shrinkWrap: true,
      children: [
        StreamBuilder<User?>(
            stream: _auth.user,
            builder: ((context, snapshot) {
              final user = snapshot.data;
              return DrawerHeader(
                decoration: const BoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                          color: Colors.transparent, shape: BoxShape.circle),
                      child: ClipOval(
                        child: CachedNetworkImage(
                            placeholder: (context, url) => const Text('avatar'),
                            imageUrl: user?.photoURL ?? '',
                            fit: BoxFit.contain),
                      ),
                    ),
                    verticalSpace(10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          user?.displayName ?? '',
                          style: const TextStyle(fontSize: 18),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.editProfile);
                            },
                            child: const Text(
                              'Edit profile',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                side: BorderSide(
                                    width: 1.0,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5))))
                      ],
                    ),
                  ],
                ),
              );
            })),
        const Divider(thickness: 1.0),
        drawerElement(context, Icons.calendar_today_outlined, 'Schedule',
            AppRoutes.schedule),
        drawerElement(
            context, Icons.calendar_view_month, 'Month', AppRoutes.month),
        const Divider(
          thickness: 1.0,
        ),
        drawerElement(context, Icons.settings, 'Settings', AppRoutes.setting),
        drawerElement(context, Icons.power_settings_new, 'Log Out', ''),
        const Divider(
          thickness: 1.0,
        ),
      ],
    ));
  }

  ListTile drawerElement(
      BuildContext context, IconData icon, String title, String link) {
    return ListTile(
        leading: Icon(icon),
        minLeadingWidth: 10,
        title: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        onTap: link.isEmpty
            ? () async {
                await _auth.signout(context);
              }
            : () {
                Navigator.pushNamed(context, link);
              });
  }
}

verticalSpace(double x) => SizedBox(height: x);
