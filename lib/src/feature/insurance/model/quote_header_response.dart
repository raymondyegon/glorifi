import 'package:glorifi/src/feature/insurance/model/quotes.dart';

class QuoteHeaderResponse {
  QuoteHeaderResponse({
    required this.quotes,
  });
  late final List<Quotes> quotes;

  QuoteHeaderResponse.fromJson(Map<String, dynamic> json) {
    quotes = List.from(json['quotes']).map((e) => Quotes.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['quotes'] = quotes.map((e) => e.toJson()).toList();
    return _data;
  }
}
