import 'package:gromart_project/models/models.dart';

abstract class BaseAddressRepository {
  Stream<List<AddressModel>> getAllAddresses(String email);
  Future<void> updateAddress(String email,String addressId,AddressModel address);
  Future<void> deleteAddress(String email,String addressId);
}