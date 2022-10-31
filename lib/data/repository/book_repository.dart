import 'dart:io';

import 'package:book_nook_user/data/models/Book.dart';
import 'package:book_nook_user/data/web_services/book_web_services.dart';
import 'package:flutter/cupertino.dart';

class BookRepository {
  final BookWebServices _bookWebServices;
  BookRepository(this._bookWebServices);
  List<BookInfo> allBooks = [];
  List<BookInfo> topRatedBooks = <BookInfo>[];

  //----------------------fetch all books-------------------
  Future<List<BookInfo>> getAllBooks() async {
    print("repository");
    List books = await _bookWebServices.getAllBooks() as List;
    print("object");

    // List<BookInfo> allBooks = [];
    this.allBooks.clear();
    for (var i = 0; i < books.length; i++) {
      print(i);
      this.allBooks.add(BookInfo().fromJson1(books[i]));
      print(this.allBooks[i].name);
    }
    print("==============repository===============");

    return this.allBooks;
  }

  //----------------------fetch top rated books-------------------
  Future<List<BookInfo>> getTopRAtedBooks() async {
    print("repository");
    List books = await _bookWebServices.getTopRatedBooks() as List;
    print("object");

    List<BookInfo> allBooks = [];
    allBooks.clear();
    for (var i = 0; i < books.length; i++) {
      this.topRatedBooks.add(BookInfo().fromJson1(books[i]));
      print(this.topRatedBooks[i].name);
    }
    // print("==============repository===============");

    return this.topRatedBooks;
  }

  //----------------------fetch bookss in category-------------------
  Future<List<BookInfo>> getBooksInCAtegory({
    required int id,
  }) async {
    List books = await _bookWebServices.getBooksInCategory(id: id) as List;
    print("object");

    List<BookInfo> allBooks = [];
    allBooks.clear();
    for (var i = 0; i < books.length; i++) {
      this.allBooks.add(BookInfo().fromJson1(books[i]));
      print(this.allBooks[i].name);
    }
    // print("==============repository===============");

    return this.allBooks;
  }
  //--------------------- fetch book ------------------------

  Future<BookInfo> getBook({required int id}) async {
    var book = await _bookWebServices.getBook(id: id);
    return BookInfo().fromJson1(book);
  }

  //--------------------------- post new Order ------------------------

}
