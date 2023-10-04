import 'package:get/instance_manager.dart';
import 'package:glorifi/src/feature/credit_card_2/dashboard/cc_dashboard_service.dart';

class CCDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CCDashboardService());
  }
}
