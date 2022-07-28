import 'package:flutter/material.dart';
import 'package:project/state%20management/add_event_provider.dart';
import 'package:provider/provider.dart';
import 'package:project/components/add_event_widgets/by.dart';
import 'package:project/components/add_event_widgets/description.dart';
import 'package:project/components/add_event_widgets/type.dart';
import 'package:project/services/database.dart';
import 'package:project/services/utils.dart';

import '../components/add_event_widgets/editing_actions.dart';
import '../components/add_event_widgets/title.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({
    Key? key,
  }) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formkey = GlobalKey<FormState>();

  DateTime byDate = DateTime.now();
  final items = ['Assignment', 'Test', 'Tutorial'];

  String? value;
  String type = 'Type';
  late EventDatabase _eventdb;
  late TextEditingController courseController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    courseController = TextEditingController();
    descriptionController = TextEditingController();
    _eventdb = EventDatabase();
    super.initState();
  }

  @override
  void dispose() {
    courseController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddEventProvider(_formkey),
      child: Scaffold(
          appBar: AppBar(
            leading: CloseButton(
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: const [EditingActions()],
          ),
          body: Container(
            margin: const EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 5.0),
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(top: 25.0, left: 12.0, right: 12.0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const EventFormTitle(),
                    verticalSpace(25.0),
                    const EventFormType(),
                    verticalSpace(25.0),
                    const EventFormBy(),
                    verticalSpace(35.0),
                    const EventFormDescription()
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
