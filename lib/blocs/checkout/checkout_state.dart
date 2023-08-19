part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  final CartModel cart;
  final AddressModel? address;
  final PaymentMethod paymentMethod;

  const CheckoutLoaded({
    required this.cart,
    required this.address,
    required this.paymentMethod,
  });

  @override
  List<Object> get props => [
        cart,
        address!,
        paymentMethod,
      ];
}

class CheckoutError extends CheckoutState {}
