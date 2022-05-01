import 'package:flutter/material.dart';
import 'package:project/components/drawer.dart';
import 'package:project/model/event_model.dart';
import 'package:project/model/userinfo.dart';
import 'package:project/pages/event_view.dart';
import 'package:project/services/datasource.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:provider/provider.dart';

class Month extends StatelessWidget {
  const Month({Key? key}) : super(key: key);

  void calendartapped(
      CalendarTapDetails calendarTapDetails, BuildContext context) {
    if (calendarTapDetails.targetElement == CalendarElement.agenda ||
        calendarTapDetails.targetElement == CalendarElement.appointment) {
      final MyEvent appointmentDetails = calendarTapDetails.appointments![0];

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OpenCourse(x: appointmentDetails)));
    }
  }

  void assignColor(List<MyEvent> list, UserInformation user) {
    for (MyEvent i in list) {
      if (i.type == 'Test') {
        i.color = Color(int.parse(user.test));
      } else if (i.type == 'Tutorial') {
        i.color = Color(int.parse(user.tutorial));
      } else {
        i.color = Color(int.parse(user.assignment));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<List<MyEvent>>(context);
    final userInfo = Provider.of<UserInformation>(context);
    assignColor(events, userInfo);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      drawer: const CustomDrawer(),
      body: SfCalendar(
          view: CalendarView.month,
          initialDisplayDate: DateTime.now(),
          headerHeight: 60,
          cellBorderColor: Colors.transparent,
          headerStyle: const CalendarHeaderStyle(
              textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          )),
          monthViewSettings: const MonthViewSettings(
            showAgenda: true,
            agendaViewHeight: 220,
            agendaItemHeight: 50,
          ),
          dataSource: MeetingDataSource(events),
          onTap: (details) => calendartapped(details, context)),
    );
  }
}
