import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData iconData;
  final FormFieldValidator<String>? validator;
  final double widthFactor;
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.hintText = '',
    required this.labelText,
    this.obscureText=false,
    required this.iconData,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.widthFactor = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5,
      ),
      child: SizedBox(
        width: width*widthFactor,
        child: TextFormField(
          controller: controller,
          textInputAction: TextInputAction.next,
          keyboardType: keyboardType,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          cursorColor: Colors.black,
          obscureText: obscureText,
          decoration: InputDecoration(
            fillColor: const Color(0xffC8E6C9),
            labelText: labelText,
            filled: true,
            floatingLabelStyle: const TextStyle(
              color: Colors.black,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            border: const OutlineInputBorder(),
            prefixIcon: Icon(iconData),
            prefixIconColor: Colors.black54,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
        ),
      ),
    );
  }
}
