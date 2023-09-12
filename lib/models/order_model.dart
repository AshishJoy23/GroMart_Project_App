import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'models.dart';

class OrderModel extends Equatable {
  final String id;
  final List<Map<String, dynamic>> orderDetailsMap;
  final AddressModel? address;
  final String paymentMethod;
  final String placedAt;
  final bool isPlaced;
  final bool isConfirmed;
  final bool isCancelled;
  final double subTotal;
  final double deliveryFee;
  final double grandTotal;
  const OrderModel({
    this.id = '0',
    required this.orderDetailsMap,
    required this.address,
    required this.paymentMethod,
    required this.placedAt,
    this.isPlaced = false,
    this.isConfirmed = false,
    this.isCancelled = false,
    required this.subTotal,
    required this.deliveryFee,
    required this.grandTotal,
  });

  @override
  List<Object?> get props => [
        id,
        orderDetailsMap,
        address,
        paymentMethod,
        placedAt,
        isPlaced,
        isConfirmed,
        isConfirmed,
        subTotal,
        deliveryFee,
        grandTotal,
      ];

  OrderModel copyWith({
    String? id,
  List<Map<String, dynamic>>? orderDetailsMap,
  AddressModel? address,
  String? paymentMethod,
  String? placedAt,
  bool? isPlaced,
  bool? isConfirmed,
  bool? isCancelled,
  double? subTotal,
  double? deliveryFee,
  double? grandTotal,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderDetailsMap: orderDetailsMap ?? this.orderDetailsMap,
      address: address ?? this.address,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      placedAt: placedAt ?? this.placedAt,
      isPlaced: isPlaced ?? this.isPlaced,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      isCancelled: isCancelled ?? this.isCancelled,
      subTotal: subTotal ?? this.subTotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      grandTotal: grandTotal ?? this.grandTotal,
    );
  }

  Map<String, dynamic> toMap() {
    String addressToJson = address!.toJson();
  //   Map<String, dynamic> orderDetailsMapToJson = orderDetailsMap.map((key, value) {
  //   // Convert each key-value pair to the desired types.
  //   ProductModel product = key; // Assuming 'key' is the ProductModel instance
  //   int quantity = value;
  //   return MapEntry(product.toJson(), quantity);
  // });
    return {
      'id': id,
      'orderDetailsMap': orderDetailsMap,
      'address': addressToJson,
      'paymentMethod': paymentMethod,
      'placedAt': placedAt,
      'isPlaced': isPlaced,
      'isConfirmed': isConfirmed,
      'isCancelled': isCancelled,
      'subTotal': subTotal,
      'deliveryFee':deliveryFee,
      'grandTotal': grandTotal,
    };
  }

  static OrderModel fromSnapshot(DocumentSnapshot snap) {
    AddressModel addressFromJson = AddressModel.fromJson(json.decode(snap['address']));
    List<Map<String, dynamic>> orderDetailsMapFromJson = List<Map<String, dynamic>>.from(snap['orderDetailsMap']);
  
    // Map<ProductModel, int> orderDetailsMap = orderDetailsMapJson.map((key, value) {
    //   // Convert each key-value pair to the desired types.
    //   ProductModel product = ProductModel.fromJson(json.decode(key));
    //   int quantity = value;
    //   return MapEntry(product, quantity);
    // });
    return OrderModel(
      id: snap['id'],
      orderDetailsMap: orderDetailsMapFromJson,
      address: addressFromJson,
      paymentMethod: snap['paymentMethod'],
      placedAt: snap['placedAt'],
      isPlaced: snap['isPlaced'],
      isConfirmed: snap['isConfirmed'],
      isCancelled: snap['isCancelled'],
      subTotal: snap['subTotal'],
      deliveryFee: snap['deliveryFee'],
      grandTotal: snap['grandTotal'],
    );
  }

}
