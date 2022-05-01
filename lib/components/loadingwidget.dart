import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
          SpinKitCircle(
            color: Theme.of(context).backgroundColor,
            size: 50.0,
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
