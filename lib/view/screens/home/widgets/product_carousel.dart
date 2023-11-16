import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';

import '../../../../models/models.dart';
import '../../../widgets/widgets.dart';

class ProductCarouselWidget extends StatelessWidget {
  final List<ProductModel> products;
  const ProductCarouselWidget({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.34,
      child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: size.height * 0.015, vertical: size.height * 0.012),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: size.height * 0.015),
              child: BlocBuilder<WishlistBloc, WishlistState>(
                builder: (context, state) {
                  if (state is WishlistLoading) {
                    return Center(
                      child: Transform.scale(
                        scale: 0.7,
                        child: const CircularProgressIndicator(
                          strokeWidth: 3,
                          backgroundColor: Colors.white,
                          color: Colors.black,
                        ),
                      ),
                    );
                  } else if (state is WishlistLoaded) {
                    return ProductCardWidget(
                      product: products[index],
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
          }),
    );
  }
}
