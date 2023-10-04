// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:glorifi/src/feature/cockpit/feed_sections/highlights/highlight_model.dart';
// import 'package:glorifi/src/feature/cockpit/feed_sections/highlights/types/base_highlight.dart';
// import 'package:glorifi/src/widgets/buttons/play_button.dart';
// import 'package:glorifi/src/utils/responsive/responsive.dart';

// class VideoHighlight extends GetView<VideosController> {
//   final VideoHighlightModel highlight;

//   const VideoHighlight({Key? key, required VideoHighlightModel this.highlight})
//       : super(key: key);

//   void _onTap() {
//     controller.playVideo(0);
//   }

//   Widget _baseHighlight(onTap) {
//     return BaseHighlight(
//       onTap: onTap,
//       highlight: highlight,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
//             child: PlayButton(height: 50.h),
//           ),
//           // TODO: title is a file path for VideoHighlightModel maybe refactor
//           Image(image: AssetImage(highlight.title))
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => controller.video_list.length <= 0
//         ? _baseHighlight(() {})
//         : _baseHighlight(_onTap));
//   }
// }
