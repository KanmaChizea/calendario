import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/components/course_widgets/course_list.dart';
import 'package:project/model/userinfo.dart';
import 'package:project/services/database.dart';
import 'package:project/components/home%20widgets/drawer.dart';
import 'package:provider/provider.dart';

import '../components/home widgets/add_course_button.dart';

class Courses extends StatelessWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List courseList = Provider.of<UserInformation>(context).courses ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text('Courses')),
      body: SingleChildScrollView(
        child: Column(children: [
          verticalSpace(10),
          const CourseListView(),
          Center(
            child: AddCourseButton(courseList: courseList),
          ),
        ]),
      ),
    );
  }
}
