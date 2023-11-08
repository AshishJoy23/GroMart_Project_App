import 'package:flutter/material.dart';
import 'package:gromart_project/view/config/config.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePhotoWidget extends StatelessWidget {
  final bool isEdit;
  const ProfilePhotoWidget({
    super.key,
    this.isEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: (isEdit)
          ? Stack(
              children: [
                Container(
                  width: size.width * 0.3,
                  height: size.width * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      border: Border.all(
                          width: 1.5, color: const Color(0xff388E3C))),
                  child: Image.asset('assets/images/profile.png'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundColor: Color(0xff388E3C),
                      radius: 18,
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              width: size.width * 0.3,
              height: size.width * 0.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  border:
                      Border.all(width: 1.5, color: const Color(0xff388E3C))),
              child: Image.asset('assets/images/profile.png'),
            ),
    );
  }

  // Future pickImageFromGallery(BuildContext context) async {
  //   ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(
  //     source: ImageSource.gallery,
  //   );
  //   if (image == null) {
  //     Utils.showSnackBar('No image was selected..', Colors.black87);
  //   }
  //   if (image != null) {
  //     await storage.uploadCategoryImage(image);
  //     var imageUrl = await storage.getCategoryImageURL(image.name);
  //     categoryController.categoryImageUrl.value = imageUrl;
  //     await categoryController.newProduct.update(
  //       'imageUrl',
  //       (_) => categoryController.categoryImageUrl,
  //       ifAbsent: () => categoryController.categoryImageUrl,
  //     );
  //   }
  // }
}
