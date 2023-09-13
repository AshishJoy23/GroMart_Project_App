import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gromart_project/models/order_model.dart';
import 'package:gromart_project/repositories/order/base_order_repo.dart';

class OrderRepository extends BaseOrderRepository {
  final FirebaseFirestore _firebaseFirestore;

  OrderRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;


  @override
  Stream<List<OrderModel>> getAllOrders(String email) {
    return _firebaseFirestore
        .collection('users').doc(email).collection('orders')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => OrderModel.fromSnapshot(doc))
          .toList();
    });
  }

  @override
  Future<void> placeOrder(String email, String orderId, OrderModel order) async{
    try {
      log('<<<<<<<<<<current uredr>>>>>>>>>>');
      log(email);
      log(orderId);
      log(order.grandTotal.toString());
      log(order.placedAt);
      log(order.address.toString());
      log(order.orderDetailsMap.toString());
      log(order.paymentMethod.toString());
      log(order.isPlaced.toString());
      log(order.isConfirmed.toString());
      log('<<<<<<<<//////>>>>>>>>');
      await _firebaseFirestore.collection('users').doc(email).collection('orders').doc(orderId).set(
            order.toMap(),
            SetOptions(merge: true),
          );
      log('Order placed successfully.');
    } catch (error) {
      log('Error while placing order: $error');
    }
  }
  
  @override
  Future<void> updateOrder(String email, OrderModel order) async{
    try {
      await _firebaseFirestore.collection('users').doc(email).collection('orders').doc(order.id).set(
            order.toMap(),
            SetOptions(merge: true),
          );
          log('Order updated successfully.');
    } catch (e) {
      log('Error while updating order: $e');
    }
  }
}