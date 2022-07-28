import 'package:flutter/material.dart';

import 'package:project/services/database.dart';

class AddEventProvider extends ChangeNotifier {
  final GlobalKey<FormState> formkey;
  AddEventProvider(this.formkey);
  String type = 'Type';
  String course = '';
  String description = '';
  DateTime byDate = DateTime.now();

  void setType(String word) {
    type = word;
    notifyListeners();
  }

  void setCourse(String word) {
    course = word;
    notifyListeners();
  }

  void setDescription(String word) {
    description = word;
    notifyListeners();
  }

  void reset() {
    type = '';
    course = '';
    description = '';
    notifyListeners();
  }

  Future pickByDateTime(BuildContext context, {required bool pickDate}) async {
    final date = await pickDateTime(pickDate: pickDate, context: context);
    if (date == null) return;

    byDate = date;
    notifyListeners();
  }

  Future<DateTime?> pickDateTime(
      {required bool pickDate,
      DateTime? firstDate,
      required BuildContext context}) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: byDate,
        firstDate: byDate,
        lastDate: DateTime(2101),
      );

      if (date == null) return null;

      final time = Duration(hours: byDate.hour, minutes: byDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(byDate));

      if (timeOfDay == null) return null;
      final date = DateTime(byDate.year, byDate.month, byDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Future saveForm(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      final course = this.course.toUpperCase();
      final description = this.description.isEmpty ? 'null' : this.description;
      EventDatabase().updateEventData(course, byDate, description, type);
      Navigator.of(context).pop();
    }
  }
}
