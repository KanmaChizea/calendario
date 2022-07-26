import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';
import '../services/utils.dart';
import '../state management/auth_state_management.dart';
import '../styles/buttons.dart';
import 'inputfield_decor.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextFormField(
              validator: (value) => value == null || value.isEmpty
                  ? 'Field cannot be empty'
                  : null,
              controller: emailController,
              decoration:
                  buildDecoration(Icons.email_outlined, 'EMAIL:', context)),
          verticalSpace(15.0),
          TextFormField(
            validator: (value) =>
                value == null || value.isEmpty ? 'Field cannot be empty' : null,
            controller: passwordController,
            decoration:
                buildDecoration(Icons.lock_outlined, 'PASSWORD:', context),
            obscureText: true,
          ),
          Consumer<AuthScreenStateManagement>(builder: (context, value, child) {
            return value.error == ''
                ? verticalSpace(40)
                : Container(
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: Center(
                      child: Text(value.error,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 173, 20, 9),
                            fontSize: 12.0,
                          )),
                    ),
                  );
          }),
          Consumer<AuthScreenStateManagement>(builder: (context, value, child) {
            return ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  value.setStatus(Status.loading);

                  dynamic result = await authService.signIn(
                      emailController.text, passwordController.text, context);
                  if (result is String) {
                    value.setError(result);
                    value.setStatus(Status.login);
                  }
                }
              },
              child: const Text(
                'SIGN IN',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),
          verticalSpace(10),
          TextButton(
              onPressed: () {},
              style: textButtonStyle,
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.black87,
                ),
              )),
          Consumer<AuthScreenStateManagement>(builder: (context, value, child) {
            return TextButton(
                onPressed: () {
                  value.resetError();
                  value.setStatus(Status.register);
                },
                child: const Text(
                  "Don't have an account? Register",
                ));
          }),
          verticalSpace(10),
        ],
      ),
    );
  }
}
