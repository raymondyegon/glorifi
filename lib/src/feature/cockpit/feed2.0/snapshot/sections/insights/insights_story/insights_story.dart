// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/insights_story/insights_story_controller.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class InsightsStory extends GetView<InsightsStoryController> {
  InsightsStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String insightId = Get.parameters['insightId'].toString();
    String instanceId = Get.parameters['instanceId'].toString();
    String insightTitle = Get.parameters['title'].toString();
    late String requestId;

    return Scaffold(
      appBar: GlorifiAppBar(title: insightTitle),
      body: WebViewPlus(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          this.controller.webController = controller;
          this
              .controller
              .webController
              .loadUrl('assets/personetics/glorifi_home/home.html');
        },
        javascriptChannels: <JavascriptChannel>{
          JavascriptChannel(
            name: "PassInsightInfo",
            onMessageReceived: (JavascriptMessage message) async {
              Map valueMap = jsonDecode(message.message);
              var data = await controller.getInsightDetailsForWeb(valueMap);
              Log.info(data.toString());
              final bytes = utf8.encode(data.toString());
              final base64Str = base64.encode(bytes);

              controller.webController.webViewController.runJavascript(
                  'homeApp.showResponse("$base64Str", "$requestId");');
            },
          ),
          JavascriptChannel(
            name: "PrintMessage",
            onMessageReceived: (JavascriptMessage message) {
              log(message.message);
            },
          ),
          JavascriptChannel(
            name: "sendRequestId",
            onMessageReceived: (JavascriptMessage message) {
              Log.info(message.message);
              requestId = message.message;
            },
          ),
          JavascriptChannel(
            name: "NavigateUser",
            onMessageReceived: (JavascriptMessage message) {
              Get.toNamed(message.message.toString());
            },
          ),
        }.toSet(),
        onPageFinished: (url) {
          controller.webController.webViewController.runJavascript(
              'homeApp.showWidget("$insightId", "$instanceId");');
        },
      ),
    );
  }
}
