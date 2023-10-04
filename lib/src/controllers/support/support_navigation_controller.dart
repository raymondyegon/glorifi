import 'package:glorifi/src/structure/base_controller.dart';

class SupportNavigationController extends BaseController {
  bool isBottomSheet = false;
  String? selectedCategoryTitle, selectedCategoryKey;
  String? selectedSupportCategoryTitle, selectedSupportMethod;
  String? name, email, phone, memberID;

  Map<String, dynamic> webViewArguments = {};
}