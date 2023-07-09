import 'dart:developer';

import 'package:flutter/material.dart';

class ProductBottomAppBar extends StatelessWidget {
  const ProductBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                        Color(0xff388E3C),
                      ),
                    ),
                    onPressed: () {
                      log('choose from camera');
                    },
                    child: Text(
                      'Add To Cart',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                        Color(0xff388E3C),
                      ),
                    ),
                    onPressed: () {
                      log('choose from camera');
                    },
                    child: Text(
                      'Buy Now',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
