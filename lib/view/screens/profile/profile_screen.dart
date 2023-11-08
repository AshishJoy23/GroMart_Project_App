import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gromart_project/view/widgets/widgets.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  static const String routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => ProfileScreen(),
    );
  }

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final dateController = TextEditingController();
  List<String> genderList = [
    'Male',
    'Female',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget(title: 'Profile', actionList: []),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const ProfilePhotoWidget(
              isEdit: true,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              controller: nameController,
              labelText: 'Full Name',
              iconData: Icons.person,
              validator: (name) => name != '' ? null : 'Name is required!!',
            ),
            CustomTextFormField(
              controller: phoneController,
              labelText: 'Phone Number',
              isMaxLength: true,
              maxLength: 10,
              iconData: Icons.phone_android,
              keyboardType: TextInputType.number,
              validator: (phone) => (phone != null &&
                      phone.length != 10 &&
                      !RegExp(r'^[0-9]{10}$').hasMatch(phone))
                  ? 'Phone number should be 10 digits'
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 7,
              ),
              child: DropdownButtonFormField(
                iconSize: 28,
                icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                iconEnabledColor: Colors.black,
                dropdownColor: const Color(0xffC8E6C9),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  fillColor: Color(0xffC8E6C9),
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
                  return DropdownMenuItem(
                      value: gender,
                      child: Text(
                        gender,
                      ));
                }).toList(),
                onChanged: (value) {}, 
              ),
            ),
            Padding(
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
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Done',
                                style:
                                    Theme.of(context).textTheme.titleMedium,
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
                                      DateFormat('MMM d, yyyy').format(date);
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
                  fillColor: Color(0xffC8E6C9),
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
            ),
          ],
        ),
      ),
    );
  }
}
