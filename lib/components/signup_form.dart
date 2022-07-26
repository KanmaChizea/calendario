import 'package:flutter/material.dart';
import 'package:project/services/auth.dart';
import 'package:project/state%20management/auth_state_management.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';
import 'inputfield_decor.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController password2Controller;

  @override
  void initState() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    password2Controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    password2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              verticalSpace(30.0),
              TextFormField(
                  validator: (value) => value == null || value.isEmpty
                      ? 'Field cannot be empty'
                      : null,
                  controller: nameController,
                  decoration: buildDecoration(
                      Icons.person_outlined, 'FULL NAME:', context)),
              verticalSpace(10.0),
              TextFormField(
                  validator: (value) => value == null || value.isEmpty
                      ? 'Field cannot be empty'
                      : null,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      buildDecoration(Icons.email_outlined, 'EMAIL:', context)),
              verticalSpace(10.0),
              TextFormField(
                  validator: (value) => value == null || value.isEmpty
                      ? 'Field cannot be empty'
                      : null,
                  controller: passwordController,
                  obscureText: true,
                  decoration: buildDecoration(
                      Icons.lock_outlined, 'PASSWORD:', context)),
              verticalSpace(10.0),
              TextFormField(
                  validator: (value) {
                    value == null || value.isEmpty
                        ? 'Field cannot be empty'
                        : null;
                    value != passwordController.text
                        ? "Passwords don't match"
                        : null;
                    return null;
                  },
                  controller: password2Controller,
                  obscureText: true,
                  decoration: buildDecoration(
                      Icons.lock_outlined, 'CONFIRM PASSWORD:', context)),
              Consumer<AuthScreenStateManagement>(
                  builder: (context, value, child) {
                return value.error == ''
                    ? verticalSpace(30)
                    : Container(
                        height: 30,
                        alignment: Alignment.centerLeft,
                        child: Text(value.error,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 173, 20, 9),
                              fontSize: 12.0,
                            )),
                      );
              }),
              Consumer<AuthScreenStateManagement>(
                builder: ((context, value, child) => ElevatedButton(
                    onPressed: () async {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        value.setStatus(Status.loading);
                        dynamic result = await authService.register(
                            emailController.text,
                            passwordController.text,
                            nameController.text,
                            context);
                        if (result is String) {
                          value.setStatus(Status.register);
                          value.setError(result);
                        }
                      }
                    },
                    child: const Text(
                      'CREATE ACCOUNT',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ))),
              ),
              verticalSpace(10),
              Consumer<AuthScreenStateManagement>(
                builder: (context, value, child) => TextButton(
                  onPressed: () {
                    value.resetError();
                    value.setStatus(Status.login);
                  },
                  child: const Text(
                    'Already have an account? Sign in',
                  ),
                ),
              ),
            ]));
  }
}
