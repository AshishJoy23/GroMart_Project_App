import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/repositories/cart/base_cart_repo.dart';

class CartRepository extends BaseCartRepository {
  final FirebaseFirestore _firebaseFirestore;

  CartRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<CartModel?> getCartProducts(String email) async* {
    log('<<<<<<<<<<<get cart>>>>>>>>>>>');
    Stream<List<CartModel?>> cartList =
        _firebaseFirestore.collection('carts').snapshots().map((snapshot) {
          log(snapshot.toString());
      return snapshot.docs.map((doc) {
        log('<<<<<<<<doc>>>>>>>>');
        log(doc.toString());
        log(doc.id);
        log(doc['id']);
        log(doc['productsMap'].toString());
        log(doc['userEmail'].toString());
        return CartModel.fromSnapshot(doc);
        }).toList();
    });
    log('<<<<<<<<///////////>>>>>>>>');
    log(cartList.toString());
    List<CartModel?> cartListData = await cartList.first;
    if (cartListData.isEmpty) {
      yield null;
    } else {
      yield* cartList.map((list) {
        return list.firstWhere((cartModel) => cartModel!.userEmail == email,);
      });
    }
  }

  @override
  Future<void> updateCartProducts(String cartId, CartModel cart) async {
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
