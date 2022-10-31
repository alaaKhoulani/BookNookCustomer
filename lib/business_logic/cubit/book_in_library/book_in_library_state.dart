part of 'book_in_library_cubit.dart';

@immutable
abstract class BookInLibraryState {}

class BookInLibraryInitial extends BookInLibraryState {}
class BookGetInLibraryInitial extends BookInLibraryState {}

class LibraryGetBooksSuccessful extends BookInLibraryState {
  final List<BookInfo> allBooks;

  LibraryGetBooksSuccessful(this.allBooks);
}
