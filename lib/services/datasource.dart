import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/model/event_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<MyEvent> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return DateFormat.yMMMd().add_jm().parse(appointments![index].by);
  }

  @override
  String getSubject(int index) {
    return appointments![index].course;
  }

  String getType(int index) {
    return appointments![index].type;
  }

  @override
  String getNotes(int index) {
    return appointments![index].description;
  }

  @override
  Color getColor(int index) {
    return appointments![index].color;
  }
}
