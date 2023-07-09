import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gromart_project/view/config/utils.dart';
import 'package:gromart_project/view/screens/screens.dart';
import 'package:gromart_project/view/widgets/widgets.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    //check whether the email is verified or not
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      //if it is not verified send email verification
      sendVerificationEmail();
      //waits for 3 seconds and check for verification
      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? const HomeScreen()
        : Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff4CAF50),
                  Color(0xffC8E6C9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Scaffold(
              appBar: const CustomAppBarWidget(
                title: 'Verify Email',
                actionList: [],
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'A verification email has been sent\nto your email.',
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
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: canResendEmail
                                    ? const Color(0xff388E3C)
                                    : const Color(0xff388E3C).withOpacity(0.4),
                                minimumSize: const Size.fromHeight(55)),
                            onPressed: () {
                              canResendEmail ? sendVerificationEmail() : null;
                            },
                            child: Text(
                              'Resend Email',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black26,
                                side: const BorderSide(
                                  color: Color(0xff388E3C),
                                  width: 1.5,
                                ),
                                minimumSize: const Size.fromHeight(55)),
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                            },
                            child: Text(
                              'Cancel',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  @override
  void dispose() {
    //if timer is not in use cancel it
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      //set canResendEmail to false and delay 5 seconds to resend verification email by setting it to true.
      Future.delayed(
        const Duration(seconds: 5),
      );
      setState(() => canResendEmail = true);
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  Future checkEmailVerified() async {
    //check status of the user becoz it can be changed after the email verification so reload it
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      //cancel the timer to avoid checking the verification after each 3 seconds
      timer?.cancel();
    }
  }
}
