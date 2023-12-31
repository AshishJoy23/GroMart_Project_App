import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/main.dart';
import 'package:gromart_project/models/address_model.dart';
import 'package:gromart_project/view/config/config.dart';
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
  final typeController = TextEditingController();
  final String? currentUser = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    typeController.text = BlocProvider.of<AddressBloc>(context).addressType;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: const CustomAppBarWidget(
        title: 'Add Address',
        actionList: [],
      ),
      body: ListView(
        children: [
          Form(
            key: formKey,
            child: BlocListener<AddressBloc, AddressState>(
              listener: (context, state) {
                if (state is AddressLoadedSuccess) {
                  typeController.text = state.addressType;
                }
              },
              child: AddressDetailsWidget(
                  nameController: nameController,
                  phoneController: phoneController,
                  houseController: houseController,
                  streetController: streetController,
                  cityController: cityController,
                  stateController: stateController,
                  pinController: pinController,
                  typeController: typeController),
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
                final AddressModel newAddress = AddressModel(
                  name: nameController.text.trim(),
                  phone: phoneController.text.trim(),
                  house: houseController.text.trim(),
                  street: streetController.text.trim(),
                  city: cityController.text.trim(),
                  state: stateController.text.trim(),
                  pincode: pinController.text.trim(),
                  type: typeController.text.trim(),
                );
                BlocProvider.of<AddressBloc>(context).add(
                    AddressAdded(email: currentUser!, address: newAddress));
                BlocProvider.of<CheckoutBloc>(context)
                    .add(const CheckoutUpdated());
                Utils.showSnackBar(
                    'New Address Added.', const Color(0xff4CAF50));
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
