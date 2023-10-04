import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/image_picker_controller.dart';

class GetImgUploadOptions extends GetView<ImagePickerController> {
  const GetImgUploadOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () {
            controller.pickImageFromCamera(context);
          },
          child: Text(
            "Camera",
            style: TextStyle(color: Colors.black),
          ),
        ),
        Divider(),
        TextButton(
          onPressed: () {
            controller.pickImageFromGallery(context);
            if(Get.isDialogOpen!){
              Get.back();
            }

          },
          child: Text("Gallery", style: TextStyle(color: Colors.black)),
        ),
        Divider(),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel", style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
