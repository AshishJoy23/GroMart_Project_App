import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;
  final String category;
  final String description;
  final List<dynamic> imageUrls;
  final bool isRecommended;
  final bool isPopular;
  final bool isTopRated;
  final bool isTodaySpecial;
  double price;
  int quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrls,
    required this.isRecommended,
    required this.isPopular,
    required this.isTopRated,
    required this.isTodaySpecial,
    this.price = 0,
    this.quantity = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        description,
        imageUrls,
        isRecommended,
        isPopular,
        isTopRated,
        isTodaySpecial,
        price,
        quantity,
      ];

  static ProductModel fromSnapshot(DocumentSnapshot snap) {
    return ProductModel(
      id: snap['id'],
      name: snap['name'],
      category: snap['category'],
      description: snap['description'],
      imageUrls: snap['imageUrls'],
      isRecommended: snap['isRecommended'],
      isPopular: snap['isPopular'],
      isTopRated: snap['isTopRated'],
      isTodaySpecial: snap['isTodaySpecial'],
      price: snap['price'],
      quantity: snap['quantity'],
    );
  }

  static List<ProductModel> products = [
    ProductModel(
      id: 1,
      name: 'Apple',
      category: 'Fruits',
      description: "Apple is a fruit with different colors",
      imageUrls: const ["assets/images/product1.jpg"],
      isRecommended: true,
      isPopular: true,
      isTopRated: false,
      isTodaySpecial: false,
      price: 1.99,
    ),
    ProductModel(
      id: 1,
      name: 'Apple',
      category: 'Fruits',
      description: "Apple is a fruit with different colors",
      imageUrls: const ["assets/images/product1.jpg"],
      isRecommended: true,
      isPopular: true,
      isTopRated: false,
      isTodaySpecial: false,
      price: 1.99,
    ),
    ProductModel(
      id: 1,
      name: 'Apple',
      category: 'Fruits',
      description: "Apple is a fruit with different colors",
      imageUrls: const ["assets/images/product1.jpg"],
      isRecommended: true,
      isPopular: true,
      isTopRated: false,
      isTodaySpecial: false,
      price: 1.99,
    ),
    ProductModel(
      id: 1,
      name: 'Apple',
      category: 'Fruits',
      description: "Apple is a fruit with different colors",
      imageUrls: const ["assets/images/product1.jpg"],
      isRecommended: true,
      isPopular: true,
      isTopRated: false,
      isTodaySpecial: false,
      price: 1.99,
    ),
  ];
}
