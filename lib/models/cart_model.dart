import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'models.dart';

class CartModel extends Equatable {
  final String id;
  final Map<ProductModel, int> productsMap;
  final String userEmail;
  final double subTotal;
  final double deliveryFee;
  final double grandTotal;
  const CartModel({
    this.id='0',
    this.productsMap=const {},
    this.userEmail='',
    this.subTotal=0.0,
    this.deliveryFee=0.0,
    this.grandTotal=0.0,
  });

  @override
  List<Object?> get props => [
        id,
        productsMap,
        userEmail,
        subTotal,
        deliveryFee,
        grandTotal,
      ];

  CartModel copyWith({
    String? id,
    Map<ProductModel, int>? productsMap,
    String? userEmail,
    double? subTotal,
    double? deliveryFee,
    double? grandTotal,
  }) {
    return CartModel(
      id: id ?? this.id,
      productsMap: productsMap ?? this.productsMap,
      userEmail: userEmail ?? this.userEmail,
      subTotal: subTotal ?? this.subTotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      grandTotal: grandTotal ?? this.grandTotal,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'productsMap': productsMap,
        'userEmail': userEmail,
        'subTotal': subTotal,
        'deliveryFee': deliveryFee,
        'grandTotal': grandTotal,
      };

  factory CartModel.fromSnapshot(DocumentSnapshot snap) {
    return CartModel(
      id: snap['id'],
      productsMap: snap['productsMap'],
      userEmail: snap['userEmail'],
      subTotal: snap['subTotal'],
      deliveryFee: snap['deliveryFee'],
      grandTotal: snap['grandTotal'],
    );
  }

  // double get subTotals =>
  //     products.fold(0, (total, product) => total + product.price);
  double get subTotals {
    return productsMap.entries.fold(0, (total, entry) {
      ProductModel product = entry.key;
      int quantity = entry.value;
      return total + (product.price * quantity);
    });
  }

  String get subTotalString => subTotals.toStringAsFixed(2);

  double deliveryFees(subTotals) {
    if (subTotals >= 30.0) {
      return 0.0;
    } else {
      return 2.0;
    }
  }

  String get deliveryFeeString => deliveryFees(subTotals).toStringAsFixed(2);

  String freeDelivery(subTotals) {
    if (subTotals >= 30.0) {
      return 'You have free delivery';
    } else {
      double neededAmount = 30.0 - subTotals;
      return 'Add \$$neededAmount for FREE Delivery';
    }
  }

  String get freeDeliveryStatus => freeDelivery(subTotals);

  double totalAmount(subTotals, deliveryFee) {
    return subTotals + deliveryFee;
  }

  String get totalAmountString =>
      totalAmount(subTotals, deliveryFees(subTotals)).toStringAsFixed(2);

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
