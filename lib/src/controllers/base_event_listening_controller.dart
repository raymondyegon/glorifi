import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/event_broadcaster.dart';

abstract class BaseEventListeningController extends GetxController {
  late StreamSubscription _subscription;

  @override
  void onInit() {
    _subscription = EventBroadcaster.instance.stream.listen((event) {
      if (event is AccountsChangedEvent) {
        onAccountsChanged(event);
      }
      if (event is CreditScoreWasEnabledEvent) {
        onCreditScoreEnabled(event);
      }
    });
    super.onInit();
  }

  @protected
  void onAccountsChanged(AccountsChangedEvent event) {}

  @protected
  void onCreditScoreEnabled(CreditScoreWasEnabledEvent event) {}

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
