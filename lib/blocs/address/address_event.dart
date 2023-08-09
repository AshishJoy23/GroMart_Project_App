part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class AddressLoaded extends AddressEvent { 
  const AddressLoaded();

  @override
  List<Object> get props => [];
}

class AddressUpdated extends AddressEvent {
  final  List<AddressModel> addresses;

  const AddressUpdated(this.addresses);

  @override
  List<Object> get props => [addresses];
}

class AddressAdded extends AddressEvent {
  final AddressModel address;

  const AddressAdded(this.address);

  @override
  List<Object> get props => [address];
}

class AddressEdited extends AddressEvent {
  final AddressModel address;

  const AddressEdited(this.address);

  @override
  List<Object> get props => [address];
}

class AddressDeleted extends AddressEvent {
  final String addressId;

  const AddressDeleted(this.addressId);

  @override
  List<Object> get props => [addressId];
}

class AddressTypeButtonClicked extends AddressEvent {
  final String addressType;

  const AddressTypeButtonClicked(this.addressType);

  @override
  List<Object> get props => [addressType];
}

class AddressCardSelected extends AddressEvent {
  final int index;

  const AddressCardSelected(this.index);

  @override
  List<Object> get props => [index];
}

