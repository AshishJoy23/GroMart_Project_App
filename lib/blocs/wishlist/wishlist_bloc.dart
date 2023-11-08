import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/repositories/wishlist/wishlist_repository.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepository _wishlistRepository;
  WishlistBloc({required WishlistRepository wishlistRepository})
      : _wishlistRepository = wishlistRepository,
        super(WishlistLoading()) {
    on<WishListGetLoaded>(_onWishListGetLoaded);
    on<AddToWishlist>(_onAddToWishlist);
    on<RemoveFromWishlist>(_onRemoveFromWishlist);
  }
  
  void _onWishListGetLoaded(
      WishListGetLoaded event, Emitter<WishlistState> emit) async {
    log('<<<<<<<<<wishlist bloc code>>>>>>>>>');

    //emit(WishlistLoading());
    try {
      WishlistModel wishlist =
          await _wishlistRepository.getProducts(event.email);
      log(wishlist.toString());
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(
        WishlistLoaded(
          wishlist: wishlist,
        ),
      );
      log('wishlist loaded successfully');
    } catch (e) {
      log('Something went wrong: $e');
    }
  }

  void _onAddToWishlist(
      AddToWishlist event, Emitter<WishlistState> emit) async {
    try {
      final state = this.state;
      if (state is WishlistLoaded) {
        WishlistModel updatedWishlist = WishlistModel(
          id: state.wishlist.id,
          productList: List.from(state.wishlist.productList)
            ..add(event.productId),
        );
        emit(
          WishlistLoaded(
            wishlist: updatedWishlist,
          ),
        );
        _wishlistRepository.updateWishlistProducts(
            event.email, state.wishlist.id, updatedWishlist);
      }
      log('added to wishlist successfully');
    } catch (e) {
      log('Something went wrong: $e');
    }
  }

  void _onRemoveFromWishlist(
      RemoveFromWishlist event, Emitter<WishlistState> emit) {
    try {
      final state = this.state;
      if (state is WishlistLoaded) {
        WishlistModel updatedWishlist = WishlistModel(
          id: state.wishlist.id,
          productList: List.from(state.wishlist.productList)
            ..remove(event.productId),
        );
        emit(
          WishlistLoaded(
            wishlist: updatedWishlist,
          ),
        );
        _wishlistRepository.updateWishlistProducts(
            event.email, state.wishlist.id, updatedWishlist);
      }
      log('removed from wishlist successfully');
    } catch (e) {
      log('Something went wrong: $e');
    }
  }
}
