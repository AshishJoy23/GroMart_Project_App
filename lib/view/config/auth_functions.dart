import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gromart_project/view/config/config.dart';
import 'package:gromart_project/view/screens/auth/get_started.dart';
import 'package:gromart_project/view/screens/auth/verify_email.dart';

import '../../main.dart';

// final formKey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
Future signIn(context, formKey, emailController, passwordController) async {
  final isValid = formKey.currentState!.validate();
  log(isValid.toString());
  log('signing in/////////////?????');
  if (!isValid) {
    return;
  }
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Color(0xff388E3C),
        ),
      );
    },
  );
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    navigatorKey.currentState!.pushNamed('/getStarted');
  } on FirebaseAuthException catch (e) {
    log(e.message.toString());
    if (e.code == 'user-not-found') {
      Utils.showSnackBar('No user found for that email.', Colors.redAccent);
      emailController.clear();
      passwordController.clear();
      log('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      Utils.showSnackBar('Wrong password', Colors.redAccent);
      passwordController.clear();
      log('Wrong password provided for that user.');
    }

    Navigator.of(context).pop();
    return;
  }
}

Future signUp(
    BuildContext context,
    formKey,
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmController) async {
  final isValid = formKey.currentState!.validate();
  if (!isValid) {
    return;
  }

  try {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Color(0xff388E3C),
          ),
        );
      },
    );
    navigatorKey.currentState!.push(
      MaterialPageRoute(
        builder: (context) => VerifyEmailPage(
          userName: nameController.text.trim(),
          userEmail: emailController.text.trim(),
          userPassword: passwordController.text.trim(),
        ),
      ),
    );
  } on FirebaseAuthException catch (e) {
    log(e.message.toString());
    if (e.code == 'email-already-in-use') {
      Utils.showSnackBar(
          'The account already exists for that email.', Colors.redAccent);
      emailController.clear();
      log('The account already exists for that email.');
    } else {
      Utils.showSnackBar(e.message, Colors.redAccent);
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmController.clear();
    }
    Navigator.of(context).pop();
    return;
  }
}
