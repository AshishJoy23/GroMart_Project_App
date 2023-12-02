import 'package:flutter/material.dart';

class OnBoardNavButton extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  const OnBoardNavButton({
    super.key,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      splashColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          name,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.black87,
              ),
        ),
      ),
    );
  }
}
