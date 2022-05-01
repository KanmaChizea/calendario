import 'package:flutter/material.dart';
import 'package:project/pages/login.dart';
import 'package:project/pages/schedule.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user == null) {
      return const Login();
    } else {
      return const Schedule();
    }
  }
}
