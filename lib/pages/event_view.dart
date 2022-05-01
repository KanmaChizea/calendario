import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:project/model/event_model.dart';
import 'package:project/services/utils.dart';

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
          buildForm('COURSE:', x.course, CupertinoIcons.book_circle, context),
          buildForm('BY:', x.by, CupertinoIcons.calendar_circle, context),
          buildForm('TYPE:', x.type, Icons.assessment_outlined, context),
          buildForm('DESCRIPTION:', x.description, Icons.note_outlined, context)
        ]),
      ),
    );
  }

  buildForm(String s, String t, IconData u, BuildContext context) {
    return ListTile(
      leading: Icon(u, color: Colors.purple.withOpacity(0.4)),
      title: Text(s,
          style:
              Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14)),
      subtitle: Text(t,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }
}
