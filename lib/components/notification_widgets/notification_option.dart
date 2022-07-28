import 'package:flutter/material.dart';
import 'package:project/state%20management/notification_provider.dart';
import 'package:provider/provider.dart';

class NotificationOption extends StatelessWidget {
  final String value;
  final String label;
  const NotificationOption({
    Key? key,
    required this.value,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<NotificationProvider>(
          builder: (context, provider, child) => Radio(
              value: value,
              groupValue: provider.radiovalue,
              onChanged: (value) {
                label == 'No notifications'
                    ? null
                    : provider.interval.add(label);
                provider.setRadioValue(value as String);
                Navigator.pop(context);
              }),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
