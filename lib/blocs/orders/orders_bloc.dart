import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/repositories/order/order_repository.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderRepository _orderRepository;
  StreamSubscription? _orderSubscription;
  OrdersBloc({required OrderRepository orderRepository})
      : _orderRepository = orderRepository,
        super(OrdersLoading()) {
    on<OrdersGetLoaded>(_onOrdersGetLoaded);
    on<OrdersUpdated>(_onOrdersUpdated);
    on<OrderCancelled>(_onOrderCancelled);
  }

  void _onOrdersGetLoaded(OrdersGetLoaded event, Emitter<OrdersState> emit) {
    _orderSubscription?.cancel();
    _orderSubscription = _orderRepository.getAllOrders(event.email).listen(
          (orders) => add(
            OrdersUpdated(orders),
          ),
        );
  }

  void _onOrdersUpdated(OrdersUpdated event, Emitter<OrdersState> emit) async {
    log('<<<<<<<order  update event>>>>>>>');
    log('//\\\\\\\\\\\\\\/////////////');
   //emit(OrdersLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      log('<<<<<<<<<<inside else update event>>>>>>>>>>');
        emit(
          OrdersLoaded(
            orders: event.orders,
          ),
        );
      // Create a copy of the current state with the new order added
      // if (state is OrdersLoaded) {
      //   log('<<<<<<<<<<inside if update event>>>>>>>>>>');
      //   final currentState = state as OrdersLoaded;
      //   log(currentState.orders.length.toString());
      //   log(currentState.order.toString());
      //   final updatedState = currentState.copyWith(
      //     orders: event.orders, // Update the order parameter
      //   );
      //   log(updatedState.orders.length.toString());
      //   log(updatedState.order.toString());
      //   log('<<<<<beore emittimg>>>>>');
      //   emit(updatedState);
      // } else {
      //   log('<<<<<<<<<<inside else update event>>>>>>>>>>');
      //   emit(
      //     OrdersLoaded(
      //       orders: event.orders,
      //     ),
      //   );
      // }
    } catch (e) {
      log('Something went wrong: $e');
    }
  }

  void _onOrderCancelled(OrderCancelled event, Emitter<OrdersState> emit) {}
}
