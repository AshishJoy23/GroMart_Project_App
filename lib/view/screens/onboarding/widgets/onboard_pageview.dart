import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/config/config.dart';

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.fuggles(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: const [
                  TextSpan(text: 'GRO'),
                  TextSpan(
                    text: 'M',
                    style: TextStyle(
                      color: kPrimaryColor,
                    ),
                  ),
                  TextSpan(text: 'ART'),
                ],
              ),
            ),
            Text(
              'Stands for Grocery Mart\nA store that sells complete groceries!!',
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.black54,
                      ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.45,
          child: Image.asset(
            onBoardingData[index].imageUrl,
            fit: BoxFit.contain,
          ),
        ),
        Column(
          children: [
            Text(
              onBoardingData[index].title,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            Text(
              onBoardingData[index].subTitle,
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.black54,
                      ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}