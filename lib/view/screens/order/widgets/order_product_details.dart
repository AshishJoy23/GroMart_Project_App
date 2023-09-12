import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';

class OrderProductDetails extends StatelessWidget {
  const OrderProductDetails({
    super.key,
    required this.orderProductDetails,
  });

  final Map<String, dynamic> orderProductDetails;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    ProductModel product =
        (BlocProvider.of<ProductBloc>(context).state as ProductLoaded)
            .products
            .firstWhere(
                (product) => product.id == orderProductDetails['productId']);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Detail:',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/product',
                arguments: product,
              );
            },
            child: Material(
              elevation: 12,
              borderRadius:
                  const BorderRadius.all(Radius.circular(20)),
              child: Container(
                height: size.height * 0.15,
                width: size.width / 1,
                decoration: const BoxDecoration(
                  color: Color(0xffC8E6C9),
                  borderRadius:
                      BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          product.imageUrls[0],
                          width: size.height * 0.12,
                          height: size.height * 0.15,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium,
                            ),
                            Text(
                              '₹ ${product.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge,
                            ),
                            const Spacer(),
                            const Divider(),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${orderProductDetails['quantity'] * product.price}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium,
                                  ),
                                ),
                                Text(
                                  'QTY : ${orderProductDetails['quantity']}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontWeight:
                                              FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.005,
        ),
        const Divider(
          color: Colors.black,
        ),
      ],
    );
  }
}

