import 'dart:async';

import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/model/support/faq_search_result_model.dart';

class FAQSearchService extends GetxService {
  FAQSearchService();

  final _dataHelper = DataHelperImpl.instance;

  Future<List<FAQSearchResult>?> getSuggestions(
    String query,
    List libraryIDs,
  ) async {
    if (query.isEmpty && query.length < 3) {
      return Future.value([]);
    }

    Map<String, dynamic> params = {
      "text": query,
      "filters": {
        "searchLanguage": "en",
        "gemTypes": ["FAQ"]
      }
    };

    final response =
        await _dataHelper.apiHelper.getFaqRecommendation(params: params);
    return response.fold((l) {
      throw l.errorMessage;
    }, (r) {
      List<FAQSearchResult> searchResult = r["data"]
          .map<FAQSearchResult>((data) => FAQSearchResult.fromJson(data))
          .toList();
      return searchResult;
    });
  }
}
