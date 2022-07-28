import 'package:flutter/material.dart';
import 'package:project/state%20management/add_event_provider.dart';
import 'package:provider/provider.dart';

class EditingActions extends StatelessWidget {
  const EditingActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style:
          ElevatedButton.styleFrom(elevation: 0, primary: Colors.transparent),
      onPressed: () {
        Provider.of<AddEventProvider>(context, listen: false).saveForm(context);
      },
      icon: const Icon(Icons.done),
      label: const Text('SAVE'),
    );
  }
}
