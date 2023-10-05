part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class WishListGetLoaded extends WishlistEvent {
  final String email;

  const WishListGetLoaded({required this.email});
   @override
  List<Object> get props => [email];
}

class WishlistUpdated extends WishlistEvent {
  final WishlistModel wishlist;

  const WishlistUpdated(this.wishlist);

  @override
  List<Object> get props => [wishlist];
}
class RemoveFromWishlist extends WishlistEvent {
  final String email;
  final int productId;

  const RemoveFromWishlist({required this.email,required this.productId});

  @override
  List<Object> get props => [email,productId];
}
class AddToWishlist extends WishlistEvent {
  final String email;
  final int productId;

  const AddToWishlist({required this.email,required this.productId});

  @override
  List<Object> get props => [email,productId];
}
