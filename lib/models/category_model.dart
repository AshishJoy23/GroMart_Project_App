import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;
  final String imageUrl;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
      ];

  static CategoryModel fromSnapshot(DocumentSnapshot snap) {
    return CategoryModel(
      id: snap['id'],
      name: snap['name'],
      imageUrl: snap['imageUrl'],
    );
  }

  static List<CategoryModel> categories = [
    const CategoryModel(
      id: 1,
      name: 'Drinks',
      imageUrl: "https://5.imimg.com/data5/SELLER/Default/2020/10/FP/GL/OA/521830/soft-drinks-500x500.jpg",
    ),
    const CategoryModel(
      id: 1,
      name: 'Grocery',
      imageUrl: "https://cdn.citymapia.com/assets/business/8245/portfolio/29347/8245_637565416774740550.png?rendered=true",
    ),
    const CategoryModel(
      id: 1,
      name: 'Fruits',
      imageUrl: "https://www.worldatlas.com/r/w1200/upload/46/cb/e1/shutterstock-252338818.jpg",
    ),
    const CategoryModel(
      id: 1,
      name: 'Vegetables',
      imageUrl: "https://thumbs.dreamstime.com/b/fruit-vegetables-7134858.jpg",
    ),
    const CategoryModel(
      id: 1,
      name: 'Edible Oil',
      imageUrl: "https://foodsafetyhelpline.com/wp-content/uploads/2021/11/multi-source-edible-oil.jpg",
    ),
  ];
}
