import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/config/config.dart';

class CartQuantityUpdateButton extends StatelessWidget {
  const CartQuantityUpdateButton({
    super.key,
    required this.quantity,
    required this.product,
  });

  final int quantity;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final String? userEmail = FirebaseAuth.instance.currentUser!.email;
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (quantity > 1)
                ? () {
                    BlocProvider.of<CartBloc>(context)
                        .add(CartProductRemoved(
                            userEmail!, product));
                  }
                : () => ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        behavior:
                            SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(5),
                        backgroundColor:
                            const Color(0xff4CAF50),
                        content: Text(
                          'Minimum quantity of 1 is allowed.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight:
                                      FontWeight.w600),
                        ),
                        duration:
                            const Duration(seconds: 2),
                      ),
                    ),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: kSecondaryColor,
              child: Icon(
                Icons.arrow_drop_down_outlined,
                color: (quantity > 1)
                    ? Colors.black
                    : kPopUpColor,
                size: 28,
              ),
            ),
          ),
          Text(
            '$quantity',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          InkWell(
            onTap: (quantity < 10)
                ? () {
                    BlocProvider.of<CartBloc>(context)
                        .add(CartProductAdded(
                            userEmail!, product));
                  }
                : () => ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        behavior:
                            SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(5),
                        backgroundColor:
                            const Color(0xff4CAF50),
                        content: Text(
                          'Maximum quantity of 10 is allowed.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight:
                                      FontWeight.w600),
                        ),
                        duration:
                            const Duration(seconds: 2),
                      ),
                    ),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: kSecondaryColor,
              child: Icon(
                Icons.arrow_drop_up_outlined,
                color: (quantity < 10)
                    ? Colors.black
                    : kPopUpColor,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
