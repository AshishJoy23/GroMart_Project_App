part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class PaymentMethodLoaded extends PaymentEvent {}

class PaymentMethodSelected extends PaymentEvent {
  final PaymentMethod paymentMethod;

  const PaymentMethodSelected({required this.paymentMethod});

  @override
  List<Object> get props => [paymentMethod];
}
