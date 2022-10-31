part of 'library_cubit.dart';

@immutable
abstract class LibraryState {}

class LibraryInitial extends LibraryState {}

class LibraryLoading extends LibraryState {}

class LibrarySuccessfull extends LibraryState {
  final LibraryProfile libraryProfile;

  LibrarySuccessfull(this.libraryProfile);
}


