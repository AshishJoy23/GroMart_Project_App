import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/config/colors.dart';

class CheckoutAddressCard extends StatelessWidget {
  final AddressModel address;
  const CheckoutAddressCard({
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
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
            child: ListTile(
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
                      SizedBox(
                        height: height * 0.028,
                      ),
                      InkWell(
                        onTap: () async {
                          await Navigator.pushNamed(
                            context,
                            '/edit_address',
                            arguments: address,
                          );
                        },
                        child: Container(
                          height: height * 0.028,
                          width: width * 0.14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Text(
                            'Edit',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
