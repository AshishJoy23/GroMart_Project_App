import 'package:gromart_project/models/models.dart';

abstract class BaseAddressRepository {
  Stream<List<AddressModel>> getAllAddresses();
  Future<void> updateAddress(String addressId,AddressModel address);
  Future<void> deleteAddress(String addressId);
}