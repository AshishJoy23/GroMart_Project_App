import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'models.dart';

class OrderModel extends Equatable {
  final String id;
  final String email;
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
    required this.email,
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
        email,
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

  Map<String, dynamic> toMap() {
    String addressToJson = address!.toJson();
    return {
      'id': id,
      'email': email,
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
  
   
    return OrderModel(
      id: snap['id'],
      email: snap['email'],
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
