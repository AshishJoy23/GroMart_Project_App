import 'package:flutter/material.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/forgot');
            },
            child: Text(
              'Forgot Password',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: const Color.fromARGB(255, 177, 23, 23),
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Color.fromARGB(255, 177, 23, 23),
            size: 16,
          ),
        ],
      ),
    );
  }
}
