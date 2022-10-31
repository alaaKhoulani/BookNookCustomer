import 'package:book_nook_user/data/models/Book.dart';

abstract class SavedBookStates {}

class initial extends SavedBookStates {}

class GetData extends SavedBookStates {
  // final List<BookInfo> savedBooks;

  // GetData(this.savedBooks);
}
