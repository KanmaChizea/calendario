import 'package:flutter/material.dart';
import 'package:project/components/drawer.dart';

class LoadingPage extends StatelessWidget {
  final bool isLogin;
  const LoadingPage({
    Key? key,
    required this.isLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
          verticalSpace(20),
          isLogin
              ? Container()
              : const Text('Please wait...', style: TextStyle(fontSize: 14))
        ],
      ),
    );
  }
}
