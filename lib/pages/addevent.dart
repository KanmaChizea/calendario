import 'package:flutter/material.dart';
import 'package:project/services/database.dart';
import 'package:project/services/utils.dart';

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
  String description = 'null';
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
    return Scaffold(
        appBar: AppBar(
          leading: CloseButton(
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: buildEditingActions(),
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 5.0),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 25.0, left: 12.0, right: 12.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTitle(context),
                  verticalSpace(25.0),
                  buildType(),
                  verticalSpace(25.0),
                  buildBy(),
                  verticalSpace(35.0),
                  buildDescription()
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildBy() => buildHeader(
        header: 'BY',
        child: Row(
          children: [
            verticalSpace(10.0),
            Expanded(
              flex: 2,
              child: buildDropDownField(
                  text: Utils.toDate(byDate),
                  onClicked: () {
                    pickByDateTime(pickDate: true);
                  }),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: buildDropDownField(
                  text: Utils.toTime(byDate),
                  onClicked: () {
                    pickByDateTime(pickDate: false);
                  }),
            )
          ],
        ),
      );

  Column buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeader(header: 'DESCRIPTION', child: verticalSpace(10.0)),
        TextFormField(
          controller: descriptionController,
          maxLines: 8,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 0.5, color: Theme.of(context).primaryColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1.0, color: Theme.of(context).primaryColor))),
        )
      ],
    );
  }

  Row buildType() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      buildHeader(
          header: 'EVENT TYPE:',
          child: const SizedBox(
            width: 20,
          )),
      Container(
        padding: const EdgeInsets.only(left: 25.0),
        width: 250,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Theme.of(context).primaryColor))),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
              hint: Text(
                type,
                style: const TextStyle(color: Colors.black),
              ),
              iconSize: 36,
              icon: Icon(
                Icons.arrow_drop_down,
                color: Theme.of(context).primaryColor.withOpacity(0.8),
              ),
              isExpanded: true,
              items: items.map(buildMenuItem).toList(),
              onChanged: (value) => setState(() => type = value!)),
        ),
      ),
    ]);
  }

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(value: item, child: Text(item));

  TextFormField buildTitle(BuildContext context) {
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
    );
  }

  List<Widget> buildEditingActions() => [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              elevation: 0, primary: Colors.transparent),
          onPressed: () => saveForm(),
          icon: const Icon(Icons.done),
          label: const Text('SAVE'),
        )
      ];

  buildDropDownField({required String text, required VoidCallback onClicked}) =>
      Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 0.5, color: Theme.of(context).primaryColor))),
        child: ListTile(
          title: Text(text),
          trailing: Icon(
            Icons.arrow_drop_down,
            color: Theme.of(context).primaryColor.withOpacity(0.8),
            size: 28.0,
          ),
          onTap: onClicked,
        ),
      );

  buildHeader({required String header, required Widget child}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header, style: const TextStyle(fontWeight: FontWeight.bold)),
          child
        ],
      );

  Future pickByDateTime({required bool pickDate}) async {
    final date = await pickDateTime(byDate, pickDate: pickDate);
    if (date == null) return;

    setState(() => byDate = date);
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: initialDate,
        lastDate: DateTime(2101),
      );

      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));

      if (timeOfDay == null) return null;
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Future saveForm() async {
    if (_formkey.currentState!.validate()) {
      final course = courseController.text.toUpperCase();
      _eventdb.updateEventData(course, byDate, description, type);
      Navigator.of(context).pop();
    }
  }
}
