import 'package:flutter/material.dart';

class AuthButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const AuthButtonWidget({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff388E3C),
                minimumSize: const Size.fromHeight(55),
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
      ],
    );
  }
}
