import 'dart:convert';
import 'dart:io';

import 'package:book_nook_user/data/models/Book.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:http/http.dart' as http;

class BookWebServices {
  //---------- send favorite category---------------
  Future<void> sendFavoriteCategories({required List<int> cat}) async {
    Map<String, dynamic> data = {};

    for (int i = 0; i < cat.length; i++) {
      data.addAll({"favorites[$i]": cat[i].toString()});
    }
    print("web cat start");
    print(data);
    var response =
        await http.post(Uri.parse("${Store.baseURL}/api/category/favorite/"),
            headers: {
              "Authorization": 'Bearer ${Store.token}',
              'Charset': 'utf-8',
              "Accept": "application/json",
            },
            body: data);
    print(json.decode(response.body));
  }
  //---------------------------------------------

  Future<List> getBooksInCategory({required int id}) async {
    try {
      var response = await http
          .get(Uri.parse("${Store.baseURL}/api/category/$id"), headers: {
        "Accept": "application/json",
      });
      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      print(response.body);
      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        print("Hi");
        List books = responseBody["data"];
        // print(books);
        // List<BookInfo> allBooks = [];
        // allBooks.clear();
        // for (var i = 0; i < books.length; i++) {
        //   this.allBooks.add(BookInfo().fromJson1(books[i]));
        //   print(this.allBooks[i].image);
        // }
        // print(this.allBooks);
        // return this.allBooks;
        return books;
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      throw Exception("Something went wrong");
      // return [];
    }
  }

  Future<List> getAllBooks() async {
    try {
      print("web");
      var response =
          await http.get(Uri.parse("${Store.baseURL}/api/book/"), headers: {
        "Accept": "application/json",
      });
      print("Hi");
      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      print(response.body);
      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        List books = responseBody["data"];
        return books;
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      throw Exception("Something went wrong");
      // return [];
    }
  }

  ///---------------------------- top rated book ----------------------
  Future<List> getTopRatedBooks() async {
    try {
      print("web");
      var response = await http.get(
          Uri.parse("${Store.baseURL}/api/book/rate/top/top_rate"),
          headers: {
            "Accept": "application/json",
          });
      print("Hi");
      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      print(response.body);
      if (response.statusCode == 200 && responseBody["status code"] == 200) {
        List books = responseBody["data"];
        return books;
      } else if (response.statusCode == 400 ||
          responseBody["status code"] == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      throw Exception("Something went wrong");
      // return [];
    }
  }

  //--------------fetch book -----------------------------------
  Future<Map<String, dynamic>> getBook({required int id}) async {
    try {
      var response =
          await http.get(Uri.parse("${Store.baseURL}/api/book/$id"), headers: {
        'Charset': 'utf-8',
        "Accept": "application/json",
      });
      var responsebody = (json.decode(response.body) as Map<String, dynamic>);
      if (response.statusCode == 200) {
        return responsebody["data"];
      } else if (response.statusCode == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      throw Exception("No internet connection");
    }
  }
}
