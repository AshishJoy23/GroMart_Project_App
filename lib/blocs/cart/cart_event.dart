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
  final String email;
  final ProductModel product;

  const CartProductAdded(this.email,this.product);

  @override
  List<Object> get props => [email,product];
}

class CartProductRemoved extends CartEvent {
  final String email;
  final ProductModel product;

  const CartProductRemoved(this.email,this.product);

  @override
  List<Object> get props => [email,product];
}

class CartProductDeleted extends CartEvent {
  final String email;
  final ProductModel product;

  const CartProductDeleted(this.email,this.product);

  @override
  List<Object> get props => [email,product];
}
