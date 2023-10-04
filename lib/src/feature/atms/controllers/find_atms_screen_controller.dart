import 'package:get/get.dart';
import 'package:glorifi/src/feature/atms/models/atm_model.dart';

class FindAtmsScreenController extends GetxController {
  final _atmListController = RxList<AtmModel>();

  List<AtmModel> get atmList => _atmListController.toList();

  @override
  void onInit() {
    _prepareAtmList();
    super.onInit();
  }

  void _prepareAtmList() {
    List<AtmModel> itemList = [
      AtmModel(
          name: 'AllPoint ATM Locations',
          desc:
              'ATMs are available at select CVS, Walgreens and other prominent retail stores in major metropolitan areas across the country.'),
      AtmModel(
          name: 'MoneyPass ATM Locations',
          desc:
              'ATMs are available at retail stores, convenience stores, and financial institutions.')
    ];
    _atmListController(itemList);
  }
}
