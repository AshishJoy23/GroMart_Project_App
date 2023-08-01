import 'dart:developer';

import 'package:flutter/material.dart';
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
          isLeading: false,
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
              const CheckoutNavCardWidget(),
              SizedBox(
                height: height * 0.01,
              ),
              const SectionTitleWidget(title: 'Saved Addresses'),
              Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(height * 0.01),
                        child: Material(
                          elevation: 10,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Container(
                            height: height * 0.17,
                            width: width / 1,
                            decoration: const BoxDecoration(
                              color: Color(0xffC8E6C9),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(
                                width * 0.02,
                              ),
                              child: RadioListTile(
                                value: index,
                                groupValue: 2,
                                onChanged: (value) {},
                                title: Text('Name'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'House No',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Street and City',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Text(
                                      'State and Pin',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Phone Number',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: MainButtonWidget(
            buttonText: 'PAY NOW',
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
