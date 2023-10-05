import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class WishlistModel extends Equatable {
  final String id;
  final List<int> productList;
  const WishlistModel({
    required this.id,
    required this.productList,
  });

  @override
  List<Object?> get props => [
        id,
        productList,
      ];

 

  Map<String, dynamic> toMap() => {
        'id': id,
        'productList': productList,
      };

  factory WishlistModel.fromSnapshot(DocumentSnapshot snap) {
    List<int> productList = (snap['productList'] as List<dynamic>).map((item) => item as int).toList();

    return WishlistModel(
      id: snap['id'],
      productList: productList,
    );
  }

  String toJson() => json.encode(toMap());
}