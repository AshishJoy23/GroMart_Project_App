import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/repositories/profile/base_profile_repo.dart';
import 'package:image_picker/image_picker.dart';

class ProfileRepository extends BaseProfileRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProfileRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

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
      return const ProfileModel(userName: '', userEmail: '');
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

  Future<void> uploadProfilePhoto(XFile image) async {
    try {
      final folderRef = storage.ref('profile_photos'); // Replace with your folder name
    
    // List all items (files and subfolders) in the folder
    final firebase_storage.ListResult result = await folderRef.listAll();

    // Delete each file in the folder
    for (final ref in result.items) {
      await ref.delete();
      log('Deleted ${ref.fullPath}');
    }
      await storage
          .ref('profile_photos/${image.name}')
          .putFile(File(image.path));
      log('image uploaded successfully');
    } catch (e) {
      log('Error while uploading product image: $e');
    }
  }

  Future<String> getProfilePhotoURL(String imageName) async {
    try {
      String downloadURL =
          await storage.ref('profile_photos/$imageName').getDownloadURL();
      log('image gets successfully');
      return downloadURL;
    } catch (e) {
      log('Error while getting product image: $e');
    }
    return '';
  }
}
