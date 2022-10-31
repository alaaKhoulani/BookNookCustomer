part of 'all_book_cubit.dart';

@immutable
abstract class TopRatedBookState {}

class AllBookInitial extends TopRatedBookState {}

class TopRatedBookSuccessful extends TopRatedBookState {
  final List<BookInfo> topRatedBooks;

  TopRatedBookSuccessful(this.topRatedBooks);
}

class TopRatedBookLoading extends TopRatedBookState {}

class TopRatedBookFailer extends TopRatedBookState {
  final Exception exception;

  TopRatedBookFailer({required this.exception});
}
