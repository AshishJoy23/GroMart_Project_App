import 'package:flutter/material.dart';

class SectionTitleWidget extends StatelessWidget {
  final String title;
  final bool button;
  final double size;
  const SectionTitleWidget({
    super.key,
    required this.title,
    this.button = false,
    this.size = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size,),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
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
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        'Clear All',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Icon(
                        Icons.clear,
                        size: 20,
                        color: Colors.black,
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
