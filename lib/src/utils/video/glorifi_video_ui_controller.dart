import 'package:flutter/material.dart';

import 'glorifi_video_gestures_controller.dart';
import 'models/glorifi_video_progress_bar_config.dart';
import 'models/overlay_options.dart';

class GlorifiVideoUiController extends GlorifiVideoGesturesController {
  bool alwaysShowProgressBar = true;
  GlorifiProgressBarConfig glorifiProgressBarConfig =
      const GlorifiProgressBarConfig();
  Widget Function(OverLayOptions options)? overlayBuilder;
}
