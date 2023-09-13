import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/repositories/order/order_repository.dart';
import 'package:intl/intl.dart';

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
    emit(OrdersLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(
        OrdersLoaded(
          orders: event.orders,
        ),
      );
    } catch (e) {
      log('Something went wrong: $e');
    }
  }

  void _onOrderCancelled(
      OrderCancelled event, Emitter<OrdersState> emit) async {
    log('<<<<<<<order  cancel event>>>>>>>');
    try {
      int indexToUpdate = event.order.orderDetailsMap
          .indexWhere((order) => order['productId'] == event.productId);
      if (indexToUpdate != -1) {
        event.order.orderDetailsMap[indexToUpdate]['isCancelled'] = true;
        event.order.orderDetailsMap[indexToUpdate]['cancelledAt'] =
            DateFormat('MMM d, yyyy').format(DateTime.now());
      await _orderRepository.updateOrder(event.email, event.order);
      } else {
        // Handle the case where the target orderId was not found in the list
        log('Order with orderId ${event.productId} not found.');
      }
    } catch (e) {
      log('Something went wrong: $e');
    }
  }
}
