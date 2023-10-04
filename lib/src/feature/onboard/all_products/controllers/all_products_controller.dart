import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/all_products/model/product_ui_model.dart';

class AllProductsController extends GetxController {
  final bankingData = ProductUiModel(
    backgroundImagePath: "assets/images/banking_bg.png",
    title: "GloriFi Banking",
    description:
        "You move fast and so should your money. Experience the power of real-time banking.",
  );

  final creditCardData = ProductUiModel(
    backgroundImagePath: "assets/images/credit_card_bg.png",
    title: "GloriFi Credit Cards",
    description:
        "Declare financial independence. Low  interest rates. Rewards for everyone. ",
  );

  final mortgageData = ProductUiModel(
    backgroundImagePath: "assets/images/mortgage_bg.png",
    title: "GloriFi Mortgage",
    description:
        "Building new or looking to refinance? Now is the time to secure your financial freedom.",
  );

  final insuranceData = ProductUiModel(
    backgroundImagePath: "assets/images/insurance_bg.png",
    title: "GloriFi Insurance",
    description:
        "We believe in taking care of family. GloriFi protects the life you’ve made.",
  );
}
