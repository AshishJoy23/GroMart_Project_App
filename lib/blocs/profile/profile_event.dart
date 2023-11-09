part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileGetLoaded extends ProfileEvent {
  final String email;

  const ProfileGetLoaded({required this.email});
  @override
  List<Object> get props => [email];
}

class ProfileUpdated extends ProfileEvent {
  final ProfileModel newProfile;

  const ProfileUpdated({required this.newProfile});

  @override
  List<Object> get props => [newProfile];
}

class ProfilePictureUploaded extends ProfileEvent {

  const ProfilePictureUploaded();

  @override
  List<Object> get props => [];
}