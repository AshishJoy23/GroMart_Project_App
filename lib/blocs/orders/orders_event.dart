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
  final  List<OrderModel> orders;

  const OrdersUpdated(this.orders);

  @override
  List<Object> get props => [orders];
}

class OrderConfirmed extends OrdersEvent {
  final String email;
  final OrderModel order;

  const OrderConfirmed(this.email,this.order);

  @override
  List<Object> get props => [email,order];
}

class OrderCancelled extends OrdersEvent {
  final  OrderModel order;

  const OrderCancelled(this.order);

  @override
  List<Object> get props => [order];
}
