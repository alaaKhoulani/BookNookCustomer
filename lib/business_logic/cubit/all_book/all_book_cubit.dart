import 'package:bloc/bloc.dart';
import 'package:book_nook_user/data/models/Book.dart';
import 'package:book_nook_user/data/repository/book_repository.dart';
import 'package:book_nook_user/data/web_services/book_web_services.dart';
import 'package:meta/meta.dart';

part 'all_book_state.dart';

class AllBookCubit extends Cubit<TopRatedBookState> {
  AllBookCubit() : super(AllBookInitial());
  BookRepository _bookREpository = BookRepository(BookWebServices());
  late List<BookInfo> topRatedBooksList;

  Future<List<BookInfo>> getTopRatedBooks() async {
    try {
      emit(TopRatedBookLoading());
      await _bookREpository.getTopRAtedBooks().then((allBooks) => {
            // print("Hiiiiiiiiiiiiii All Books cubit"),
            // print(allBooks),
            emit(TopRatedBookSuccessful(allBooks)),
            this.topRatedBooksList = allBooks
          });
      return this.topRatedBooksList;
    } catch (e) {
      return [];
    }
    // return allBooksList;
  }
}
