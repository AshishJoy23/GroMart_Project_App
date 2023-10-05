import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/repositories/wishlist/base_wishlist_repo.dart';

class WishlistRepository extends BaseWishlistRepository {
  final FirebaseFirestore _firebaseFirestore;

  WishlistRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance; //

  @override
  Stream<List<WishlistModel>> getProducts(String email) {
    log('<<<<<<inside get all wishlist>>>>>>');
    log(_firebaseFirestore.toString());
    return _firebaseFirestore
        .collection('users')
        .doc(email)
        .collection('wishlist')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        log(doc.toString());
        return WishlistModel.fromSnapshot(doc);
      }).toList();
    });
  }

  @override
  Future<void> updateWishlistProducts(
      String email, String wishlistId, WishlistModel newWishlist) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(email)
          .collection('wishlist')
          .doc(wishlistId)
          .set(newWishlist.toMap(), SetOptions(merge: true));
      log('wishlist updated successfully');
    } catch (e) {
      log('error updating wishlist: $e');
    }
  }
}
