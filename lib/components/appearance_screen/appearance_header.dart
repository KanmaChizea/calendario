import 'package:flutter/material.dart';

class AppearanceHeader extends StatelessWidget {
  final String title;
  const AppearanceHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}
