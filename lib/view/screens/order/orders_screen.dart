import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/config/colors.dart';
import 'package:gromart_project/view/screens/screens.dart';
import 'package:intl/intl.dart';
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
    return Scaffold(
      backgroundColor: kSecondaryColor,
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
            List<OrderModel> totalOrders = state.orders;
            totalOrders.sort((a, b) {
              final DateFormat format = DateFormat('MMM d, yyyy');
              final DateTime dateA = format.parse(a.placedAt);
              final DateTime dateB = format.parse(b.placedAt);
              return dateB.compareTo(dateA);
            });
            log(state.orders.toString());
            log(totalOrders.length.toString());
            log(totalOrders.toString());
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: totalOrders.length,
                      itemBuilder: (context, index) {
                        OrderModel order = totalOrders[index];
                        return OrderProductCardWidget(
                          order: order,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Icon(
              Icons.error,
              color: Colors.red,
            );
          }
        },
      ),
    );
  }
}
