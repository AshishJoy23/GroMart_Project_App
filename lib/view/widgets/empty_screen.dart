import 'package:flutter/material.dart';

class EmptyScreenWidget extends StatelessWidget {
  final String imageUrl;
  final String emptyMsg;
  const EmptyScreenWidget({
    super.key,
    required this.emptyMsg,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl,
            width: size.width,
            height: size.height * 0.4,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            emptyMsg,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
