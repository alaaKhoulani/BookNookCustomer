import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:book_nook_user/data/models/comment.dart';
import 'package:book_nook_user/data/repository/comment_repository.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:meta/meta.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentInitial());
  CommentRepository _commentRepository = CommentRepository();

  List<Comment> mycomments = [];

  //--------------------- get quotes in one book----------------------
  Future<void> getBookComment({required int id}) async {
    try {
      // int x = this.comments.length;
      emit(CommentInitial());
      List<Comment> comment =
          await _commentRepository.getBookComments(id: id) as List<Comment>;
      this.mycomments = comment;
      emit(CommentGetSuccess(mycomments));
    } catch (e) {
      emit(CommentFailure(exception: Exception()));
    }
  }
  //-------------------------- add comment----------------------------

  Future<void> addComment({required String comment, required int id}) async {
    try {
      emit(CommentPostSubmetting());
      // print("QuotesPostSubmetting");
      bool ok = await _commentRepository.addComment(comment: comment, id: id);
      print("ok=$ok");
      if (ok == true) {
        if (isClosed) return;
        emit(CommentPostSuccess());
        // print("QuotesPostSuccess");
      }
    } catch (e) {
      // throw
    }
  }
  //----------------------- update comment---------------------------

  Future UpdateComment({
    required int id,
    required String value,
  }) async {
    try {
      emit(CommentPostSubmetting());
      print("hiii");
      // var response = await http.get(url);
      Map<String, String> body = {
        "value": value,
      };
      print("rama");
      var response = await http.put(
          Uri.parse("${Store.baseURL}/api/comment/$id"),
          headers: {
            'Accept': 'application/json',
            'Authorization': ' Bearer ${Store.token}'
          },
          body: body);

      print("hala");
      print('Request success with status: ${response.statusCode}.');
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print("${jsonResponse['message']}");
        this.getBookComment(id: id);
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  //--------------------------delete comment ------------------------------
  
  Future deletComent({required int id}) async {
    try {
      print("hiii");
      print("rama");
      var response = await http.delete(
        Uri.parse("${Store.baseURL}/api/comment/$id"),
        headers: {
          'Accept': 'application/json',
          'Authorization': ' Bearer ${Store.token}'
        },
      );

      print("hala");
      print('Request success with status: ${response.statusCode}.');
      if (response.statusCode == 200) {
        // var jsonResponse = (convert.jsonDecode(response.body) as Map<String,dynamic>)['message'];
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print("${jsonResponse['message']}");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

}
