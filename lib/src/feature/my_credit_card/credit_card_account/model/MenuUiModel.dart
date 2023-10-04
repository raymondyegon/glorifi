import 'package:get/get.dart';

class MenuUiModel {
  final String iconPath;

  final List<String> subMenuList;

  final String title;

  var isExpanded = false.obs;

  MenuUiModel(
      {required this.title, required this.subMenuList, required this.iconPath});
}
