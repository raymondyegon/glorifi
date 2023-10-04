import 'package:get/get.dart';
import 'package:glorifi/src/feature/mortgage/model/mortgage_data.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../routes/app_pages.dart';
import '../../../structure/base_controller.dart';
import '../../../utils/support/support_navigation_helper.dart';

class MortgageDetailController extends BaseController {
  late MortgageData data;

  @override
  void onInit() {
    super.onInit();
    data = Get.arguments["data"] as MortgageData;
  }

  getMortgageDetailData() {
    return data;
  }

  String dateFormatter(String date) {
    final DateFormat formatter = DateFormat('MM/dd/yyyy');
    final String formattedDate = formatter.format(DateTime.parse(date));
    return formattedDate;
  }

  Future<void> navigateToFAQ() async {
    String category = 'Mortgage';
    SupportNavigationHelper.navigateToList(category);
  }

  Future<void> navigateToBlend() async {
    Get.toNamed(Routes.connectBlendSso);
  }

  Future<void> makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void>  launchEmail() async {
    String email="agent-mlo@glorifi.com";
    if (await canLaunch("mailto:$email")) {
      await launch("mailto:$email");
    } else {
      throw 'Could not launch';
    }
  }
}
