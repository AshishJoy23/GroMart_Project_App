import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/repositories/profile/base_profile_repo.dart';

class ProfileRepository extends BaseProfileRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProfileRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<ProfileModel> getProfileData(String email) async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection('users')
          .doc(email)
          .collection('profile')
          .get();

      
        final documentSnapshot = querySnapshot.docs[0];
        return ProfileModel.fromSnapshot(documentSnapshot);
      
    } catch (e) {
      log('error updating wishlist: $e');
      return const ProfileModel(userName: '',userEmail: '');
    }
  }

  @override
  Future<void> updateProfileData(
      String email, String profileId, ProfileModel newProfile) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(email)
          .collection('profile')
          .doc(profileId)
          .set(newProfile.toMap(), SetOptions(merge: true));
      log('wishlist updated successfully');
    } catch (e) {
      log('error updating wishlist: $e');
    }
  }
}
