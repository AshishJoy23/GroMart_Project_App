import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gromart_project/view/widgets/widgets.dart';

class ProfilePhotoWidget extends StatelessWidget {
  const ProfilePhotoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                border:
                    Border.all(width: 1.5, color: const Color(0xff388E3C))),
            child: Image.asset('assets/images/profile.png'),
          ),
          Positioned(
            bottom: 0,
            right: 10,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xffBDBDBD),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 1.5,
                  color: const Color(0xff388E3C),
                ),
              ),
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Center(
                          child: Text(
                            'Upload a Photo',
                            style:
                                Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            MainButtonWidget(buttonText: 'Open Camera',heightFactor: 0.05,),
                            MainButtonWidget(buttonText: 'Open Gallery',heightFactor: 0.05,),
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.edit),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
