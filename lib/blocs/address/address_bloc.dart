import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/repositories/address/address_repository.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository _addressRepository;
  StreamSubscription? _addressSubscription;
  AddressBloc({required AddressRepository addressRepository})
      : _addressRepository = addressRepository,
        super(AddressLoading()) {
    on<AddressLoaded>(_onAddressLoaded);
    on<AddressUpdated>(_onAddressUpdated);
    on<AddressAdded>(_onAddressAdded);
    on<AddressEdited>(_onAddressEdited);
    on<AddressDeleted>(_onAddressDeleted);
  }

  void _onAddressLoaded(AddressLoaded event, Emitter<AddressState> emit) {
  }

  void _onAddressUpdated(AddressUpdated event, Emitter<AddressState> emit) {
  }

  void _onAddressAdded(AddressAdded event, Emitter<AddressState> emit) {
  }

  void _onAddressEdited(AddressEdited event, Emitter<AddressState> emit) {
  }

  void _onAddressDeleted(AddressDeleted event, Emitter<AddressState> emit) {
  }
}
