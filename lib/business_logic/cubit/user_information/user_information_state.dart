part of 'user_information_cubit.dart';

@immutable
abstract class UserInformationState {}

class UserInformationInitial extends UserInformationState {}
class UserInformationSubmitting extends UserInformationState {}

class UserInformationSuccess extends UserInformationState {}

class UserInformationFailure extends UserInformationState {
  final Exception exception;

  UserInformationFailure({required this.exception});
}
