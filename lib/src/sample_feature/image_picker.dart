import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/image_picker_controller.dart';
import 'package:glorifi/src/feature/cockpit/profile/get_img_upload_options.dart';
import 'package:glorifi/src/glorifi-widgets/glorifi_button.dart';

class ImagePicker extends GetView<ImagePickerController> {
  const ImagePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(),
          body: controller.imagePath.isEmpty
              ? OnboardingButton(
                  btnName: "Pick Image",
                  callback: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return GetImgUploadOptions();
                      },
                    );
                  },
                )
              : Column(
                children: [
                    Expanded(child: Image.file(File(controller.imagePath))),
                    OnboardingButton(
                      btnName: "Upload Image",
                      callback: () {
                        controller.uploadImage();
                      },
                    )
                  ],
              ),
        ));
  }
}
