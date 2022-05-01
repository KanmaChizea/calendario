import 'package:flutter/material.dart';
import 'package:project/components/drawer.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

String radiovalue = 'DateTime.now()';
List interval = [];
bool priority = true;
bool others = false;

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('PRIORITY NOTIFICATION',
                  style: Theme.of(context).textTheme.titleSmall),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Show notifications',
                    style: TextStyle(fontSize: 15),
                  ),
                  Switch(
                      value: priority,
                      onChanged: (bool newValue) {
                        setState(() {
                          priority = !priority;
                        });
                      }),
                ],
              ),
              const Text(
                'Reminder Interval',
                style: TextStyle(fontSize: 15),
              ),
              buildNotification(),
              TextButton.icon(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          clipBehavior: Clip.hardEdge,
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildRadio('No notifications', 'DateTime.now()'),
                              buildRadio('1 day before',
                                  'DateTime.now().subtract(Duration(days: 1))'),
                              buildRadio('3 days before',
                                  'DateTime.now().subtract(Duration(days: 3))'),
                              buildRadio('1 week before',
                                  'DateTime.now().subtract(Duration(days: 7))')
                            ],
                          ),
                        );
                      });
                },
                icon: const Icon(Icons.add),
                label: const Text('Add notification'),
              ),
              const Divider(),
              verticalSpace(10),
              Text('OTHERS', style: Theme.of(context).textTheme.titleSmall),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Show notifications',
                    style: TextStyle(fontSize: 15),
                  ),
                  Switch(
                      value: others,
                      onChanged: (bool newValue) {
                        setState(() {
                          others = !others;
                        });
                      }),
                ],
              ),
            ])));
  }

  buildRadio(String t, String s) {
    return Row(
      children: [
        Radio(
            value: s,
            groupValue: radiovalue,
            onChanged: (value) {
              t == 'No notifications' ? null : interval.add(t);
              setState(() {
                radiovalue = value as String;
              });
              Navigator.pop(context);
            }),
        Text(
          t,
          style: const TextStyle(fontSize: 16),
        )
      ],
    );
  }

  buildNotification() {
    if (interval.isNotEmpty) {
      return ListView.builder(
          controller: ScrollController(),
          shrinkWrap: true,
          itemCount: interval.toSet().toList().length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(interval.toSet().toList()[index]),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => setState(
                    (() => interval.remove(interval.toSet().toList()[index]))),
              ),
            );
          });
    } else {
      return Container(
        height: 0,
      );
    }
  }
}
