import 'package:flutter/material.dart';

class SectionTitleWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool button;
  final String buttonText;
  final double size;
  const SectionTitleWidget({
    super.key,
    required this.title,
    this.onPressed,
    this.button = false,
    this.buttonText = 'Clear All',
    this.size = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          (button)
              ? ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xff388E3C).withAlpha(100)),
                    overlayColor: MaterialStateProperty.all<Color>(
                        Colors.white60.withOpacity(0.1)),
                  ),
                  onPressed: onPressed,
                  child: Row(
                    children: [
                      Text(
                        buttonText,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                )
              : const SizedBox(
                  width: 10,
                ),
        ],
      ),
    );
  }
}
