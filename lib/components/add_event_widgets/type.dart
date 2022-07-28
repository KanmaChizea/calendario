import 'package:flutter/material.dart';
import 'package:project/state%20management/add_event_provider.dart';
import 'package:provider/provider.dart';

import 'header.dart';

class EventFormType extends StatelessWidget {
  const EventFormType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = ['Assignment', 'Test', 'Tutorial'];
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      const Header(header: 'EVENT TYPE:', child: SizedBox(width: 20)),
      Container(
        padding: const EdgeInsets.only(left: 25.0),
        width: 250,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Theme.of(context).primaryColor))),
        child: DropdownButtonHideUnderline(
          child: Consumer<AddEventProvider>(
              builder: (context, value, child) => DropdownButton<String>(
                  hint: Text(
                    value.type,
                    style: const TextStyle(color: Colors.black),
                  ),
                  iconSize: 36,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                  ),
                  isExpanded: true,
                  items: items
                      .map((item) =>
                          DropdownMenuItem(value: item, child: Text(item)))
                      .toList(),
                  onChanged: (newValue) => value.setType(newValue!))),
        ),
      ),
    ]);
  }
}
