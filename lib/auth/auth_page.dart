


import 'package:flutter/material.dart';
import 'package:flutter_todo_app/Login/login.dart';
import 'package:flutter_todo_app/Login/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
//intially,show the login page
  bool showLoginPage = true;

  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return Login(
      //  showRegisterPage: toggleScreen,
      );
    } else {
      return Signup(
      //  showLoginPage: toggleScreen,
      );
    }
  }
}
