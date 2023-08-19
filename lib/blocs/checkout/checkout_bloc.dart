import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc _cartBloc;
  final AddressBloc _addressBloc;
  final PaymentBloc _paymentBloc;
  StreamSubscription? _cartSubscription;
  StreamSubscription? _addressSubscription;
  StreamSubscription? _paymentSubscription;
  CheckoutBloc({
    required CartBloc cartBloc,
    required AddressBloc addressBloc,
    required PaymentBloc paymentBloc,
  })  : _cartBloc = cartBloc,
        _addressBloc = addressBloc,
        _paymentBloc = paymentBloc,
        super(CheckoutLoading()) {
    on<CheckoutUpdated>(_onCheckoutUpdated);
    on<CheckoutConfirmed>(_onCheckoutConfirmed);

    _cartSubscription = _cartBloc.stream.listen((state) {
      if (state is CartLoaded) {
        add(CheckoutUpdated(cart: state.cart));
      }
    });
    _addressSubscription = _addressBloc.stream.listen((state) {
      if (state is AddressLoadedSuccess) {
        add(CheckoutUpdated(address: state.address));
      }
    });
    _paymentSubscription = _paymentBloc.stream.listen((state) {
      if (state is PaymentLoaded) {
        add(CheckoutUpdated(paymentMethod: state.paymentMethod));
      }
    });
  }

  void _onCheckoutUpdated(CheckoutUpdated event, Emitter<CheckoutState> emit) {
    if (_cartBloc.state is CartLoaded &&
        _addressBloc.state is AddressLoadedSuccess &&
        _paymentBloc.state is PaymentLoaded) {
      emit(CheckoutLoaded(
        cart: (_cartBloc.state as CartLoaded).cart,
        address: (_addressBloc.state as AddressLoadedSuccess).address,
        paymentMethod: (_paymentBloc.state as PaymentLoaded).paymentMethod,
      ));
    }

    if (state is CheckoutLoaded) {
      final state = this.state as CheckoutLoaded;
      emit(CheckoutLoaded(
        cart: event.cart ?? state.cart,
        address: event.address ?? state.address,
        paymentMethod: event.paymentMethod ?? state.paymentMethod,
      ));
    }
  }

  void _onCheckoutConfirmed(
      CheckoutConfirmed event, Emitter<CheckoutState> emit) {}

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    _addressSubscription?.cancel();
    _paymentSubscription?.cancel();
    return super.close();
  }
}
