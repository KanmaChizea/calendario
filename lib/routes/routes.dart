import 'package:flutter/material.dart';
import 'package:project/pages/addevent.dart';
import 'package:project/pages/appearance.dart';
import 'package:project/pages/editcourses.dart';
import 'package:project/pages/login.dart';
import 'package:project/pages/month.dart';
import 'package:project/pages/notifications.dart';
import 'package:project/pages/priorities.dart';
import 'package:project/pages/schedule.dart';
import 'package:project/pages/settings.dart';
import 'package:project/pages/editprofile.dart';

class AppRoutes {
  static const home = '/';
  static const login = 'login';
  static const schedule = 'schedule';
  static const setting = 'setting';
  static const addevent = 'add_event';
  static const appearance = 'appearance';
  static const editCourses = 'edit_courses';
  static const month = 'month';
  static const notifications = 'notifications';
  static const priorities = 'priorities';
  static const editProfile = 'edit_profile';
  static const daily = 'daily';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings,
        builder: (_) {
          switch (settings.name) {
            case schedule:
              return const Schedule();
            case setting:
              return const Setting();
            case login:
              return const Login();
            case addevent:
              return const AddEvent();
            case appearance:
              return const Appearance();
            case editCourses:
              return const Courses();
            case month:
              return const Month();
            case notifications:
              return const Notifications();
            case priorities:
              return const Prioritee();
            case editProfile:
              return const Editprofile();
            // case daily:
            //   return const DailyView();
          }
          return Container();
          // return const Wrapper();
        });
  }
}
