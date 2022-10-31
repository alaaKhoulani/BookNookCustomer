part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileSubmitting extends ProfileState {}

class ProfileSuccess extends ProfileState {
  User admin;
  ProfileSuccess({required this.admin});
}

class ProfileFailure extends ProfileState {
  final Exception exception;

  ProfileFailure({required this.exception});
}
