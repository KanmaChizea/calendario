import 'package:flutter/material.dart';

class EventViewForm extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const EventViewForm({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title,
          style:
              Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14)),
      subtitle: Text(subtitle,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }
}
