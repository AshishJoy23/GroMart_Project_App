import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String name;
  final String category;
  final String imageUrl;
  final double price;

  const ProductModel({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
  });

  @override
  List<Object?> get props => [
        name,
        category,
        imageUrl,
        price,
      ];

  static List<ProductModel> products = [
    const ProductModel(
      name: 'Apple',
      category: 'Fruits',
      imageUrl: "assets/images/product1.jpg",
      price: 1.99,
    ),
    const ProductModel(
      name: 'Banana',
      category: 'Fruits',
      imageUrl: "assets/images/product2.jpg",
      price: 0.99,
    ),
    const ProductModel(
      name: 'Milk',
      category: 'Dairy',
      imageUrl: "assets/images/product3.jpeg",
      price: 2.49,
    ),
    const ProductModel(
      name: 'Bread',
      category: 'Bakery',
      imageUrl: "assets/images/product4.jpg",
      price: 3.99,
    ),
    const ProductModel(
      name: 'Coca-Cola',
      category: 'Drinks',
      imageUrl: "assets/images/product5.jpg",
      price: 1.49,
    ),
    const ProductModel(
      name: 'Pepsi',
      category: 'Drinks',
      imageUrl: "assets/images/product6.jpeg",
      price: 1.29,
    ),
    const ProductModel(
      name: 'Carrot',
      category: 'Vegetables',
      imageUrl: "assets/images/product7.jpg",
      price: 0.89,
    ),
    const ProductModel(
      name: 'Rice',
      category: 'Grocery',
      imageUrl: "assets/images/product8.jpg",
      price: 1.99,
    ),
  ];
}
