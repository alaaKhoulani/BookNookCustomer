import 'package:bloc/bloc.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:book_nook_user/ui/Screens/savedBook/saved_book_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'borrowed_books_state.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'model.dart';

class BorrowedBooksCubit extends Cubit<BorrowedBooksStates> {
  BorrowedBooksCubit() : super(BorrowedBooksInitial());
  List purchasedBook = [
    {
      'title': 'Book1',
      'photo': 'assets/images/bookphoto1.png',
      'date': '12/5/2022',
      'lib name': 'library name',
      'price': '500\$',
    },
    {
      'title': 'Book2',
      'photo': 'assets/images/bookphoto2.png',
      'date': '12/6/2022',
      'lib name': 'library name',
      'price': '200\$',
    },
    {
      'title': 'Book3',
      'photo': 'assets/images/bookphoto3.png',
      'date': '12/7/2022',
      'lib name': 'library name',
      'price': '100\$',
    },
    {
      'title': 'Book4',
      'photo': 'assets/images/bookphoto4.png',
      'date': '12/8/2022',
      'lib name': 'library name',
      'price': '800\$',
    },
  ];
  List borrowedBooks = [
    {
      'title': 'Book1',
      'photo': 'assets/images/bookphoto1.png',
      'date': '12/5/2022',
      'day left': 2,
      'isdone': true,
      'lib name': 'library name',
    },
    {
      'title': 'Book2',
      'photo': 'assets/images/bookphoto2.png',
      'date': '21/6/2022',
      'day left': 7,
      'isdone': false,
      'lib name': 'library name',
    },
    {
      'title': 'Book3',
      'photo': 'assets/images/bookphoto3.png',
      'date': '1/7/2002',
      'day left': 0,
      'isdone': true,
      'lib name': 'library name',
    },
    {
      'title': 'Book4',
      'photo': 'assets/images/bookphoto4.png',
      'date': '22/7/2022',
      'day left': 20,
      'isdone': true,
      'lib name': 'library name',
    }
  ];
  static BorrowedBooksCubit get(context) => BlocProvider.of(context);
  var isSearched = false;
  var done = false;
  void startSearch() {
    isSearched = true;
    emit(BorrowedBooksStartSearch());
  }

  void stopSearch() {
    isSearched = false;
    emit(BorrowedBooksStopSearch());
  }

  List searchBorrowedBook = [];
  List searchpurchasedBook = [];
  void getResult(String booktitle) {
    searchBorrowedBook = borrowedBooks
        .where((book) => book['title'].toLowerCase().startsWith(booktitle))
        .toList();
    print(searchBorrowedBook);
    searchpurchasedBook = purchasedBook
        .where((book) => book['title'].toLowerCase().startsWith(booktitle))
        .toList();
    emit(BorrowedBooksStartSearch());
  }

  List bookinfoApi = [];
  List<Borrowed> BooksData = [];
  void getData() async {
    emit(BorrowedBooksInitial());
    await getBorrowBookApi();
    BooksData = [];
    bookinfoApi.forEach((val) {
      log("value:  $val");
      Borrowed data = Borrowed().fromJson1(val);
      BooksData.add(data);
    });
    print("ghfjkmdl");
    emit(BorrowedBooksGetData());
  }

  Future getBorrowBookApi() async {
    try {
      log('inside');
      var response = await http.get(
        // ignore: unnecessary_brace_in_string_interps
        Uri.parse("${Store.baseURL}/api/order/user_borrow"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Store.token}'
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        log('Request success with status: ${response.statusCode}.');
        log('${jsonResponse['data']}');
        bookinfoApi = jsonResponse['data'];
        // getData();
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
