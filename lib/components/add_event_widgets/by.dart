import 'package:flutter/material.dart';
import 'package:project/state%20management/add_event_provider.dart';
import 'package:provider/provider.dart';

import 'package:project/components/add_event_widgets/header.dart';

import '../../services/utils.dart';

class EventFormBy extends StatelessWidget {
  const EventFormBy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Header(
        header: 'BY',
        child: Consumer<AddEventProvider>(
          builder: (context, value, child) => Row(
            children: [
              verticalSpace(10.0),
              Expanded(
                flex: 2,
                child: ByDropDown(
                    text: Utils.toDate(value.byDate),
                    onclicked: () {
                      value.pickByDateTime(context, pickDate: true);
                    }),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: ByDropDown(
                    text: Utils.toTime(value.byDate),
                    onclicked: () {
                      value.pickByDateTime(context, pickDate: false);
                    }),
              )
            ],
          ),
        ));
  }
}

class ByDropDown extends StatelessWidget {
  final String text;
  final VoidCallback onclicked;
  const ByDropDown({
    Key? key,
    required this.text,
    required this.onclicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        onTap: onclicked,
      ),
    );
  }
}
