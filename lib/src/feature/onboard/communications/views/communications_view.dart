import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/communications/widget/general_card.dart';
import 'package:glorifi/src/feature/onboard/communications/widget/marketing_card.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

import '../controllers/communications_controller.dart';

class CommunicationsView extends GetView<CommunicationsController> {
  const CommunicationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
        appBar: GlorifiAppBar(title: 'Communications', elevation: 16),
        body: Column(
          children: [
            GeneralCard(controller),
            MarketingCard(),
          ],
        ));
  }
}
