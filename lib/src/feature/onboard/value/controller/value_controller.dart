import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/value/model/value_content.dart';

class ValueController extends GetxController {
  final GlobalKey<ScaffoldState> progressKey = GlobalKey();

  RxInt _pageController = 0.obs;
  int get pagerPage => _pageController.value;

  @override
  onInit() {
    _initProgress();
    super.onInit();
  }

  _initProgress() {
    //Initiate progress for default first page 0
    updatePage(0);
  }

  updatePage(int page) {
    _pageController(page);
  }

  final List<ValueContent> contents = [
    ValueContent(title: '', subtitle: 'Preserve the America you believe in.\n'),
    ValueContent(
        title: 'Your money.\nYour values.',
        subtitle:
            'Put your money where your values are and send a message with every purchase.'),
    ValueContent(
      title: 'Live free and\nindependent',
      subtitle:
          'Use the power of your GloriFi digital wallet and expert tips to take control of your finances.',
    ),
    ValueContent(
      title: 'Earn points\nwith purpose',
      subtitle:
          'Get rewarded for loyalty and referrals - for making good financial decisions, not just spending.',
    ),
    ValueContent(
      title: 'Get the news\nyou want',
      subtitle:
          'Stay informed with relevant news, podcasts, and insights — curated for freedom-loving patriots like you.',
    ),
  ];
}
