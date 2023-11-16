import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/repositories/profile/profile_repository.dart';
import 'package:gromart_project/view/config/config.dart';
import 'package:gromart_project/view/config/utils.dart';
import 'package:gromart_project/view/screens/screens.dart';
import 'package:gromart_project/view/widgets/widgets.dart';

class VerifyEmailPage extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userPassword;
  const VerifyEmailPage({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
  });

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
        ? const GetStartedPage()
        : Scaffold(
            backgroundColor: kSecondaryColor,
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
                                  ? kPrimaryColor
                                  : kPrimaryColor.withOpacity(0.4),
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
                                color: kPrimaryColor,
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
      Utils.showSnackBar(e.toString(), Colors.redAccent);
    }
  }

  Future checkEmailVerified() async {
    //check status of the user becoz it can be changed after the email verification so reload it
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: widget.userEmail,
        password: widget.userPassword,
      );
      final profile = FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userEmail)
          .collection('profile')
          .doc();
      ProfileModel userProfile = ProfileModel(
        id: profile.id,
        userName: widget.userName,
        userEmail: widget.userEmail,
        userPhone: '',
        userGender: '',
        userDob: '',
        userImageUrl: '',
      );
      await ProfileRepository()
          .updateProfileData(widget.userEmail, profile.id, userProfile);
      //cancel the timer to avoid checking the verification after each 3 seconds
      timer?.cancel();
    }
  }
}
