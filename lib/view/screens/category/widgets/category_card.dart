
import 'package:flutter/material.dart';
import 'package:gromart_project/models/category_model.dart';
import 'package:gromart_project/view/config/colors.dart';

// class CategoryCardWidget extends StatelessWidget {
//   final CategoryModel category;
//   const CategoryCardWidget({
//     super.key,
//     required this.category,
//   });

//   @override
//   Widget build(BuildContext context) {
//     var heightScrn = MediaQuery.of(context).size.height / 5;
//     var widthScrn = MediaQuery.of(context).size.width / 2.5;
//     return GestureDetector(
//       onTap: () {
//         log(category.name);
//         Navigator.pushNamed(
//           context,
//           '/each_category',
//           arguments: category,
//         );
//       },
//       child: Stack(
//         children: [
//           SizedBox(
//             width: widthScrn,
//             height: heightScrn,
//             child: Image.network(
//               category.imageUrl,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned(
//             child: Container(
//               width: widthScrn,
//               height: heightScrn,
//               decoration: BoxDecoration(
//                 color: Colors.black.withAlpha(80),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             child: Container(
//               width: widthScrn,
//               height: heightScrn * 0.35,
//               decoration: BoxDecoration(
//                 color: kPrimaryColor.withAlpha(230),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       category.name,
//                       style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                             color: Colors.white,
//                           ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(right: size.height * 0.015),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/each_category',
            arguments: category,
          );
        },
        child: Container(
          width: size.width * 0.25,
          decoration: BoxDecoration(
              color: kCardColor,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 36,
                foregroundImage: NetworkImage(category.imageUrl),
                backgroundColor: kPopUpColor,
              ),
              SizedBox(
                height: size.width * 0.01,
              ),
              Text(
                category.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
