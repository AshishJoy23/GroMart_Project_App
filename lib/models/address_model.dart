import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String house;
  final String street;
  final String city;
  final String state;
  final String pincode;
  String type;

  AddressModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.house,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    this.type = '',
  });

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        house,
        street,
        city,
        state,
        pincode,
        type,
      ];

  static AddressModel fromSnapshot(DocumentSnapshot snap) {
    return AddressModel(
      id: snap['id'],
      name: snap['name'],
      phone: snap['phone'],
      house: snap['house'],
      street: snap['street'],
      city: snap['city'],
      state: snap['state'],
      pincode: snap['pincode'],
      type: snap['type'],
    );
  }

  // factory AddressModel.fromJson(Map<String, dynamic> json) {
  //   return AddressModel(
  //     id: json['id'],
  //     name: json['name'],
  //     phone: json['phone'],
  //     house: json['house'],
  //     street: json['street'],
  //     city: json['city'],
  //     state: json['state'],
  //     pincode: json['pincode'],
  //     type: json['type'],
  //   );
  // }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'phone': phone,
        'house': house,
        'street': street,
        'city': city,
        'state': state,
        'pincode': pincode,
        'type': type,
      };

  String toJson() {
    return json.encode(toMap());
  }
}
