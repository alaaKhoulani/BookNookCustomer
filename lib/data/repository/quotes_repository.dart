
import 'package:book_nook_user/data/models/quote.dart';
import 'package:book_nook_user/data/web_services/quotes_web_services.dart';

class QuotesRepository {
  final QuotesWebServices _quotesWebServices;
  QuotesRepository(this._quotesWebServices);

  Future<List<RandomQuote>> getRandomQuote() async {
    final quotes = await _quotesWebServices.getRandomQuote();
    print("repository");
    print(quotes.map((quote) => RandomQuote().fromJson(quote)).toList());
    return quotes.map((quote) => RandomQuote().fromJson(quote)).toList();
  }

  Future<List> getBookQuotes({
    required int id,
  }) async {
    print("====================");
    final quotes = await _quotesWebServices.getBookQuotes(id: id);
    return quotes.map((quote) => Quote().fromJson(quote)).toList();
  }

  Future<bool> addQuote({required String quote, required int id}) async {
    return await _quotesWebServices.addQuote(quote: quote, id: id);
  }
}
