import 'dart:convert';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:book_nook_user/data/models/quote.dart';
import 'package:book_nook_user/data/repository/quotes_repository.dart';
import 'package:book_nook_user/data/web_services/quotes_web_services.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'quotes_state.dart';

class QuotesCubit extends Cubit<QuotesState> {
  QuotesCubit() : super(QuotesInitial());

  QuotesRepository _quotesRepository = QuotesRepository(QuotesWebServices());
  List<Quote> quotes = [];
  late List<RandomQuote> myquotes = [];

  //----------------random quote------------

  Future<RandomQuote> getRandomQuote() async {
    emit(QuotesRandomInitial());
    await _quotesRepository.getRandomQuote().then((quotes) {
      print(quotes);
      this.myquotes = quotes;
      emit(QuotesLoaded(quotes));
    });
    return this.myquotes[new Random().nextInt(myquotes.length)]; //[];
  }

  //--------------------- get quotes in one book----------------------
  Future<void> getBookQuotes({required int id}) async {
    try {
      int x = this.quotes.length;
      emit(QuotesInitial());
      List<Quote> quotes =
          await _quotesRepository.getBookQuotes(id: id) as List<Quote>;
      this.quotes = quotes;
      emit(QuotesSuccess(quotes));
    } catch (e) {
      // emit(QuotesFailure(exception: e));
    }
  }
  //-------------------------- add quote----------------------------

  Future<void> addQuote({required String quote, required int id}) async {
    try {
      emit(QuotesPostSubmetting());
      print("QuotesPostSubmetting");
      bool ok = await _quotesRepository.addQuote(quote: quote, id: id);
      if (ok == true) {
        // QuotesToShow.clear();

        if (isClosed) return;
        emit(QuotesPostSuccess());
        print("QuotesPostSuccess");
      }
    } catch (e) {
      // throw
    }
  }
  
  Future deletQuote({required int id}) async {
    try {
      print("hiii");
      print("rama");
      var response = await http.delete(
        Uri.parse("${Store.baseURL}/api/quote/$id"),
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

  Future UpdateQuote({
    required String value,
    required int id
  }) async {
    try {
      print("hiii");
      // var response = await http.get(url);
      Map<String, String> body = {
        "value": value,
      };
      print("rama");
      var response = await http.put(Uri.parse("${Store.baseURL}/api/quote/$id"),
          headers: {
            'Accept': 'application/json',
            'Authorization': ' Bearer ${Store.token}'
          },
          body: body);

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
