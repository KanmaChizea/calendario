import 'package:flutter/material.dart';
import 'package:project/components/notification_widgets/notif_list.dart';
import 'package:project/state%20management/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:project/components/home%20widgets/drawer.dart';
import 'package:project/components/notification_widgets/notification_option.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Consumer<NotificationProvider>(
              builder: (context, value, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            value: value.priority,
                            onChanged: (bool newValue) {
                              value.setPriority();
                            })
                      ],
                    ),
                    const Text(
                      'Reminder Interval',
                      style: TextStyle(fontSize: 15),
                    ),
                    const NotificationList(),
                    TextButton.icon(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                clipBehavior: Clip.hardEdge,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    NotificationOption(
                                        label: 'No notifications',
                                        value: 'DateTime.now()'),
                                    NotificationOption(
                                        label: '1 day before',
                                        value:
                                            'DateTime.now().subtract(Duration(days: 1))'),
                                    NotificationOption(
                                        label: '3 days before',
                                        value:
                                            'DateTime.now().subtract(Duration(days: 3))'),
                                    NotificationOption(
                                        label: '1 week before',
                                        value:
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
                    Text('OTHERS',
                        style: Theme.of(context).textTheme.titleSmall),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Show notifications',
                          style: TextStyle(fontSize: 15),
                        ),
                        Switch(
                            value: value.others,
                            onChanged: (bool newValue) {
                              value.setOthers();
                            })
                      ],
                    ),
                  ]),
            )));
  }
}
