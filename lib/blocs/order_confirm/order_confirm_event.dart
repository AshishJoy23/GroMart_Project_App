part of 'order_confirm_bloc.dart';

abstract class OrderConfirmEvent extends Equatable {
  const OrderConfirmEvent();

  @override
  List<Object> get props => [];
}

class OrderConfirmed extends OrderConfirmEvent {
  final String email;
  final OrderModel order;
  final CartModel cart;

  const OrderConfirmed({
    required this.email,
    required this.order,
    required this.cart,
  });

  @override
  List<Object> get props => [
        email,
        order,
        cart,
      ];
}
