import 'package:gromart_project/models/models.dart';

abstract class BaseCartRepository {
  //Stream<List<ProductModel>> getCartProducts();
  Stream<CartModel?> getCartProducts(String email);
  Future<void> updateCartProducts(String cartId,CartModel cart);
  Future<void> deleteCartProducts(String cartId, CartModel cart);
}

