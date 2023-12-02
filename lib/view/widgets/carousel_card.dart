import 'package:flutter/material.dart';
import 'package:gromart_project/models/models.dart';

class CarouselCardWidget extends StatelessWidget {
  final CategoryModel? category;
  final ProductModel? product;
  const CarouselCardWidget({
    super.key,
    this.category,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: Stack(
          children: <Widget>[
            product == null
                ? Image.network(
                    category!.imageUrl,
                    fit: BoxFit.fill,
                    width: 1000.0,
                  )
                : Image.network(
                    product!.imageUrls[0],
                    fit: BoxFit.fill,
                    width: 1000.0,
                  ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text(
                  product == null ? category!.name : '',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
