import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gromart_project/view/widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  static const String routeName = '/settings';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => SettingsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget(title: 'Profile', actionList: []),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(size.width * 0.02),
                width: size.width * 0.45,
                height: size.height * 0.32,
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => log('message'),
                          child: CircleAvatar(
                            radius: 16.0,
                            child: Icon(
                              Icons.favorite,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(size.width * 0.012),
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/gromart-grocery-app.appspot.com/o/profile_photos%2FIMG_20221224_155839133.jpg?alt=media&token=9a58d94c-eb9b-4267-a894-06a67f57535c',
                            width: size.width * 0.3,
                            height: size.height * 0.16,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                        'category name',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey,
                              height: 0.0,
                            ),
                      ),
                      Text(
                        'product name',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              height: 0.0,
                            ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'product price',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            height: 0.0,
                                          ),
                                ),
                                Text(
                                  'units',
                                  style:
                                      Theme.of(context).textTheme.bodySmall!.copyWith(
                                            color: Colors.grey,
                                            height: 0.0,
                                          ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                            onTap: () => log('message'),
                            child: CircleAvatar(
                              radius: 16.0,
                              child: Icon(
                                Icons.shopping_cart,
                                size: 20,
                              ),
                            ),
                          )
                            ],
                          )
                        ],
                      ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: size.width * 0.45,
                height: size.height * 0.32,
                color: Colors.amberAccent,
              ),
            ],
          )),
      bottomNavigationBar: Row(
        children: [
          MainButtonWidget(buttonText: 'Save Profile', onPressed: () {}),
        ],
      ),
    );
  }
}
