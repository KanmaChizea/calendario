import 'package:flutter/material.dart';
import 'package:project/state%20management/add_event_provider.dart';
import 'package:provider/provider.dart';

class EventFormTitle extends StatefulWidget {
  const EventFormTitle({Key? key}) : super(key: key);

  @override
  State<EventFormTitle> createState() => _EventFormTitleState();
}

class _EventFormTitleState extends State<EventFormTitle> {
  late TextEditingController courseController;

  @override
  void initState() {
    courseController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: 'ADD COURSE TITLE',
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor, width: 0.5)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor, width: 1.0))),
      validator: (course) =>
          course != null && course.isEmpty ? 'Course cannot be empty' : null,
      controller: courseController,
      onChanged: (newValue) =>
          Provider.of<AddEventProvider>(context, listen: false)
              .setCourse(newValue),
    );
  }
}
