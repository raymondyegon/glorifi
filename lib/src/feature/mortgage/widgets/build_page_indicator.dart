import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/mortgage/widgets/banner_indicator.dart';

/// Generating page indicators
List<Widget> buildPageIndicator(
    {required int currentPage, required int totalPages}) {
  List<Widget> list = [];
  for (int i = 0; i < totalPages; i++) {
    list.add(BannerIndicator(isActive: i == currentPage));
  }
  return list;
}
