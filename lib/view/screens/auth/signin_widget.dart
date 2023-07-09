import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gromart_project/view/config/config.dart';
import 'package:gromart_project/view/screens/screens.dart';

class SignInWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const SignInWidget({
    super.key,
    required this.onClickedSignUp,
  });

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthTextFormFieldWidget(
                controller: emailController,
                hintText: 'Enter Email..',
                labelText: 'Email',
                iconData: Icons.email,
                validator: (email) {
                  return email != '' ? null : 'Email required!!';
                },
              ),
              AuthTextFormFieldWidget(
                controller: passwordController,
                hintText: 'Enter Password..',
                labelText: 'Password',
                iconData: Icons.lock,
                obscureText: true,
                validator: (password) {
                  return password != '' ? null : 'Password required!!';
                },
              ),
              const ForgotPasswordWidget(),
              AuthButtonWidget(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  await signIn(
                      context, formKey, emailController, passwordController);
                },
                buttonText: 'Sign In',
              ),
              SwitchUserAccountWidget(
                onClickedSignUp: widget.onClickedSignUp,
                text: 'Don\'t have an account?  ',
                buttonText: 'Sign Up',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

