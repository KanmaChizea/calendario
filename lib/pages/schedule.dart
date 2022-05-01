import 'package:flutter/material.dart';
import 'package:project/model/userinfo.dart';
import 'package:project/components/display.dart';
import 'package:project/routes/routes.dart';
import 'package:project/services/database.dart';
import 'package:project/components/drawer.dart';
import 'package:provider/provider.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

IconData theme = Icons.bedtime;

class _ScheduleState extends State<Schedule> {
  late EventDatabase _eventDB;
  String profilepic = '';

  @override
  void initState() {
    _eventDB = EventDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserInformation?>(context);
    _eventDB.deleteExpiredEvents();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),
      floatingActionButton:
          user!.role == 'admin' ? _floatingActionButton() : null,
      drawer: const CustomDrawer(),
      body: RefreshIndicator(
          color: Colors.purpleAccent,
          onRefresh: () async {
            setState(() {});
          },
          child: const DisplaySchedule()),
    );
  }

  _floatingActionButton() => FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.addevent),
        child: const Icon(
          Icons.add,
        ),
      );
}
