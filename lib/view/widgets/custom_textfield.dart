import 'package:flutter/material.dart';
import 'package:gromart_project/view/config/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData iconData;
  final FormFieldValidator<String>? validator;
  final double widthFactor;
  final bool isMaxLength;
  final int? maxLength;
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText=false,
    required this.iconData,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.widthFactor = 1.0,
    this.isMaxLength = false,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 7.0,
      ),
      child: SizedBox(
        width: width*widthFactor,
        child: TextFormField(
          controller: controller,
          textInputAction: TextInputAction.next,
          keyboardType: keyboardType,
          maxLength: isMaxLength ? maxLength : null,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          cursorColor: Colors.black,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(5),
            fillColor: kCardColor,
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
