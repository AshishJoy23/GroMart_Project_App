import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/repositories/profile/profile_repository.dart';
import 'package:gromart_project/view/config/config.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;
  String profilePhotoUrl = '';
  String selectedGender = 'Select One';
  ProfileBloc({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(ProfileLoading()) {
    on<ProfileGetLoaded>(_onProfileGetLoaded);
    on<ProfileUpdated>(_onProfileUpdated);
    on<ProfilePictureUploaded>(_onProfilePictureUploaded);
  }

  void _onProfileGetLoaded(
      ProfileGetLoaded event, Emitter<ProfileState> emit) async {
    log('<<<<<<<<<Profile bloc code>>>>>>>>>');

    //emit(ProfileLoading());
    try {
      ProfileModel profile =
          await _profileRepository.getProfileData(event.email);
      log(profile.toString());
      await Future<void>.delayed(const Duration(seconds: 1));
      profilePhotoUrl = profile.userImageUrl;
          selectedGender = profile.userGender;
      emit(
        ProfileLoaded(
          profilePhotoUrl: profilePhotoUrl,
          selectedGender: selectedGender,
          profile: profile,
        ),
      );
      log('Profile loaded successfully');
    } catch (e) {
      log('Something went wrong: $e');
    }
  }

  void _onProfileUpdated(
      ProfileUpdated event, Emitter<ProfileState> emit) async {
    try {
      log(event.newProfile.toString());
      profilePhotoUrl = event.newProfile.userImageUrl;
      selectedGender = event.newProfile.userGender;
      emit(
        ProfileLoaded(
          profilePhotoUrl: profilePhotoUrl,
          selectedGender: selectedGender,
          profile: event.newProfile,
        ),
      );
      await _profileRepository.updateProfileData(
          event.newProfile.userEmail, event.newProfile.id, event.newProfile);
      log('Profile updated successfully');
    } catch (e) {
      log('Something went wrong: $e');
    }
  }

  void _onProfilePictureUploaded(
      ProfilePictureUploaded event, Emitter<ProfileState> emit) async {
    try {
      final state = this.state;
      if (state is ProfileLoaded) {
        ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(
          source: ImageSource.gallery,
        );
        if (image == null) {
          Utils.showSnackBar('No image was selected..', Colors.black87);
        }
        if (image != null) {
          await _profileRepository.uploadProfilePhoto(image);
          var imageUrl =
              await _profileRepository.getProfilePhotoURL(image.name);
          profilePhotoUrl = imageUrl;
          selectedGender = state.profile.userGender;
          ProfileModel updatedProfile = ProfileModel(
            id: state.profile.id,
            userName: state.profile.userName,
            userEmail: state.profile.userEmail,
            userPhone: state.profile.userPhone,
            userGender: state.profile.userGender,
            userDob: state.profile.userDob,
            userImageUrl: imageUrl,
          );
          emit(
            ProfileLoaded(
              profilePhotoUrl: profilePhotoUrl,
              selectedGender: selectedGender,
              profile: updatedProfile,
            ),
          );
          await _profileRepository.updateProfileData(
              updatedProfile.userEmail, updatedProfile.id, updatedProfile);
        }
      }

      log('Profile photo updated successfully');
    } catch (e) {
      log('Something went wrong: $e');
    }
  }
}
