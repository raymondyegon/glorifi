import 'package:get/get.dart';
import 'package:glorifi/src/core/base/urls.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/feature/banking/servicing/ebs_controller.dart';
import 'package:glorifi/src/feature/banking/servicing/ebs_service.dart';
import 'package:glorifi/src/feature/banking/servicing/model/ebs_statement.dart';
import 'package:url_launcher/url_launcher.dart';

class EBSStatementsController extends GetxController {
  RxList<EBSStatement> statements = RxList<EBSStatement>();
  final _service = Get.find<EBSService>();
  final loading = false.obs;

  @override
  void onInit() {
    _fetchStatements();
    super.onInit();
  }

  _fetchStatements() async {
    loading.value = true;
    final ebsController = Get.find<EBSController>();
    try {
      statements.value = await _service.getStatements(ebsController.accountId);
    } catch (e) {
      // TODO: Show a retry button
      print(e);
    }
    loading.value = false;
  }

  onStatementTap(EBSStatement statement) async {
    final apiToken = await DataHelperImpl.instance.cacheHelper.getAccessToken();
    await launch(
      _uriForStatement(statement, apiToken),
    );
  }

  String _uriForStatement(EBSStatement statement, String token) {
    return Urls.statementUrl(statement.docId, token);
  }
}
