import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/personal_snapshot/compare_with_other/strings.dart';
import 'package:glorifi/src/structure/base_controller.dart';

class CompareOptionData {
  CompareOptionData();

  late final int id;
  late final String optionTitle;

  CompareOptionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    optionTitle = json['optionTitle'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['optionTitle'] = optionTitle;
    return _data;
  }
}

class CompareUserController extends BaseController {
  List<CompareOptionData> compareOptionDataList = [];

  var isDataLoad = false.obs;

  var arrayGender = ['All', 'M', 'F', 'O'];
  var arrayList = ['USA'];

  var textEditingController = TextEditingController();

  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    isDataLoad.value = false;
    getOptionListApi();
    super.onInit();
  }

  getOptionListApi() {
    compareOptionDataList.clear();
    Map<String, dynamic> mMap = json.decode(Strings.jsonOptionList);
    List<dynamic> mList = mMap['options'];
    compareOptionDataList =
        mList.map((e) => CompareOptionData.fromJson(e)).toList();
  }

  getCompareDataApi() {
    Future.delayed(const Duration(seconds: 2), () {
      isDataLoad.value = true;
    });
  }

  @override
  void onClose() {
    // ignore: todo
    // TODO: implement onClose
    textEditingController.dispose();
    super.onClose();
  }
}
