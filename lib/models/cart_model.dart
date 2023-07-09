import 'package:equatable/equatable.dart';

import 'models.dart';

class CartModel extends Equatable {
  const CartModel();

  double get subTotal => products.fold(0, (total, product) => total+product.price);
  String get subTotalString => subTotal.toStringAsFixed(2);

  double deliveryFee(subTotal){
    if (subTotal>=30.0) {
      return 0.0;
    }else {
      return 2.0;
    }
  }
  String get deliveryFeeString => deliveryFee(subTotal).toStringAsFixed(2);

  String freeDelivery(subTotal){
    if (subTotal>=30.0) {
      return 'You have free delivery';
    }else {
      double neededAmount = 30.0-subTotal;
      return 'Add \$$neededAmount for FREE Delivery';
    }
  }
  String get freeDeliveryStatus => freeDelivery(subTotal);

  double totalAmount(subTotal, deliveryFee){
    return subTotal+deliveryFee;
  }
  String get totalAmountString => totalAmount(subTotal,deliveryFee(subTotal)).toStringAsFixed(2);

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
  ];

  @override
  List<Object?> get props => [];
  
}