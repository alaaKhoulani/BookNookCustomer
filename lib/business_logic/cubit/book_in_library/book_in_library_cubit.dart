import 'package:bloc/bloc.dart';
import 'package:book_nook_user/data/models/Book.dart';
import 'package:book_nook_user/data/repository/library_repository.dart';
import 'package:meta/meta.dart';

part 'book_in_library_state.dart';

class BookInLibraryCubit extends Cubit<BookInLibraryState> {
  BookInLibraryCubit() : super(BookInLibraryInitial());
  LibraryRepository _libraryRepository = LibraryRepository();

  //------------------- get books in library-------------------
  late List<BookInfo> allBooksList;

  Future<List<BookInfo>> getBooks({required int id}) async {
    try {
      emit(BookGetInLibraryInitial());
      await _libraryRepository.getBooks(id: id).then((allBooks) =>
          {emit(LibraryGetBooksSuccessful(allBooks)), allBooksList = allBooks});
      print("==============");
      print(this.allBooksList.length);
      return this.allBooksList;
    } catch (e) {
      return [];
    }
    // return allBooksList;
  }
}
