// import 'package:flutter/material.dart';
// import 'package:gromart_project/main.dart';
// import 'package:gromart_project/view/widgets/widgets.dart';

// class OrderConfirmation extends StatelessWidget {
//   static const String routeName = '/order-confirmation';

//   static Route route() {
//     return MaterialPageRoute(
//       settings: RouteSettings(name: routeName),
//       builder: (context) => OrderConfirmation(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBarWidget(
//         isLeading: false,
//           title: 'Order Confirmation',
//           actionList: [],
//         ),
//       bottomNavigationBar: BottomAppBar(
//                     child: MainButtonWidget(
//                       buttonText: 'BACK TO SHOPPING',
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/');
//                       },
//                     ),
//                   ),
//       extendBodyBehindAppBar: true,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   color: Colors.black,
//                   width: double.infinity,
//                   height: 300,
//                 ),
//                 Positioned(
//                   left: (MediaQuery.of(context).size.width - 100) / 2,
//                   top: 125,
//                   child: SvgPicture.asset(
//                     'assets/svgs/garlands.svg',
//                     height: 100,
//                     width: 100,
//                   ),
//                 ),
//                 Positioned(
//                   top: 250,
//                   height: 100,
//                   width: MediaQuery.of(context).size.width,
//                   child: Text(
//                     'Your order is complete!',
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline3!
//                         .copyWith(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Hi Massimo,',
//                     style: Theme.of(context).textTheme.headline5,
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Thank you for purchasing on Zero To Unicorn.',
//                     style: Theme.of(context).textTheme.headline6,
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'ORDER CODE: #k321-ekd3',
//                     style: Theme.of(context).textTheme.headline5,
//                   ),
//                   OrderSummary(),
//                   SizedBox(height: 20),
//                   Text(
//                     'ORDER DETAILS',
//                     style: Theme.of(context).textTheme.headline5,
//                   ),
//                   Divider(thickness: 2),
//                   SizedBox(height: 5),
//                   ListView(
//                     shrinkWrap: true,
//                     padding: EdgeInsets.zero,
//                     physics: NeverScrollableScrollPhysics(),
//                     children: [
//                       ProductCard.summary(
//                         product: Product.products[0],
//                         quantity: 2,
//                       ),
//                       ProductCard.summary(
//                         product: Product.products[0],
//                         quantity: 2,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }