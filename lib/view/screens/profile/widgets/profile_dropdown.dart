import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gromart_project/view/config/colors.dart';

class CustomProfileDropDown extends StatelessWidget {
  CustomProfileDropDown({
    super.key,
    required this.genderController,
  });

  final TextEditingController genderController;

  List<String> genderList = [
    'Select One',
    'Male',
    'Female',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    log('<<<<<<<<<<<<drop down>>>>>>>>>>>>');
    log('<<<<<<</${genderController.text}=>>>>>>>');
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 7,
      ),
      child: DropdownButtonFormField(
        value: genderController.text,
        iconSize: 28,
        icon: const Icon(Icons.arrow_drop_down_circle_outlined),
        iconEnabledColor: Colors.black,
        dropdownColor: kPopUpColor,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5),
          fillColor: kCardColor,
          hintText: 'Choose Gender',
          labelText: 'Choose Gender',
          filled: true,
          floatingLabelStyle: TextStyle(
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.category_outlined),
          prefixIconColor: Colors.black54,
        ),
        items: genderList.map((gender) {
          log('<<<<<<<<<<<<,>>>>>>>>>>>>');
          log(gender);
          return DropdownMenuItem(
              value: gender,
              child: Text(
                gender,
              ));
        }).toList(),
        onChanged: (value) {
          genderController.text = value!;
          log(value);
        },
      ),
    );
  }
}
