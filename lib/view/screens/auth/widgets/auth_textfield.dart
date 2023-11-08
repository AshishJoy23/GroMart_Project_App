import 'package:flutter/material.dart';

class AuthTextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final IconData iconData;
  final FormFieldValidator<String>? validator;
  const AuthTextFormFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.obscureText=false,
    required this.iconData,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10,
      ),
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.next,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        cursorColor: Colors.black,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          contentPadding: const EdgeInsets.all(8),
          floatingLabelStyle: const TextStyle(
            color: Color(0xff388E3C),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff388E3C),
            ),
          ),
          border: const OutlineInputBorder(),
          prefixIcon: Icon(iconData),
          prefixIconColor: Colors.black54,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
      ),
    );
  }
}
