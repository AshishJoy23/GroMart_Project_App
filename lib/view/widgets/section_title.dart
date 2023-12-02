import 'package:flutter/material.dart';

class SectionTitleWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool button;
  final String buttonText;
  const SectionTitleWidget({
    super.key,
    required this.title,
    this.onPressed,
    this.button = false,
    this.buttonText = 'Clear All',
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
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
              ? InkWell(
                  onTap: onPressed,
                  borderRadius: BorderRadius.circular(8),
                  splashColor: Colors.black12,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      buttonText,
                      //textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
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
