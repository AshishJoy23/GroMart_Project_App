import 'package:gromart_project/models/models.dart';

abstract class BaseProfileRepository {
  Future<ProfileModel>  getProfileData(String email);
  Future<void> updateProfileData(String email,String profileId,ProfileModel newProfile);
}