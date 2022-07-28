import 'package:flutter/material.dart';
import 'package:project/state%20management/add_event_provider.dart';
import 'package:provider/provider.dart';
import '../../services/utils.dart';
import 'header.dart';

class EventFormDescription extends StatefulWidget {
  const EventFormDescription({Key? key}) : super(key: key);

  @override
  State<EventFormDescription> createState() => _EventFormDescriptionState();
}

class _EventFormDescriptionState extends State<EventFormDescription> {
  late TextEditingController descriptionController;

  @override
  void initState() {
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Header(header: 'DESCRIPTION', child: verticalSpace(10.0)),
        TextFormField(
          controller: descriptionController,
          maxLines: 8,
          onChanged: (newValue) =>
              Provider.of<AddEventProvider>(context, listen: false)
                  .setDescription(newValue),
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
}
