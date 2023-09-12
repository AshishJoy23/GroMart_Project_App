part of 'order_confirm_bloc.dart';

abstract class OrderConfirmState extends Equatable {
  const OrderConfirmState();

  @override
  List<Object> get props => [];
}

class OrderConfirmLoading extends OrderConfirmState {}

class OrderConfirmLoaded extends OrderConfirmState {
  final OrderModel order;

  const OrderConfirmLoaded(
    {required this.order,}
  );

  @override
  List<Object> get props => [order];
}

class OrderConfirmError extends OrderConfirmState {}
