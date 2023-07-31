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
              onPressed: () {},
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
                    physics: NeverScrollableScrollPhysics(),
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
                            height: height * 0.142,
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
                              child: RadioListTile(value: 1, groupValue: 1, onChanged: (value) {
                                
                              },)
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
              RadioMenuButton(
                                value: 1,
                                groupValue: 0,
                                onChanged: (value) {},
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('11111111111111111111111111111'),
                                      Text('1'),
                                      Text('1'),
                                      Text('1'),
                                      Text('1'),
                                    ],
                                  ),
                                ),
                                trailingIcon: Icon(Icons.abc),
                              ),
            ],
          ),
        ),
      ),
    );
  }
}
