import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/repositories/cart/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;
  StreamSubscription? _cartSubscription;
  CartBloc({required CartRepository cartRepository})
      : _cartRepository = cartRepository,
        super(CartLoading()) {
    on<LoadCart>(_onLoadCart);
    on<UpdateCart>(_onUpdateCart);
    on<CartProductAdded>(_cartProductAdded);
    on<CartProductRemoved>(_cartProductRemoved);
    on<CartProductDeleted>(_cartProductDeleted);
  }

  void _onLoadCart(LoadCart event, Emitter<CartState> emit) {
    _cartSubscription?.cancel();
    _cartSubscription =
        _cartRepository.getCartProducts(event.email).listen((cart) {
      if (cart == null) {
        final cart = FirebaseFirestore.instance.collection('carts').doc();
        final CartModel newCart = CartModel(
          id: cart.id,
          productsMap: const {},
          userEmail: event.email,
          subTotal: 0,
          deliveryFee: 0,
          grandTotal: 0,
        );
        _cartRepository.updateCartProducts(cart.id, newCart);
        add(UpdateCart(newCart));
      } else {
        add(UpdateCart(cart));
      }
    });
  }

  void _onUpdateCart(UpdateCart event, Emitter<CartState> emit) async {
    //emit(CartLoading());
    try {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      emit(
        CartLoaded(
          cart: event.cart,
        ),
      );
    } catch (e) {
      emit(CartError());
      const Text('Something went wrong');
      log('Error: $e');
    }
  }

  void _cartProductAdded(
      CartProductAdded event, Emitter<CartState> emit) async {
    //emit(CartLoading());
    final state = this.state;
    if (state is CartLoaded) {
      state.cart.productsMap.update(
        event.product,
        (quantity) => quantity + 1,
        ifAbsent: () => 1,
      );
      final CartModel newCart = CartModel(
        id: state.cart.id,
        productsMap: state.cart.productsMap,
        userEmail: state.cart.userEmail,
        subTotal: state.cart.subTotals,
        deliveryFee: state.cart.deliveryFees(state.cart.subTotals),
        grandTotal: state.cart.totalAmount(state.cart.subTotals,
            state.cart.deliveryFees(state.cart.subTotals)),
      );
      try {
        emit(
          CartLoaded(cart: newCart),
        );
        await _cartRepository.updateCartProducts(state.cart.id, newCart);
      } catch (e) {
        emit(CartError());
        const Text('Something went wrong');
      }
    }
  }

  void _cartProductRemoved(
      CartProductRemoved event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      state.cart.productsMap.update(
        event.product,
        (quantity) => quantity - 1,
      );
      final CartModel newCart = CartModel(
        id: state.cart.id,
        productsMap: state.cart.productsMap,
        userEmail: state.cart.userEmail,
        subTotal: state.cart.subTotals,
        deliveryFee: state.cart.deliveryFees(state.cart.subTotals),
        grandTotal: state.cart.totalAmount(state.cart.subTotals,
            state.cart.deliveryFees(state.cart.subTotals)),
      );
      try {
        emit(
          CartLoaded(cart: newCart),
        );
        await _cartRepository.updateCartProducts(state.cart.id, newCart);
      } catch (e) {
        emit(CartError());
        const Text('Something went wrong');
      }
    }
  }

  void _cartProductDeleted(
      CartProductDeleted event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      if (state.cart.productsMap.containsKey(event.product)) {
        state.cart.productsMap.remove(event.product);
      } else {
        log('The product does not exist in the cart.');
        return; // Exit the function if the product does not exist.
      }
      final CartModel newCart = CartModel(
        id: state.cart.id,
        productsMap: state.cart.productsMap,
        userEmail: state.cart.userEmail,
        subTotal: state.cart.subTotals,
        deliveryFee: state.cart.deliveryFees(state.cart.subTotals),
        grandTotal: state.cart.totalAmount(state.cart.subTotals,
            state.cart.deliveryFees(state.cart.subTotals)),
      );
      try {
        emit(
          CartLoaded(cart: newCart),
        );
       _cartRepository.deleteCartProducts(state.cart.id, newCart);
      } catch (e) {
        emit(CartError());
        const Text('Something went wrong');
      }
    }
  }
}
