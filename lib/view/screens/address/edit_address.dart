import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/address_model.dart';
import 'package:gromart_project/view/config/config.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class EditAddressScreen extends StatelessWidget {
  final AddressModel address;
  EditAddressScreen({
    super.key,
    required this.address,
  });

  static const String routeName = '/edit_address';

  static Route route({required AddressModel address}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => EditAddressScreen(
        address: address,
      ),
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
  final typeController = TextEditingController();
  //String? addressType;
  final String? currentUser = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    log(address.toString());
    nameController.text = address.name;
    phoneController.text = address.phone;
    houseController.text = address.house;
    streetController.text = address.street;
    cityController.text = address.city;
    stateController.text = address.state;
    pinController.text = address.pincode;
    typeController.text = address.type;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: const CustomAppBarWidget(
        title: 'Edit Address',
        actionList: [],
      ),
      body: ListView(
        children: [
          Form(
            key: formKey,
            child: AddressDetailsWidget(
              nameController: nameController,
              phoneController: phoneController,
              houseController: houseController,
              streetController: streetController,
              cityController: cityController,
              stateController: stateController,
              pinController: pinController,
              typeController: typeController,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        children: [
          MainButtonWidget(
            buttonText: 'Save Address',
            onPressed: () {
              final isValid = formKey.currentState!.validate();
              if (isValid) {
                log('navigate to previous');
                final AddressModel updatedAddress = AddressModel(
                  id: address.id,
                  name: nameController.text.trim(),
                  phone: phoneController.text.trim(),
                  house: houseController.text.trim(),
                  street: streetController.text.trim(),
                  city: cityController.text.trim(),
                  state: stateController.text.trim(),
                  pincode: pinController.text.trim(),
                  type: typeController.text.trim(),
                );
                BlocProvider.of<AddressBloc>(context).add(AddressEdited(
                    email: currentUser!, address: updatedAddress));
                Utils.showSnackBar(
                    'Address is edited.', const Color(0xff4CAF50));
                Navigator.pop(context);
              } else {
                log('not valid');
                log(typeController.text.toString());
                Utils.showSnackBar(
                    'All the fields are required.', Colors.redAccent);
              }
            },
          ),
        ],
      ),
    );
  }
}
