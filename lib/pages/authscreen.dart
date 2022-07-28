import 'package:flutter/material.dart';
import 'package:project/components/auth_screens/loadingwidget.dart';
import 'package:project/components/auth_screens/signup_form.dart';
import 'package:project/services/utils.dart';
import 'package:project/state%20management/auth_state_management.dart';
import 'package:project/styles/text.dart';
import 'package:provider/provider.dart';

import '../components/auth_screens/login_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthScreenStateManagement>.value(
      value: AuthScreenStateManagement(),
      child: Builder(builder: (context) {
        return Consumer<AuthScreenStateManagement>(
          builder: ((context, value, child) {
            if (value.status == Status.loading) {
              return const LoadingPage(isLogin: true);
            } else {
              return Scaffold(
                  body: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              value.status == Status.register
                                  ? SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                    )
                                  : SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                    ),
                              Text(
                                value.status == Status.register
                                    ? 'Signup.'
                                    : 'Login.',
                                style: authScreenHeader,
                              ),
                              verticalSpace(20),
                              value.status == Status.register
                                  ? const SignUpForm()
                                  : const LoginForm()
                            ],
                          ))));
            }
          }),
        );
      }),
    );
  }
}
