import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SwitchUserAccountWidget extends StatelessWidget {
  final String text;
  final String buttonText;
  final VoidCallback onClickedSignUp;
  const SwitchUserAccountWidget({
    super.key,
    required this.onClickedSignUp,
    required this.text,
    required this.buttonText,
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
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge,
              text: text,
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = onClickedSignUp,
                  text: buttonText,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: const Color(0xff388E3C),
                        decoration: TextDecoration.underline,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
