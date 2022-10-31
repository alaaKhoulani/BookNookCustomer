import 'package:bloc/bloc.dart';
import 'package:book_nook_user/data/models/Book.dart';
import 'package:book_nook_user/data/repository/book_repository.dart';
import 'package:book_nook_user/data/web_services/book_web_services.dart';
import 'package:meta/meta.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());
  BookRepository _bookRepository = BookRepository(BookWebServices());

  Future<void> getBook({required int id}) async {
    try {
      emit(DetailsSubmitting());
      BookInfo book = await _bookRepository.getBook(id: id);
      if (book != null) {
        emit(DetailsSuccess(book));
        // return book;
      }
    } on Exception catch (e) {
      emit(DetailsFailure(exception: e));
      throw (Exception());
    }
  }
}
