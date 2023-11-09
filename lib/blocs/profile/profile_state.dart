part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  String profilePhotoUrl;
  String selectedGender;
  ProfileModel profile;

  ProfileLoaded({
    this.profile = const ProfileModel(
      userEmail: '',
      userName: '',
    ),
    this.profilePhotoUrl = '',
    this.selectedGender = 'Select One',
  });

  @override
  List<Object> get props => [profile];
}

class ProfileError extends ProfileState {}
