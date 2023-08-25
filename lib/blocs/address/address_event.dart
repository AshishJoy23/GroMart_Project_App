part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class AddressLoaded extends AddressEvent { 
  final String email;
  const AddressLoaded({required this.email});

  @override
  List<Object> get props => [email];
}

class AddressUpdated extends AddressEvent {
  final  List<AddressModel> addresses;

  const AddressUpdated(this.addresses);

  @override
  List<Object> get props => [addresses];
}

class AddressAdded extends AddressEvent {
  final String email;
  final AddressModel address;

  const AddressAdded({required this.email,required this.address});

  @override
  List<Object> get props => [email,address];
}

class AddressEdited extends AddressEvent {
  final String email;
  final AddressModel address;

  const AddressEdited({required this.email,required this.address});

  @override
  List<Object> get props => [email,address];
}

class AddressDeleted extends AddressEvent {
  final String email;
  final String addressId;

  const AddressDeleted({required this.email,required this.addressId});

  @override
  List<Object> get props => [email,addressId];
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

