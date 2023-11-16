import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gromart_project/view/config/colors.dart';
import 'package:intl/intl.dart';

class ProfileDatePicker extends StatelessWidget {
  const ProfileDatePicker({
    super.key,
    required this.dateController,
  });

  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 7,
      ),
      child: TextFormField(
        controller: dateController,
        onTap: () {
          dateController.text =
              DateFormat('MMM d, yyyy').format(DateTime.now());
          FocusScope.of(context).requestFocus(FocusNode());
          showCupertinoModalPopup(
            context: context,
            builder: (context) {
              return Container(
                height: size.height * 0.4,
                color: kCardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Done',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium,
                      ),
                    ),
                    Expanded(
                      child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        mode: CupertinoDatePickerMode.date,
                        minimumDate: DateTime(1900),
                        maximumDate: DateTime.now(),
                        onDateTimeChanged: (date) {
                          log(date.toString());
                          dateController.text =
                              DateFormat('MMM d, yyyy')
                                  .format(date);
                          log(dateController.text);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        cursorColor: Colors.black,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5),
          fillColor: kCardColor,
          labelText: 'Choose DOB',
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
          prefixIcon: Icon(Icons.calendar_month),
          prefixIconColor: Colors.black54,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (dob) =>
            dob != '' ? null : 'Date of Birth is required!!',
      ),
    );
  }
}

