import 'package:flutter/material.dart';
import 'package:project/state%20management/notification_provider.dart';
import 'package:provider/provider.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(builder: (context, value, child) {
      if (value.interval.isNotEmpty) {
        return ListView.builder(
            controller: ScrollController(),
            shrinkWrap: true,
            itemCount: value.interval.toSet().toList().length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(value.interval.toSet().toList()[index]),
                  trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => value.removeNotif(index)));
            });
      } else {
        return Container(
          height: 0,
        );
      }
      ;
    });
  }
}
