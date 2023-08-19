import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/repositories/address/address_repository.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository _addressRepository;
  StreamSubscription? _addressSubscription;
  String addressType = 'Home';
  int selectedIndex = 0;
  AddressBloc({required AddressRepository addressRepository})
      : _addressRepository = addressRepository,
        super(AddressLoading()) {
    on<AddressLoaded>(_onAddressLoaded);
    on<AddressUpdated>(_onAddressUpdated);
    on<AddressAdded>(_onAddressAdded);
    on<AddressEdited>(_onAddressEdited);
    on<AddressDeleted>(_onAddressDeleted);
    on<AddressTypeButtonClicked>(_onAddressTypeButtonClicked);
    on<AddressCardSelected>(_onAddressCardSelected);
  }

  void _onAddressLoaded(AddressLoaded event, Emitter<AddressState> emit) {
    _addressSubscription?.cancel();
    _addressSubscription =
        _addressRepository.getAllAddresses().listen((addresses) {
      if (addresses.isEmpty) {
        add(const AddressUpdated([]));
      } else {
        add(AddressUpdated(addresses));
      }
    });
  }

  void _onAddressUpdated(
      AddressUpdated event, Emitter<AddressState> emit) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      emit(
        AddressLoadedSuccess(
          addresses: event.addresses,
          address:
              event.addresses.isEmpty ? null : event.addresses[selectedIndex],
          addressType: addressType,
          selectedIndex: selectedIndex,
        ),
      );
    } catch (e) {
      emit(AddressLoadedError());
      const Text('Something went wrong');
      log('Error: $e');
    }
  }

  void _onAddressAdded(AddressAdded event, Emitter<AddressState> emit) async {
    final address = FirebaseFirestore.instance.collection('addresses').doc();
    try {
      final AddressModel newAddress = AddressModel(
        id: address.id,
        name: event.address.name,
        phone: event.address.phone,
        house: event.address.house,
        street: event.address.street,
        city: event.address.city,
        state: event.address.state,
        pincode: event.address.pincode,
        type: event.address.type,
      );
      await _addressRepository.updateAddress(address.id, newAddress);
      final state = this.state;
      if (state is AddressLoadedSuccess) {
        selectedIndex =
            state.addresses.indexWhere((address) => address == newAddress);
        emit(AddressLoadedSuccess(
          addresses: state.addresses,
          address: newAddress,
          addressType: addressType,
          selectedIndex: selectedIndex,
        ));
      }
    } catch (e) {
      emit(AddressLoadedError());
      const Text('Something went wrong');
      log('Error: $e');
    }
  }

  void _onAddressEdited(AddressEdited event, Emitter<AddressState> emit) async {
    try {
      final AddressModel newAddress = AddressModel(
        id: event.address.id,
        name: event.address.name,
        phone: event.address.phone,
        house: event.address.house,
        street: event.address.street,
        city: event.address.city,
        state: event.address.state,
        pincode: event.address.pincode,
        type: event.address.type,
      );
      await _addressRepository.updateAddress(event.address.id, newAddress);
    } catch (e) {
      emit(AddressLoadedError());
      const Text('Something went wrong');
      log('Error: $e');
    }
  }

  void _onAddressDeleted(
      AddressDeleted event, Emitter<AddressState> emit) async {
    try {
      await _addressRepository.deleteAddress(event.addressId);
    } catch (e) {
      emit(AddressLoadedError());
      const Text('Something went wrong');
      log('Error: $e');
    }
  }

  void _onAddressTypeButtonClicked(
      AddressTypeButtonClicked event, Emitter<AddressState> emit) {
    final state = this.state;
    try {
      if (state is AddressLoadedSuccess) {
        addressType = event.addressType;
        emit(AddressLoadedSuccess(
          addresses: state.addresses,
          address: state.address,
          addressType: addressType,
          selectedIndex: selectedIndex,
        ));
      }
    } catch (e) {
      emit(AddressLoadedError());
      const Text('Something went wrong');
      log('Error: $e');
    }
  }

  void _onAddressCardSelected(
      AddressCardSelected event, Emitter<AddressState> emit) {
    final state = this.state;
    try {
      if (state is AddressLoadedSuccess) {
        selectedIndex = event.index;
        emit(AddressLoadedSuccess(
          addresses: state.addresses,
          address: state.addresses[selectedIndex],
          addressType: addressType,
          selectedIndex: selectedIndex,
        ));
      }
    } catch (e) {
      emit(AddressLoadedError());
      const Text('Something went wrong');
      log('Error: $e');
    }
  }
}
