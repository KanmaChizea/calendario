import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String header;
  final Widget child;
  const Header({
    Key? key,
    required this.header,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(header, style: const TextStyle(fontWeight: FontWeight.bold)),
        child
      ],
    );
  }
}
