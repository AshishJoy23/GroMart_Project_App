import 'dart:developer';

import 'package:flutter/material.dart';

class QuantityAddWidget extends StatelessWidget {
  const QuantityAddWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color(0xffC8E6C9).withAlpha(160),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Quantity: ',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      log('fav added');
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '1',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      log('fav added');
                    },
                    icon: const Icon(
                      Icons.remove_circle,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
