import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/servicing/model/ebs_statement.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/account_settings/controller/ebs_statements_controller.dart';
import 'package:glorifi/src/feature/banking/servicing/widgets/ebs_container.dart';
import 'package:glorifi/src/feature/banking/servicing/widgets/row_button.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/snapshot_widget/snapshot_widget.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/date_util.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';
import 'package:url_launcher/url_launcher.dart';

class EBSStatementsScreen extends GetView<EBSStatementsController> {
  const EBSStatementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        Get.put(EBSStatementsController());
      },
      child: Obx(() {
        return EBSContainer(
      title: "Statements",
      showSettings: false,
          children: _content(),
        );
      }),
    );
  }

  List<Widget> _content() {
    if (controller.loading.value == true) {
      return [
        Expanded(
            child: Center(
          child: GlorifiSpinner(),
        ))
      ];
    } else {
      if (controller.statements.length == 0) {
        return [_noStatements()];
      }
      return [_statementList()];
    }
  }

  Widget _noStatements() {
    return Center(
      child: Text(
        'No statements available',
        style: bodyRegular18Primary(),
      ),
    ).paddingOnly(top: 20);
  }

  Widget _statementList() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [...controller.statements.map(_statementRow).toList()],
        ),
      ),
    );
  }

  Widget _statementRow(EBSStatement statement) {
    return RowButton(
        asset: 'assets/icons/statements.svg',
        title: 'Statement ending ${statement.endDate.toDisplayFormat()}',
        onTap: () {
          controller.onStatementTap(statement);
        });
  }


}
