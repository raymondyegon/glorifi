import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/model/support/faq_search_result_model.dart';
import 'package:glorifi/src/structure/base_controller.dart';

import '../../feature/support/faq/faq_search_service.dart';

class FaqSearchController extends BaseController {
  final TextEditingController typeAheadController = TextEditingController();

  final RxString textControllerValue = ''.obs;

  final RxList<FAQSearchResult> _suggestionsController = RxList.empty();

  List<FAQSearchResult> get suggestions => _suggestionsController.toList();

  final Rx<PageState> _pageStateController = Rx(PageState.DEFAULT);

  get pageState => _pageStateController.value;

  @override
  void onInit() {
    typeAheadController.addListener(() {
      textControllerValue.value = typeAheadController.text;
    });
    super.onInit();
  }

  clearSearchResult() {
    suggestions.clear();
    _suggestionsController.clear();
    _pageStateController(PageState.DEFAULT);
  }

  Future<void> getSuggestions(
      {required final pattern, required final libraryIDs}) async {
    try {
      _pageStateController(PageState.LOADING);
      List<FAQSearchResult> suggestionsResponse =
          await FAQSearchService().getSuggestions(pattern, libraryIDs) ?? [];
      _suggestionsController(suggestionsResponse);
      _pageStateController(PageState.SUCCESS);
    } catch (e) {
      _pageStateController(PageState.ERROR);
    }
  }
}
