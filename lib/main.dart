// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_im
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/model/event_model.dart';
import 'package:project/model/userinfo.dart';
import 'package:project/routes/routes.dart';
import 'package:project/services/wrapper.dart';
import 'package:project/services/auth.dart';
import 'package:project/services/database.dart';
import 'package:project/themes/theme_controller.dart';
import 'package:project/themes/themes_constant.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Homepage());
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) => MultiProvider(
          providers: [
            StreamProvider<User?>.value(
              value: AuthService().user,
              initialData: null,
            ),
            StreamProvider<UserInformation>.value(
              value: EventDatabase().userDataStream,
              initialData: UserInformation(
                  assignment: '',
                  test: '',
                  tutorial: '',
                  role: '',
                  courses: []),
            ),
            StreamProvider<List<MyEvent>>.value(
              value: EventDatabase().courseStream,
              initialData: const [],
            ),
            ChangeNotifierProvider<ThemeNotifier>(
                create: (context) => ThemeNotifier()),
          ],
          builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: Provider.of<ThemeNotifier>(context).currentTheme,
              onGenerateRoute: AppRoutes.onGenerateRoute,
              home: Wrapper()));
}
