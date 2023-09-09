import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';
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
              log(state.orders.toString());
              return Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.orders.length,
                    itemBuilder: (context, index) {
                      OrderModel order = state.orders[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ORDER ID : ${order.id}'),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: order.orderDetailsMap.length,
                            itemBuilder: (context, index) {
                              ProductModel product = (BlocProvider.of<ProductBloc>(context).state
                    as ProductLoaded)
                .products
                .firstWhere((product) =>
                    product.id == order.orderDetailsMap[index]['productId']);
                              return Text(product.name);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
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
