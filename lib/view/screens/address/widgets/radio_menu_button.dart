import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';

class AddressRadioButtonWidget extends StatelessWidget {
  AddressRadioButtonWidget({
    super.key,
    required this.addressType,
    required this.buttonValue,
  });

  String addressType;
  final String buttonValue;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        radioTheme: RadioThemeData(
          fillColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.black;
            }
            return Colors.black54;
          }),
        ),
      ),
      child: RadioMenuButton(
        value: buttonValue,
        groupValue: addressType,
        onChanged: (value) {
          BlocProvider.of<AddressBloc>(context)
              .add(AddressTypeButtonClicked(value!));
          addressType = value;
          log('<<<<<<<<<<<<after event call>>>>>>>>>>>>');
          log(value);
          log(addressType);
        },
        child: Text(
          buttonValue,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}