import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/main.dart';
import 'package:gromart_project/models/address_model.dart';
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

  @override
  Widget build(BuildContext context) {
    String addressType = BlocProvider.of<AddressBloc>(context).addressType;
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
              child: BlocListener<AddressBloc, AddressState>(
                listener: (context, state) {
                  if (state is AddressLoadedSuccess) {
                    addressType = state.addressType;
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
                    addressType: addressType),
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
                final AddressModel newAddress = AddressModel(
                  name: nameController.text.trim(),
                  phone: phoneController.text.trim(),
                  house: houseController.text.trim(),
                  street: streetController.text.trim(),
                  city: cityController.text.trim(),
                  state: stateController.text.trim(),
                  pincode: pinController.text.trim(),
                  type: addressType,
                );
                BlocProvider.of<AddressBloc>(context)
                    .add(AddressAdded(newAddress));
                Navigator.pop(context);
              } else {
                log('not valid');
                log(addressType.toString());
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
                    duration: const Duration(seconds: 1),
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

