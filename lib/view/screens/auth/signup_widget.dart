import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:gromart_project/view/screens/screens.dart';
import '../../config/config.dart';

class SignUpWidget extends StatefulWidget {
  final VoidCallback onClickedSignIn;

  const SignUpWidget({
    super.key,
    required this.onClickedSignIn,
  });

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
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
                controller: nameController,
                hintText: 'Enter Full Name..',
                labelText: 'Full Name',
                iconData: Icons.person,
                validator: (name) =>
                    name != '' ? null : 'Name is required!!',
              ),
              AuthTextFormFieldWidget(
                controller: emailController,
                hintText: 'Enter Email..',
                labelText: 'Email',
                iconData: Icons.email,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null,
              ),
              AuthTextFormFieldWidget(
                controller: passwordController,
                hintText: 'Enter New Password..',
                labelText: 'New Password',
                iconData: Icons.lock,
                obscureText: true,
                validator: (password) => password != null && password.length < 6
                    ? 'Minimum 6 characters are required'
                    : null,
              ),
              AuthTextFormFieldWidget(
                controller: confirmController,
                hintText: 'Re-enter Your Password..',
                labelText: 'Confirm Password',
                iconData: Icons.lock,
                obscureText: true,
                validator: (confirm) {
                  return confirm != null && confirm != passwordController.text
                      ? 'Both passwords should be same'
                      : null;
                },
              ),
              AuthButtonWidget(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  signUp(
                    context,
                    formKey,
                    nameController,
                    emailController,
                    passwordController,
                    confirmController,
                  );
                },
                buttonText: 'Sign Up',
              ),
              SwitchUserAccountWidget(
                onClickedSignUp: widget.onClickedSignIn,
                text: 'Already have an account?  ',
                buttonText: 'Sign In',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
