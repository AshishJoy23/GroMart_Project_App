part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class OrdersGetLoaded extends OrdersEvent {
  final String email;

  const OrdersGetLoaded({required this.email});

  @override
  List<Object> get props => [email];
}

class OrdersUpdated extends OrdersEvent {
  final List<OrderModel> orders;

  const OrdersUpdated(this.orders);

  @override
  List<Object> get props => [orders];
}

class OrderCancelled extends OrdersEvent {
  final String email;
  final int productId;
  final OrderModel order;

  const OrderCancelled({required  this.email, required this.productId,required this.order});

  @override
  List<Object> get props => [email,productId,order];
}
