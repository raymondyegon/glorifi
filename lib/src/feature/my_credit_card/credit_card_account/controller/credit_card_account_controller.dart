import 'package:get/get.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import '../model/MenuUiModel.dart';

class CreditCardAccountController extends BaseController {
  RxList<MenuUiModel> _menuListController = RxList<MenuUiModel>();

  List<MenuUiModel> get menuList => _menuListController.toList();

  @override
  void onInit() async {
    super.onInit();
    _prepareMenu();
  }

  void _prepareMenu() {
    List<MenuUiModel> list = [
      MenuUiModel(
          title: "Credit card account",
          subMenuList: ['My Account', 'Pay credit card bill'],
          iconPath: GlorifiAssets.banking),
      MenuUiModel(
          title: "ATM Locations",
          subMenuList: [
            'ATM Locator',
          ],
          iconPath: GlorifiAssets.compareCash),
      MenuUiModel(
          title: "Document Center",
          subMenuList: [],
          iconPath: GlorifiAssets.file),
      MenuUiModel(
          title: "Support",
          subMenuList: ['Contact Us', 'FAQs'],
          iconPath: GlorifiAssets.click),
      MenuUiModel(
          title: "Rewards",
          subMenuList: ['View rewards', 'Referrals'],
          iconPath: GlorifiAssets.outlineStar)
    ];
    _menuListController(list);
  }
}

enum CARD_TYPE { BRASS_CARD, REWARDS_CARD }
