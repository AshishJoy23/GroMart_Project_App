import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/main.dart';
import 'package:gromart_project/models/address_model.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  static const String routeName = '/address';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AddressScreen(),
    );
  }

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
        appBar: CustomAppBarWidget(
          title: 'My Address',
          actionList: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add_address');
              },
              icon: const Icon(
                Icons.add_circle_outline,
                color: Colors.black,
                size: 28,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // const CheckoutNavCardWidget(),
              // SizedBox(
              //   height: height * 0.01,
              // ),
              const SectionTitleWidget(title: 'Saved Addresses'),
              BlocBuilder<AddressBloc, AddressState>(
                builder: (context, state) {
                  if (state is AddressLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        backgroundColor: Colors.white,
                        color: Colors.black,
                      ),
                    );
                  }
                  if (state is AddressLoadedSuccess) {
                    return state.addresses.isEmpty
                        ? const Center(
                            child: Text('Empty address list, add new address'),
                          )
                        : Column(
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.addresses.length,
                                itemBuilder: (context, index) {
                                  final address = state.addresses[index];
                                  return AddressCardWidget(
                                    index: index,
                                    selectedIndex: state.selectedIndex,
                                    address: address,
                                  );
                                },
                              )
                            ],
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
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: MainButtonWidget(
            buttonText: 'PAY NOW',
            onPressed: () {
              Navigator.pushNamed(context, '/payment');
            },
          ),
        ),
      ),
    );
  }
}


