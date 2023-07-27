import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/repositories/cart/base_cart_repo.dart';

class CartRepository extends BaseCartRepository {
  final FirebaseFirestore _firebaseFirestore;

  CartRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<CartModel?> getCartProducts(String email) {
    Stream<List<CartModel?>> cartList = _firebaseFirestore
        .collection('carts')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => CartModel.fromSnapshot(doc))
          .toList();
    });
    return cartList.map((list) {
    return list.firstWhere((cartModel) => cartModel!.userEmail == email, orElse: () => null);
  });
  }

  @override
  Future<void> updateCartProducts(String cartId,CartModel cart) async{
    // QuerySnapshot querySnapshot = await _firebaseFirestore
    //     .collection('carts')
    //     .where('userEmail', isEqualTo: email)
    //     .get();
    // log(querySnapshot.toString());
    // if (querySnapshot.docs.isEmpty) {
    //   _firebaseFirestore.collection('carts').add(cart.toMap());
    //   log('new cart added successfully');
    // } else {
    //   DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
    //   log(documentSnapshot.toString());
    //   String documentId = documentSnapshot.id;
    //   log(documentId);
      try {
        await _firebaseFirestore.collection('carts').doc(cartId).set(
              cart.toMap(),
              SetOptions(merge: true),
            );
        log('cart updated successfully.');
      } catch (error) {
        log('Error updating cart: $error');
      }
      
    //}
  }
  
}