import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/repositories/wishlist/wishlist_repository.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepository _wishlistRepository;
  StreamSubscription? _wishlistSubscription;
  WishlistBloc({required WishlistRepository wishlistRepository})
      : _wishlistRepository = wishlistRepository,
        super(WishlistLoading()) {
    on<WishListGetLoaded>(_onWishListGetLoaded);
    on<WishlistUpdated>(_onWishlistUpdated);
    on<AddToWishlist>(_onAddToWishlist);
    on<RemoveFromWishlist>(_onRemoveFromWishlist);
  }

  void _onWishListGetLoaded(
      WishListGetLoaded event, Emitter<WishlistState> emit) {
    log('<<<<<<<<<wishlist bloc code>>>>>>>>>');
    _wishlistSubscription?.cancel();
    _wishlistSubscription =
        _wishlistRepository.getProducts(event.email).listen((wishlist) {
      if (wishlist.isEmpty) {
        log('<<<<<<<<inside if wishlist>>>>>>>>');
        log(event.email);
        final wishlist = FirebaseFirestore.instance
            .collection('users')
            .doc(event.email)
            .collection('wishlist')
            .doc();
        WishlistModel newWishlist = WishlistModel(
          id: wishlist.id,
          productList: const [],
        );
        log(newWishlist.toString());
        _wishlistRepository.updateWishlistProducts(
            event.email, wishlist.id, newWishlist);
        add(WishlistUpdated(newWishlist));
      } else {
        log('<<<<<<<<<<<inside else wishlist>>>>>>>>>>>');
        log(event.email);
        log(wishlist.toString());
        add(
          WishlistUpdated(wishlist.first),
        );
      }
    });
  }

  void _onWishlistUpdated(
      WishlistUpdated event, Emitter<WishlistState> emit) async {
    //emit(WishlistLoading());
    try {
      //await Future<void>.delayed(const Duration(seconds: 1));
      emit(
        WishlistLoaded(
          wishlist: event.wishlist,
        ),
      );
      log('wishlist updated successfully');
    } catch (e) {
      log('Something went wrong: $e');
    }
  }

  void _onAddToWishlist(
      AddToWishlist event, Emitter<WishlistState> emit) async {
    try {
      final state = this.state;
      if (state is WishlistLoaded) {
        final List<int> updatedList = state.wishlist.productList;
        updatedList.add(event.productId);
        WishlistModel updatedWishlist = WishlistModel(
          id: state.wishlist.id,
          productList: updatedList,
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
        final List<int> updatedList = state.wishlist.productList;
        updatedList.remove(event.productId);
        WishlistModel updatedWishlist = WishlistModel(
          id: state.wishlist.id,
          productList: updatedList,
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
