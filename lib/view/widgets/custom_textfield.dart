import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData iconData;
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        cursorColor: Colors.black,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            floatingLabelStyle: const TextStyle(
              color: Color(0xff388E3C),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xff388E3C),
              ),
            ),
            border: const UnderlineInputBorder(),
            prefixIcon: Icon(iconData),
            prefixIconColor: Colors.black54),
      ),
    );
  }
}
