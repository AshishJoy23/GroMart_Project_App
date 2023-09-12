import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/repositories/cart/cart_repository.dart';
import 'package:gromart_project/repositories/order/order_repository.dart';

part 'order_confirm_event.dart';
part 'order_confirm_state.dart';

class OrderConfirmBloc extends Bloc<OrderConfirmEvent, OrderConfirmState> {
  final OrderRepository _orderRepository;
  final CartRepository _cartRepository;
  OrderConfirmBloc({required OrderRepository orderRepository,required CartRepository cartRepository,})
      : _orderRepository = orderRepository,
        _cartRepository = cartRepository,
        super(OrderConfirmLoading()) {
    on<OrderConfirmed>(_onOrderConfirmed);
  }

  void _onOrderConfirmed(OrderConfirmed event, Emitter<OrderConfirmState> emit) async{
    log('<<<<<<<<<confirn=med  order>>>>>>>>>');
    log(event.order.toString());
    try {
      emit(
        OrderConfirmLoaded(order: event.order)
      );
      log('<<<<<<before [plACING ORD]>>>>>>');
      await _orderRepository.placeOrder(
          event.email, event.order.id, event.order);
      await _cartRepository.updateCartProducts(
          event.email, event.cart.id, event.cart);
      log('order updated succcessfully');
      log('cart updated succcessfully');
    } catch (e) {
      log('Something went wrong: $e');
    }
  }
}
