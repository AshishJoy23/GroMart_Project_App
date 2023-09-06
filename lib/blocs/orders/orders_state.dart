part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<OrderModel> orders;
  final OrderModel? order;

  const OrdersLoaded({
    this.orders = const <OrderModel>[],
    this.order,
  });

  OrdersLoaded copyWith({
    List<OrderModel>? orders,
    OrderModel? order,
  }) {
    return OrdersLoaded(
      orders: orders ?? this.orders,
      order: order ?? this.order,
    );
  }

  @override
  List<Object> get props => [orders,order!];
}

class OrdersError extends OrdersState {}
