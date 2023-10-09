import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/repositories/wishlist/base_wishlist_repo.dart';

class WishlistRepository extends BaseWishlistRepository {
  final FirebaseFirestore _firebaseFirestore;

  WishlistRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<WishlistModel> getProducts(String email) async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection('users')
          .doc(email)
          .collection('wishlist')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final documentSnapshot = querySnapshot.docs[0];
        return WishlistModel.fromSnapshot(documentSnapshot);
      } else {
        // The subcollection is empty
        log("The wishlist is empty.");
        final wishlist = FirebaseFirestore.instance
            .collection('users')
            .doc(email)
            .collection('wishlist')
            .doc();
        WishlistModel newWishlist = WishlistModel(
          id: wishlist.id,
          productList: const [],
        );
        log(newWishlist.toString());
        updateWishlistProducts(email, wishlist.id, newWishlist);
        return newWishlist;
      }
    } catch (e) {
      log('error updating wishlist: $e');
      return const WishlistModel();
    }
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
