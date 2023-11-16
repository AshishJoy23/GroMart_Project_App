import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/config/config.dart';

class AddressCardWidget extends StatelessWidget {
  const AddressCardWidget({
    super.key,
    required this.address,
    this.index = 0,
    this.selectedIndex = 0,
  });

  final AddressModel address;
  final int selectedIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    final String? currentUser = FirebaseAuth.instance.currentUser!.email;
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Padding(
      padding: EdgeInsets.all(height * 0.01),
      child: Material(
        elevation: 5.0,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        child: Container(
          height: height * 0.17,
          width: width / 1,
          decoration: const BoxDecoration(
            color: kCardColor,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Padding(
            padding: EdgeInsets.all(
              width * 0.02,
            ),
            child: RadioListTile(
              activeColor: Colors.black,
              value: index,
              groupValue: selectedIndex,
              onChanged: (value) {
                BlocProvider.of<AddressBloc>(context)
                    .add(AddressCardSelected(index));
              },
              title: Row(
                children: [
                  Expanded(child: Text(address.name)),
                  (address.type != 'Other')
                      ? Container(
                          height: height * 0.028,
                          width: width * 0.14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black,
                          ),
                          child: Text(
                            address.type,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              subtitle: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          address.house,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${address.street}, ${address.city}',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Text(
                          '${address.state}, ${address.pincode}',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          address.phone,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      PopupMenuButton<String>(
                        color: kPopUpColor,
                        iconSize: 28,
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.black,
                          size: 28,
                        ),
                        padding: const EdgeInsets.all(1.0),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: "Edit",
                            child: TextButton(
                              onPressed: () async {
                                BlocProvider.of<AddressBloc>(context).add(
                                    AddressTypeButtonClicked(address.type));
                                await Navigator.pushNamed(
                                  context,
                                  '/edit_address',
                                  arguments: address,
                                );
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Edit',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: "Delete",
                            child: TextButton(
                              onPressed: () async {
                                BlocProvider.of<AddressBloc>(context).add(
                                    AddressDeleted(
                                        email: currentUser!,
                                        addressId: address.id));
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Delete',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
