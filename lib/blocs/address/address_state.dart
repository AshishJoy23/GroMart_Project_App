part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class AddressLoading extends AddressState {}

class AddressLoadedSuccess extends AddressState {
  final List<AddressModel> addresses;
  final String type;

  const AddressLoadedSuccess({
    this.addresses = const <AddressModel>[],
    this.type = 'Home',
  });

  @override
  List<Object> get props => [
        addresses,
        type,
      ];
}

class AddressLoadedError extends AddressState {}
