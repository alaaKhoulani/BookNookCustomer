import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:book_nook_user/data/models/Book.dart';
import 'package:book_nook_user/data/repository/book_repository.dart';
import 'package:book_nook_user/data/web_services/book_web_services.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  BookRepository _bookRepository = BookRepository(BookWebServices());
  HomePageCubit() : super(HomePageInitial());
  List<BookInfo> allBooks = <BookInfo>[];
  List<BookInfo> allBooksCat = <BookInfo>[];
  int selectedCategory = 0;
  int selectedScreen = 2;
  void changePage(int value) {
    this.selectedScreen = value;
    emit(ChangePage(selectedScreen));
  }

  Future<List<BookInfo>> getBooksInCategory({required int id}) async {
    try {
      emit(HomePageInitial());
      print("HomePageInitial");
      this.allBooksCat.clear();
      this.allBooksCat = await _bookRepository.getBooksInCAtegory(id: id);

      emit(HomePageISuccessfull(this.allBooksCat));
      print("HomePageISuccessfull");
      return this.allBooksCat;
    } catch (e) {
      return [];
    }
  }

  Future<List<BookInfo>> getAllBooks() async {
    try {
      emit(HomePageInitial());
      print("HomePageInitial");
      this.allBooks.clear();
      this.allBooks = await _bookRepository.getAllBooks();
      print("cubittttttttttt");
      emit(HomePageISuccessfull(this.allBooks));
      print("HomePageISuccessfull");
      print(this.allBooks);
      return this.allBooks;
    } catch (e) {
      return [];
    }
  }
}
