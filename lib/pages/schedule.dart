import 'package:flutter/material.dart';
import 'package:project/model/userinfo.dart';
import 'package:project/components/home%20widgets/display.dart';
import 'package:project/routes/routes.dart';
import 'package:project/services/database.dart';
import 'package:project/components/home%20widgets/drawer.dart';
import 'package:provider/provider.dart';

import '../model/event_model.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  late EventDatabase _eventDB;

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
          color: Theme.of(context).primaryColor,
          onRefresh: () async {
            StreamProvider<List<MyEvent>>.value(
              value: EventDatabase().courseStream,
              initialData: const [],
            );
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
