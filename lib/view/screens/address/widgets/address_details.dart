import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/view/screens/screens.dart';
import 'package:gromart_project/view/widgets/widgets.dart';

class AddressDetailsWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController houseController;
  final TextEditingController streetController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController pinController;
  final TextEditingController typeController;
  //String addressType;
  final bool isEdit;
  const AddressDetailsWidget({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.houseController,
    required this.streetController,
    required this.cityController,
    required this.stateController,
    required this.pinController,
    required this.typeController,
    this.isEdit = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
        CustomTextFormField(
          controller: houseController,
          labelText: 'House / Building Name',
          iconData: Icons.home,
          validator: (house) => house != '' ? null : 'House Name is required!!',
        ),
        CustomTextFormField(
          controller: streetController,
          labelText: 'Street Name',
          iconData: Icons.location_pin,
          validator: (street) =>
              street != '' ? null : 'Street Name is required!!',
        ),
        CustomTextFormField(
          controller: cityController,
          labelText: 'City Name',
          iconData: Icons.location_city,
          validator: (city) => city != '' ? null : 'City Name is required!!',
        ),
        CustomTextFormField(
          controller: stateController,
          labelText: 'State',
          iconData: Icons.flag,
          validator: (state) =>
              state != '' ? null : 'State name is required!!',
        ),
        CustomTextFormField(
          controller: pinController,
          labelText: 'Pin Code',
          iconData: Icons.pin,
          isMaxLength: true,
          maxLength: 6,
          keyboardType: TextInputType.number,
          validator: (pin) => (pin != null &&
                  pin.length != 6 &&
                  !RegExp(r'^[0-9]{10}$').hasMatch(pin))
              ? 'Pin must be 6 digits'
              : null,
        ),
        BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            if (state is AddressLoadedSuccess) {
              log('<<<<<<<<<<<details pa>>>>>>>>>>>');
              log(typeController.text);
              log('beforeeeeeeeeeeeeee');
              log(state.addressType);
              log('????????????????????????');
              typeController.text = state.addressType;
              log(typeController.text);
              log('<<<<<<<after>>>>>>>');
              log(typeController.text);
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    AddressRadioButtonWidget(
                      addressType: typeController.text,
                      buttonValue: 'Home',
                    ),
                    AddressRadioButtonWidget(
                      addressType: typeController.text,
                      buttonValue: 'Work',
                    ),
                    AddressRadioButtonWidget(
                      addressType: typeController.text,
                      buttonValue: 'Other',
                    ),
                  ],
                ),
              );
            } else {
              return const Icon(
                Icons.error,
                color: Colors.red,
              );
            }
          },
        ),
      ],
    );
  }
}
