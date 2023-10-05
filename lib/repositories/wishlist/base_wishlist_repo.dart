import 'package:gromart_project/models/models.dart';

abstract class BaseWishlistRepository {
  Stream<List<WishlistModel>>  getProducts(String email);
  Future<void> updateWishlistProducts(String email,String wishlistId,WishlistModel newWishlist);
}