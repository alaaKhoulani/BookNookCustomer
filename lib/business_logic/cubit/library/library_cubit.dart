import 'package:bloc/bloc.dart';
import 'package:book_nook_user/data/models/Book.dart';
import 'package:book_nook_user/data/models/libraryProfile.dart';
import 'package:book_nook_user/data/repository/library_repository.dart';
import 'package:meta/meta.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit() : super(LibraryInitial());
  LibraryRepository _libraryRepository = LibraryRepository();

  Future<void> getLibraryInfo({required int id}) async {
    emit(LibraryLoading());
    // print("LibraryLoading");
    LibraryProfile libraryProfile =
        await _libraryRepository.getLibraryInfo(id: id);
    if (libraryProfile != null) {
      if (isClosed) return;
      emit(LibrarySuccessfull(libraryProfile));
      // print("LibrarySuccessfull");
    }
  }
}
