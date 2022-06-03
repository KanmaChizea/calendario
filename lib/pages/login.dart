import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:project/components/loadingwidget.dart';
import 'package:project/services/auth.dart';
import 'package:project/services/utils.dart';

bool isSignupScreen = false;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormBuilderState>();
  bool loading = false;

  String error = '';
  String? password;

  late Animation animation;
  late AnimationController animationController;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween(begin: -0.5, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return loading
        ? const LoadingPage(
            isLogin: true,
          )
        : AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Scaffold(
                  body: Transform(
                transform:
                    Matrix4.translationValues(animation.value * width, 0, 0),
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isSignupScreen
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                              )
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                              ),
                        isSignupScreen
                            ? headerText('Signup')
                            : headerText('Login'),
                        verticalSpace(20),
                        isSignupScreen ? signupForm() : loginForm()
                      ],
                    ),
                  ),
                ),
              ));
            });
  }

// Log in form
  FormBuilder loginForm() {
    return FormBuilder(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FormBuilderTextField(
              validator: (value) =>
                  value == null ? 'Field cannot be empty' : null,
              name: 'email',
              decoration: buildDecoration(Icons.email_outlined, 'EMAIL:')),
          verticalSpace(15.0),
          FormBuilderTextField(
            validator: (value) =>
                value == null ? 'Field cannot be empty' : null,
            name: 'password',
            decoration: buildDecoration(Icons.lock_outlined, 'PASSWORD:'),
            obscureText: true,
          ),
          error.isEmpty
              ? verticalSpace(40)
              : Container(
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: Center(
                    child: Text(error,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 173, 20, 9),
                          fontSize: 12.0,
                        )),
                  ),
                ),
          ElevatedButton(
            onPressed: () async {
              _formKey.currentState!.save();
              if (_formKey.currentState!.validate()) {
                setState(() {
                  loading = true;
                });
                final data = _formKey.currentState!.value;
                dynamic result = await _auth.signIn(
                    data['email'], data['password'], context);
                if (result is String) {
                  setState(() {
                    error = result;
                    loading = false;
                  });
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
          ),
          verticalSpace(10),
          TextButton(
              onPressed: () {},
              style: textButtonStyle(),
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.black87,
                ),
              )),
          TextButton(
              onPressed: () {
                setState(() {
                  error = '';
                  isSignupScreen = !isSignupScreen;
                });
              },
              child: const Text(
                "Don't have an account? Register",
              )),
          verticalSpace(10),
        ],
      ),
    );
  }

  //Sign up form

  signupForm() {
    return FormBuilder(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              verticalSpace(30.0),
              FormBuilderTextField(
                  validator: (value) =>
                      value == null ? 'Field cannot be empty' : null,
                  name: 'username',
                  decoration:
                      buildDecoration(Icons.person_outlined, 'FULL NAME:')),
              verticalSpace(10.0),
              FormBuilderTextField(
                  validator: (value) =>
                      value == null ? 'Field cannot be empty' : null,
                  name: 'email',
                  keyboardType: TextInputType.emailAddress,
                  decoration: buildDecoration(Icons.email_outlined, 'EMAIL:')),
              verticalSpace(10.0),
              FormBuilderTextField(
                  validator: (value) =>
                      value == null ? 'Field cannot be empty' : null,
                  name: 'password',
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  decoration:
                      buildDecoration(Icons.lock_outlined, 'PASSWORD:')),
              verticalSpace(10.0),
              FormBuilderTextField(
                  validator: (value) {
                    value == null ? 'Field cannot be empty' : null;
                    value != password ? "Passwords don't match" : null;
                    return null;
                  },
                  name: 'confirm',
                  obscureText: true,
                  decoration: buildDecoration(
                      Icons.lock_outlined, 'CONFIRM PASSWORD:')),
              error.isEmpty
                  ? verticalSpace(30)
                  : Container(
                      height: 30,
                      alignment: Alignment.centerLeft,
                      child: Text(error,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 173, 20, 9),
                            fontSize: 12.0,
                          )),
                    ),
              ElevatedButton(
                onPressed: () async {
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    final data = _formKey.currentState!.value;
                    dynamic result = await _auth.register(data['email'],
                        data['password'], data['username'], context);
                    if (result is String) {
                      setState(() {
                        error = result;
                        loading = false;
                      });
                    }
                  }
                },
                child: const Text(
                  'CREATE ACCOUNT',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              verticalSpace(10),
              TextButton(
                onPressed: () {
                  setState(() {
                    error = '';
                    isSignupScreen = !isSignupScreen;
                  });
                },
                child: const Text(
                  'Already have an account? Sign in',
                ),
              ),
            ]));
  }

// format header text
  RichText headerText(String title) {
    return RichText(
        text: TextSpan(
            text: title,
            style: const TextStyle(
              fontSize: 78,
              fontWeight: FontWeight.bold,
            ),
            children: [
          TextSpan(
              text: '.',
              style: TextStyle(
                  fontSize: 78,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor))
        ]));
  }

// text field decoration
  buildDecoration(IconData icon, String hintText) {
    return InputDecoration(
      prefixIcon: Icon(
        icon,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.0,
            style: BorderStyle.solid),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
      ),
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
      hintText: hintText,
    );
  }

// style for text button
  textButtonStyle() {
    return TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
