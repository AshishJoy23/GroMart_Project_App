import 'package:flutter/material.dart';
import 'package:gromart_project/view/config/config.dart';

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
        horizontal: size.width*0.02,
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
                child: Container(
                            height: size.height * 0.038,
                            width: size.width * 0.21,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  buttonText,
                                  //textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontWeight: FontWeight.w600),
                                ),
                                const Icon(Icons.keyboard_arrow_right),
                              ],
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
