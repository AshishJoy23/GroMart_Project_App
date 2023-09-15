import 'dart:developer';

import 'package:flutter/material.dart';

class MainButtonWidget extends StatelessWidget {
  final String buttonText;
  final bool isSubButton;
  final double heightFactor;
  final VoidCallback onPressed;
  const MainButtonWidget({
    super.key,
    required this.buttonText,
    this.isSubButton = false,
    this.heightFactor = 0.07,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return (isSubButton)
        ? Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: onPressed,
                child: Container(
                  height: size.height * heightFactor,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff388E3C), // Border color
                      width: 2.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(8.0), // Border radius
                  ),
                  child: Center(
                    child: Text(
                      buttonText,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
            ),
          )
        : Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: size.height * heightFactor,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      Color(0xff388E3C),
                    ),
                  ),
                  onPressed: onPressed,
                  child: Text(
                    buttonText,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          );
  }
}
