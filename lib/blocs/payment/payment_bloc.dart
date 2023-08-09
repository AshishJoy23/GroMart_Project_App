import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/models/models.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentLoading()) {
    on<PaymentMethodLoaded>(_onPaymentMethodLoaded);
    on<PaymentMethodSelected>(_onPaymentMethodSelected);
  }

  void _onPaymentMethodLoaded(
    PaymentMethodLoaded event,
    Emitter<PaymentState> emit,
  ) {
    emit(
      const PaymentLoaded(),
    );
  }

  void _onPaymentMethodSelected(
    PaymentMethodSelected event,
    Emitter<PaymentState> emit,
  ) {
    emit(
      PaymentLoaded(paymentMethod: event.paymentMethod),
    );
  }
}
