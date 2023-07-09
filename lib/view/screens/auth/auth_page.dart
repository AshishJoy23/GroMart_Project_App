import 'package:flutter/material.dart';
import 'package:gromart_project/view/screens/screens.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return isLogin
    ? SignInWidget(onClickedSignUp: toggle)
    : SignUpWidget(onClickedSignIn: toggle);
  }

  void toggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }
}