import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:project/model/event_model.dart';
import 'package:project/services/utils.dart';

import '../components/home widgets/event_view_form.dart';

class OpenCourse extends StatelessWidget {
  final MyEvent x;
  const OpenCourse({
    Key? key,
    required this.x,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CloseButton(),
          verticalSpace(10),
          EventViewForm(
              title: 'COURSE:',
              subtitle: x.course,
              icon: CupertinoIcons.book_circle),
          EventViewForm(
              title: 'BY:',
              subtitle: x.by,
              icon: CupertinoIcons.calendar_circle),
          EventViewForm(
              title: 'TYPE:',
              subtitle: x.type,
              icon: Icons.assessment_outlined),
          EventViewForm(
              title: 'DESCRIPTION:',
              subtitle: x.description,
              icon: Icons.note_outlined)
        ]),
      ),
    );
  }
}
