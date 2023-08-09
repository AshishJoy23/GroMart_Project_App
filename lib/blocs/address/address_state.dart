part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class AddressLoading extends AddressState {}

class AddressLoadedSuccess extends AddressState {
  final List<AddressModel> addresses;
  final String addressType;
  final int selectedIndex;

  const AddressLoadedSuccess({
    this.addresses = const <AddressModel>[],
    this.addressType = '',
    this.selectedIndex = 0,
  });

  @override
  List<Object> get props => [
        addresses,
        addressType,
        selectedIndex,
      ];
}

class AddressLoadedError extends AddressState {}
