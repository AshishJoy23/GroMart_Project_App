import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/repositories/address/base_address_repo.dart';

class AddressRepository extends BaseAddressRepository {
  final FirebaseFirestore _firebaseFirestore;

  AddressRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<AddressModel>> getAllAddresses() {
    return _firebaseFirestore
        .collection('addresses')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AddressModel.fromSnapshot(doc))
          .toList();
    });
  }

  @override
  Future<void> updateAddress(String addressId, AddressModel address) async{
    try {
      await _firebaseFirestore.collection('addresses').doc(addressId).set(
            address.toMap(),
            SetOptions(merge: true),
          );
      log('address updated successfully.');
    } catch (error) {
      log('Error updating address: $error');
    }
  }

  
  @override
  Future<void> deleteAddress(String addressId) async{
    try {
      await _firebaseFirestore.collection('addresses').doc(addressId).delete();
      log('address deleted successfully.');
    } catch (error) {
      log('Error deleting address: $error');
    }
  }
  
  
  
  
}
