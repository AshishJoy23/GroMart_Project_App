import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/screens/screens.dart';
import '../../widgets/widgets.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const String routeName = '/orders';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const OrdersScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    
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
        appBar: const CustomAppBarWidget(
          title: 'My Orders',
          actionList: [],
        ),
        body: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            if (state is OrdersLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  backgroundColor: Colors.white,
                  color: Colors.black,
                ),
              );
            }
            if (state is OrdersLoaded) {
              log('<<<<<<<<<<orders screen>>>>>>>>>>');
              List<Map<String, dynamic>> totalOrders = [];
              log(state.orders.toString());
              for (OrderModel order in state.orders) {
                totalOrders.addAll(order.orderDetailsMap);
              }
              log(totalOrders.length.toString());
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.orders.length,
                        itemBuilder: (context, index) {
                          OrderModel order = state.orders[index];
                          return OrderProductCardWidget(order: order,);
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Text('Something went wrong!!!');
            }
          },
        ),
      ),
    );
  }
}

