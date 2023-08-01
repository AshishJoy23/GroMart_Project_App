import 'dart:developer';

import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({super.key});

  static const String routeName = '/add_address';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => AddAddressScreen(),
    );
  }

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final houseController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pinController = TextEditingController();
  final List<String> indianStates = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff4CAF50),
            Color(0xffC8E6C9),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBarWidget(
          title: 'Add Address',
          actionList: [],
        ),
        body: ListView(
          children: [
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    controller: nameController,
                    hintText: 'Enter your name',
                    labelText: 'Full Name',
                    iconData: Icons.person,
                    validator: (name) =>
                        name != '' ? null : 'Name is required!!',
                  ),
                  CustomTextFormField(
                    controller: phoneController,
                    hintText: 'Enter your phone number',
                    labelText: 'Phone Number',
                    iconData: Icons.phone_android,
                    obscureText: true,
                    validator: (phone) =>
                        phone != '' ? null : 'Phone is required!!',
                  ),
                  CustomTextFormField(
                    controller: houseController,
                    hintText: 'Enter your house/building name',
                    labelText: 'House / Building Name',
                    iconData: Icons.home,
                    validator: (house) =>
                        house != '' ? null : 'House Name is required!!',
                  ),
                  CustomTextFormField(
                    controller: streetController,
                    hintText: 'Enter your street name',
                    labelText: 'Street Name',
                    iconData: Icons.location_pin,
                    validator: (street) =>
                        street != '' ? null : 'Street Name is required!!',
                  ),
                  CustomTextFormField(
                    controller: cityController,
                    hintText: 'Enter your city',
                    labelText: 'City Name',
                    iconData: Icons.location_city,
                    validator: (city) =>
                        city != '' ? null : 'City Name is required!!',
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: stateController,
                          hintText: 'Enter your state name',
                          labelText: 'State Name',
                          iconData: Icons.pin,
                          keyboardType: TextInputType.number,
                          validator: (pin) =>
                              pin != '' ? null : 'State name is required!!',
                        ),
                      ),
                      CustomTextFormField(
                        controller: stateController,
                        hintText: 'Enter your pin',
                        labelText: 'Pin Code',
                        iconData: Icons.pin,
                        keyboardType: TextInputType.number,
                        widthFactor: 0.37,
                        validator: (pin) =>
                            pin != '' ? null : 'Pin Code is required!!',
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        RadioMenuButton(
                          value: 'Home',
                          groupValue: 1,
                          onChanged: (value) {
                            log(value.toString());
                          },
                          child: Text(
                            'Home',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        RadioMenuButton(
                          child: Text(
                            'Work',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          value: 'Work',
                          groupValue: 'Work',
                          onChanged: (value) {
                            log(value.toString());
                          },
                        ),
                        RadioMenuButton(
                          child: Text(
                            'Other',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          value: 'Other',
                          groupValue: 1,
                          onChanged: (value) {
                            log(value.toString());
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: MainButtonWidget(
            buttonText: 'SAVE ADDRESS',
            onPressed: () {
              final isValid = formKey.currentState!.validate();
              if (isValid) {
                log('navigate to previous');
              } else {
                log('not valid');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.all(5),
                    backgroundColor: const Color(0xff4CAF50),
                    content: Text(
                      'All the fields are required.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
