import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
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
  }

  void _onLoadCart(LoadCart event, Emitter<CartState> emit) {
    _cartSubscription?.cancel();
    _cartSubscription =
        _cartRepository.getCartProducts(event.email).listen((cart) {
      log('getting cart products');
      log(cart.toString());
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
        log('<<<<load event>>>>');
        log(newCart.toString());
        _cartRepository.updateCartProducts(cart.id, newCart);
        add(UpdateCart(newCart));
        // _cartSubscription?.cancel();
        // _cartSubscription = _cartRepository
        //     .getCartProducts(event.email)
        //     .listen((cart) => add(UpdateCart(newCart)));
      } else {
        add(UpdateCart(cart));
      }
    });
  }

  void _onUpdateCart(UpdateCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    log('<<<<<<<<<<<<<<<<<<<update event>>>>>>>>>>>>>>>>>');
    log(event.cart.id);
    log(event.cart.productsMap.toString());
    log(event.cart.subTotal.toString());
    log(event.cart.grandTotal.toString());
    log(event.cart.deliveryFee.toString());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(
        CartLoaded(
          cart: event.cart,
        ),
      );
    } catch (_) {
      emit(CartError());
      const Text('Something went wrong');
    }
  }

  void _cartProductAdded(CartProductAdded event, Emitter<CartState> emit) async{
    //emit(CartLoading());
    final state = this.state;
    if (state is CartLoaded) {
      // ProductModel? productToUpdate;
      // state.cart.productsMap.forEach((product, quantity) {
      //   if (product == event.product) {
      //     productToUpdate = product;
      //   }
      // });
      // if (productToUpdate != null) {
      //   state.cart.productsMap[productToUpdate!] =
      //       (state.cart.productsMap[productToUpdate!] ?? 0) + 1;
      // } else {
      //   state.cart.productsMap[event.product] = 1;
      // }
      log(state.cart.productsMap.toString());
      state.cart.productsMap.update(
        event.product,
        (quantity) => quantity + 1,
        ifAbsent: () => 1,
      );
      log(state.cart.productsMap.keys.toString());
      log(state.cart.productsMap[event.product].toString());
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

  void _cartProductRemoved(CartProductRemoved event, Emitter<CartState> emit) {}
}
