import 'package:bloc/bloc.dart';
import 'package:book_nook_user/data/models/Book.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'saved_book_states.dart';
import 'model.dart';

class SavedBookCubit extends Cubit<SavedBookStates> {
  SavedBookCubit() : super(initial());
  static SavedBookCubit get(context) => BlocProvider.of(context);
  List savedApi = [];
  List<Book> sevedBooks = [];

  void getData() async {
    emit(initial());
    await getSavedBookApi();
    sevedBooks.clear();
    savedApi.forEach((val) {
      Book data = Book().fromJson1(val);
      sevedBooks.add(data);
    });
    if (isClosed) return;
    emit(GetData());
    print("booksssssssssssssssss");
  }

  Future getSavedBookApi() async {
    try {
      log('inside getSavedBookApi');
      var response = await http.get(
        Uri.parse("${Store.baseURL}/api/save/"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Store.token}'
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        log('Request success with status: ${response.statusCode}.');
        print("data");
        log('${jsonResponse['data']}');
        savedApi = jsonResponse['data'];
        // getData();
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
