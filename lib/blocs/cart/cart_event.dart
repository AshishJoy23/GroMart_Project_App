part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent { 
  final String email;

  const LoadCart({required this.email});

  
  @override
  List<Object> get props => [email];
}

class UpdateCart extends CartEvent {
  final  CartModel cart;

  const UpdateCart(this.cart);

  @override
  List<Object> get props => [cart];
}

class CartProductAdded extends CartEvent {
  final ProductModel product;

  const CartProductAdded(this.product);

  @override
  List<Object> get props => [product];
}

class CartProductRemoved extends CartEvent {
  final ProductModel product;

  const CartProductRemoved(this.product);

  @override
  List<Object> get props => [product];
}
