part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class CheckoutUpdated extends CheckoutEvent {
  final CartModel? cart;
  final AddressModel? address;
  final PaymentMethod? paymentMethod;

  const CheckoutUpdated({
    this.cart,
    this.address,
    this.paymentMethod,
  });

  @override
  List<Object> get props => [
        cart!,
        address!,
        paymentMethod!,
      ];
}

class CheckoutConfirmed extends CheckoutEvent {
  final String email;

  const CheckoutConfirmed({
    required this.email,
  });

  @override
  List<Object> get props => [
        email,
      ];
}
