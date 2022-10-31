import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:book_nook_user/business_logic/cubit/all_book/all_book_cubit.dart';
import 'package:book_nook_user/business_logic/cubit/home_page/home_page_cubit.dart';
import 'package:book_nook_user/data/models/Book.dart';
import 'package:book_nook_user/ui/Screens/allLibrary/cubit.dart';
import 'package:book_nook_user/ui/Screens/search_user/sates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SearchCubit extends Cubit<SearchStates> {
  // List topBook = [
  //   {
  //     'photo': 'assets/images/bookphoto1.png',
  //     'title': 'book1',
  //     'author': 'author1'
  //   },
  //   {
  //     'photo': 'assets/images/bookphoto2.png',
  //     'title': 'book2',
  //     'author': 'author2'
  //   },
  //   {
  //     'photo': 'assets/images/bookphoto3.png',
  //     'title': 'book3',
  //     'author': 'author3'
  //   },
  //   {
  //     'photo': 'assets/images/bookphoto4.png',
  //     'title': 'book4',
  //     'author': 'author4'
  //   },
  // ];
  // List allBook = [
  //   {
  //     'photo': 'assets/images/bookphoto1.png',
  //     'title': 'book1',
  //     'author': 'author1'
  //   },
  //   {
  //     'photo': 'assets/images/bookphoto2.png',
  //     'title': 'book2',
  //     'author': 'author2'
  //   },
  //   {
  //     'photo': 'assets/images/bookphoto3.png',
  //     'title': 'book3',
  //     'author': 'author3'
  //   },
  //   {
  //     'photo': 'assets/images/bookphoto4.png',
  //     'title': 'book4',
  //     'author': 'author4'
  //   },
  // ];
  List<BookInfo> searchedBook = [];

  bool isSearched = false;
  SearchCubit() : super(Initial());
  List booksFromApi = HomePageCubit().allBooks;

  static SearchCubit get(context) => BlocProvider.of(context);

  void inSearchScreen() {
    getRecentApi();
    emit(Recent());
  }

  void delete(element) {
    recent.remove(element);
    emit(DeleteRecent());
  }

  void clearAll() {
    recent.clear();
    deleteRecentFromApi();
    emit(ClearAll());
  }

  List searchedLib = [];
  void addToSearchedList(String searchedCharacter) {
    // print(searchTextController.text);
    searchedBook = HomePageCubit()
        .allBooks
        .where((book) => book.name!.toLowerCase().startsWith(searchedCharacter))
        .toList();
    AllLibraryCubit().getAllLibraryApi();
    searchedLib = AllLibraryCubit()
        .allLibApi
        .where((lib) =>
            lib["library_name"].toLowerCase().startsWith(searchedCharacter))
        .toList();
    print(searchedCharacter);
    print("searchedBook:$searchedBook");
    print(searchedCharacter);
    print("searchedBook:$searchedBook");
    emit(StartSearch());
  }

  void startSearching() {
    isSearched = true;
    emit(StartSearch());
  }

  void stopSearching() {
    isSearched = false;
    getRecentApi();
    emit(StopSearch());
  }

  List topBook = [];
  void topBooks() {
    for (int i = 0, j = 0;
        i < booksFromApi.length && j < topBook.length;
        i++, j++) {
      topBook.add(booksFromApi[i]['name']);
      // topBook[i]['title'] = booksFromApi[i]['name'];
    }

    emit(TopBooks());
  }

  List<String> recent = [];
  List recentFromApi = [];
  void recents() {
    recent = [];
    recentFromApi.forEach((val) {
      recent.add(val['title']);
    });
    log("$recent");
    emit(Recent());
  }

  Future sendSearchtoApi({required String bookname}) async {
    try {
      log('inside');
      var response = await http.get(
        Uri.parse("http://192.168.137.136:8000/api/search/book/${bookname}"),
        headers: {
          'Accept': 'application/json',
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNmU3N2JmMGU1YTNiMzVkMGMwZDliZjViYjkyNjg4NGE3YTM2NDI4YzEyNjA0OTM1N2I1NzQ4NDc5ODk1ZmUyZGIyZjYzODg3YTI5OGU0YzkiLCJpYXQiOjE2NjAwMzQ4MTEuMDE5MDIzLCJuYmYiOjE2NjAwMzQ4MTEuMDE5MDQzLCJleHAiOjE2OTE1NzA4MTAuOTAxMjEyLCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.qv8Ru_vql-3kGYeLCWmhWjcXGQfmbY-kxPwb95IPWqeEkn0Jm8EXk0aDefkIlcA5PIZZHdoYNBEtuDQS7gPRatdsuNWpy7y7KGBGGSKb_grCRmk-ygnSsv9kftD8xf50e5GAcjm4zpSw6j8GLTBps08yN70nu4Pv2zkLumyeu0dFmTuT3wGC8sIEVTYCbZGHZ-WNftkyTQNZie_R-4wJ4MaAjjDXLteSh6g2JJn57k0Xui6WE-RldZskSjdNf44h3OypItAbSlOy_EcMG8GQe7ouVBOaW0D5ZV1iBOkIbfZl6Uq_GKxgo3Ms4j1jBpx_tWzfNS9DeUWxXzJOAJCxhgzMhSpoP6rS5juhdbC78rxtufYkys2-beTBPf_LDqv6AHBDXYXh5luodMl04sFSA47LYdaQyOs5K3PCm1mwtGbeGQMOD9iVXwZ1ptlCEwUKYs3tEc7ZezS7Z0n-3DkK04R3YmcEYpd1iBokXKsb9hiBFRQPgy-KAJlD7LKFbB6-mkOz3EYWtDzfHPRv-WFFfDJ662GYzJUpPBAzpozG11RBpUb_S4IpK9kFeNr0gAI33-no-OQuzfts0PMA7lXRysP9Y5RhmcsAoA19n8Awy-n_XZqxn8PElU7Wd1mv7VTjT9BejnGETD2KH5f6RYCstHR612BTW3k-8TstMF5mu2Q'
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        log('Request success with status: ${response.statusCode}.');
        log('${jsonResponse['data']}');
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future getRecentApi() async {
    try {
      log('inside');
      var response = await http.get(
          Uri.parse(
              "http://192.168.137.136:8000/api/search/books/recentSearches"),
          headers: {
            'Accept': 'application/json',
            'Authorization':
                'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNmU3N2JmMGU1YTNiMzVkMGMwZDliZjViYjkyNjg4NGE3YTM2NDI4YzEyNjA0OTM1N2I1NzQ4NDc5ODk1ZmUyZGIyZjYzODg3YTI5OGU0YzkiLCJpYXQiOjE2NjAwMzQ4MTEuMDE5MDIzLCJuYmYiOjE2NjAwMzQ4MTEuMDE5MDQzLCJleHAiOjE2OTE1NzA4MTAuOTAxMjEyLCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.qv8Ru_vql-3kGYeLCWmhWjcXGQfmbY-kxPwb95IPWqeEkn0Jm8EXk0aDefkIlcA5PIZZHdoYNBEtuDQS7gPRatdsuNWpy7y7KGBGGSKb_grCRmk-ygnSsv9kftD8xf50e5GAcjm4zpSw6j8GLTBps08yN70nu4Pv2zkLumyeu0dFmTuT3wGC8sIEVTYCbZGHZ-WNftkyTQNZie_R-4wJ4MaAjjDXLteSh6g2JJn57k0Xui6WE-RldZskSjdNf44h3OypItAbSlOy_EcMG8GQe7ouVBOaW0D5ZV1iBOkIbfZl6Uq_GKxgo3Ms4j1jBpx_tWzfNS9DeUWxXzJOAJCxhgzMhSpoP6rS5juhdbC78rxtufYkys2-beTBPf_LDqv6AHBDXYXh5luodMl04sFSA47LYdaQyOs5K3PCm1mwtGbeGQMOD9iVXwZ1ptlCEwUKYs3tEc7ZezS7Z0n-3DkK04R3YmcEYpd1iBokXKsb9hiBFRQPgy-KAJlD7LKFbB6-mkOz3EYWtDzfHPRv-WFFfDJ662GYzJUpPBAzpozG11RBpUb_S4IpK9kFeNr0gAI33-no-OQuzfts0PMA7lXRysP9Y5RhmcsAoA19n8Awy-n_XZqxn8PElU7Wd1mv7VTjT9BejnGETD2KH5f6RYCstHR612BTW3k-8TstMF5mu2Q'
          });

      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        log('Request success with status: ${response.statusCode}.');
        log('${jsonResponse['data']}');
        recentFromApi = jsonResponse['data'].toList();
        recents();
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future getTopBooksApi() async {
    try {
      log('inside Top');
      var response = await http.get(
          Uri.parse(
              "http://192.168.137.136:8000/api/search/books/mostSearched"),
          headers: {
            'Accept': 'application/json',
            'Authorization':
                'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNmU3N2JmMGU1YTNiMzVkMGMwZDliZjViYjkyNjg4NGE3YTM2NDI4YzEyNjA0OTM1N2I1NzQ4NDc5ODk1ZmUyZGIyZjYzODg3YTI5OGU0YzkiLCJpYXQiOjE2NjAwMzQ4MTEuMDE5MDIzLCJuYmYiOjE2NjAwMzQ4MTEuMDE5MDQzLCJleHAiOjE2OTE1NzA4MTAuOTAxMjEyLCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.qv8Ru_vql-3kGYeLCWmhWjcXGQfmbY-kxPwb95IPWqeEkn0Jm8EXk0aDefkIlcA5PIZZHdoYNBEtuDQS7gPRatdsuNWpy7y7KGBGGSKb_grCRmk-ygnSsv9kftD8xf50e5GAcjm4zpSw6j8GLTBps08yN70nu4Pv2zkLumyeu0dFmTuT3wGC8sIEVTYCbZGHZ-WNftkyTQNZie_R-4wJ4MaAjjDXLteSh6g2JJn57k0Xui6WE-RldZskSjdNf44h3OypItAbSlOy_EcMG8GQe7ouVBOaW0D5ZV1iBOkIbfZl6Uq_GKxgo3Ms4j1jBpx_tWzfNS9DeUWxXzJOAJCxhgzMhSpoP6rS5juhdbC78rxtufYkys2-beTBPf_LDqv6AHBDXYXh5luodMl04sFSA47LYdaQyOs5K3PCm1mwtGbeGQMOD9iVXwZ1ptlCEwUKYs3tEc7ZezS7Z0n-3DkK04R3YmcEYpd1iBokXKsb9hiBFRQPgy-KAJlD7LKFbB6-mkOz3EYWtDzfHPRv-WFFfDJ662GYzJUpPBAzpozG11RBpUb_S4IpK9kFeNr0gAI33-no-OQuzfts0PMA7lXRysP9Y5RhmcsAoA19n8Awy-n_XZqxn8PElU7Wd1mv7VTjT9BejnGETD2KH5f6RYCstHR612BTW3k-8TstMF5mu2Q'
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print("${jsonResponse['data']}");
        log('Request success with status: ${response.statusCode}.');
        booksFromApi = jsonResponse['data'].toList();
        topBooks();
        //log('$jsonResponse');
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future deleteRecentFromApi() async {
    try {
      log('inside delete');
      var response = await http.delete(
        Uri.parse(
            "http://192.168.137.136:8000/api/search/books/clearRecentSearches"),
        headers: {
          'Accept': 'application/json',
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNmU3N2JmMGU1YTNiMzVkMGMwZDliZjViYjkyNjg4NGE3YTM2NDI4YzEyNjA0OTM1N2I1NzQ4NDc5ODk1ZmUyZGIyZjYzODg3YTI5OGU0YzkiLCJpYXQiOjE2NjAwMzQ4MTEuMDE5MDIzLCJuYmYiOjE2NjAwMzQ4MTEuMDE5MDQzLCJleHAiOjE2OTE1NzA4MTAuOTAxMjEyLCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.qv8Ru_vql-3kGYeLCWmhWjcXGQfmbY-kxPwb95IPWqeEkn0Jm8EXk0aDefkIlcA5PIZZHdoYNBEtuDQS7gPRatdsuNWpy7y7KGBGGSKb_grCRmk-ygnSsv9kftD8xf50e5GAcjm4zpSw6j8GLTBps08yN70nu4Pv2zkLumyeu0dFmTuT3wGC8sIEVTYCbZGHZ-WNftkyTQNZie_R-4wJ4MaAjjDXLteSh6g2JJn57k0Xui6WE-RldZskSjdNf44h3OypItAbSlOy_EcMG8GQe7ouVBOaW0D5ZV1iBOkIbfZl6Uq_GKxgo3Ms4j1jBpx_tWzfNS9DeUWxXzJOAJCxhgzMhSpoP6rS5juhdbC78rxtufYkys2-beTBPf_LDqv6AHBDXYXh5luodMl04sFSA47LYdaQyOs5K3PCm1mwtGbeGQMOD9iVXwZ1ptlCEwUKYs3tEc7ZezS7Z0n-3DkK04R3YmcEYpd1iBokXKsb9hiBFRQPgy-KAJlD7LKFbB6-mkOz3EYWtDzfHPRv-WFFfDJ662GYzJUpPBAzpozG11RBpUb_S4IpK9kFeNr0gAI33-no-OQuzfts0PMA7lXRysP9Y5RhmcsAoA19n8Awy-n_XZqxn8PElU7Wd1mv7VTjT9BejnGETD2KH5f6RYCstHR612BTW3k-8TstMF5mu2Q'
        },
      );
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        log('Request success with status: ${response.statusCode}.');
        log('${jsonResponse['data']}');
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
