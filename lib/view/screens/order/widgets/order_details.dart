import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';

class OrderDetailsWidget extends StatelessWidget {
  final OrderModel order;
  const OrderDetailsWidget({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          'ORDER DETAILS',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.black),
        ),
        const Divider(
          thickness: 1,
          color: Colors.black,
        ),
        ListView.builder(
          itemCount: order.orderDetailsMap.length,
          itemBuilder: (context, index) {
            ProductModel product = (BlocProvider.of<ProductBloc>(context).state
                    as ProductLoaded)
                .products
                .firstWhere((product) =>
                    product.id == order.orderDetailsMap[index]['productId']);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 12,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  height: size.height * 0.11,
                  width: size.width / 1,
                  decoration: const BoxDecoration(
                    color: Color(0xffC8E6C9),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            product.imageUrls[0],
                            width: 80,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                '₹ ${product.price}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                'Qty : ${order.orderDetailsMap[index]['quantity']}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mode of Payment : ',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    order.paymentMethod,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Bill Amount : ',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '₹ ${order.grandTotal}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
