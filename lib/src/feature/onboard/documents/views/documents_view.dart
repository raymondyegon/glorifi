import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

import '../controllers/documents_controller.dart';

class DocumentsView extends GetView<DocumentsController> {
  const DocumentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: GlorifiAppBar(
        title: 'Documents', elevation: 16),
      body: Center(
        child: Text(
          'DocumentsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
