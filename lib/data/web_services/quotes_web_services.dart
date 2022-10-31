import 'dart:convert';
import 'dart:io';

import 'package:book_nook_user/services/storage/store.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class QuotesWebServices {
  quoteswebservices() {}
  Future<List<dynamic>> getRandomQuote() async {
    try {
      print("web start");
      Response response = await http.get(
          Uri.parse("${Store.baseURL}/api/quote"),
          headers: {"Accept": "app;ication/json"});
      // print("web");
      // print(response.body);
      var responceBody = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200 && responceBody["status code"] == 200)
        return (jsonDecode(response.body) as Map<String, dynamic>)["data"];
      else
        return [];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  //---------------- show Quotes in book -----------------------
  Future<List> getBookQuotes({
    required int id,
  }) async {
    try {
      var response =
          await http.get(Uri.parse("${Store.baseURL}/api/quote/$id"), headers: {
        "Accept": "application/json",
      });
      print(response.body);
      if (response.statusCode == 200) {
        List books = (json.decode(response.body))['data'];
        return books;
      } else if (response.statusCode == 400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      return [];
    }
  }

  //TODO:
  //------------------------ add Quotes--------------------
  Future<bool> addQuote({required String quote, required int id}) async {
    try {
      var response = await http
          .post(Uri.parse("${Store.baseURL}/api/quote/$id"), headers: {
        "Accept": "application/json",
        "Authorization": 'Bearer ${Store.token}',
      }, body: {
        "quote": quote
      });

      var responseBodey = (json.decode(response.body) as Map<String, dynamic>);
      // print(responseBodey);
      if (response.statusCode == 200 && responseBodey["status code"] == 200) {
        return true;
      } else if (response.statusCode == 400 || responseBodey["status code"]==400) {
        throw Exception(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      throw (Exception());
    }
  }
}
