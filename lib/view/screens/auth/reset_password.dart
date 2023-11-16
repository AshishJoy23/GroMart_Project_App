import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gromart_project/view/config/config.dart';
import 'package:gromart_project/view/config/utils.dart';
import 'package:gromart_project/view/widgets/widgets.dart';

import '../../../main.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  static const String routeName = '/forgot';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ResetPasswordPage(),
    );
  }

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: const CustomAppBarWidget(
        title: 'Reset Password',
        actionList: [],
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Receive an email to reset\nyour password.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  hintText: 'Enter Email..',
                  labelText: 'Email',
                  floatingLabelStyle: TextStyle(
                    color: kPrimaryColor,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                  prefixIconColor: Colors.black54,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) {
                  return email != '' ? null : 'Email required!!';
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          minimumSize: const Size.fromHeight(55)),
                      onPressed: () async {
                        //log('choose from camera');
                        FocusManager.instance.primaryFocus?.unfocus();
                        resetPassword();
                        //await signIn(context);
                      },
                      child: Text(
                        'Reset Password',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> resetPassword() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
            backgroundColor: Colors.white,
            color: Colors.black,
          ),
        );
      },
    );
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      Utils.showSnackBar('Password Reset Email Sent', Colors.greenAccent);
      navigatorKey.currentState!.pushNamed('/getStarted');
    } on FirebaseAuthException catch (e) {
      log(e.message!);
      Utils.showSnackBar(e.message!, Colors.red);
      Navigator.of(context).pop();
    }
  }
}
