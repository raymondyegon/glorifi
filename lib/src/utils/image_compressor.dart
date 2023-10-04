import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart' show compute;
import 'package:image/image.dart' as im;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

const int MAX_IMAGE_HEIGHT = 512;
const int IMAGE_QUALITY = 80;

Future<File> getCompressedPicture(File _imageFile) async {
  final tempDir = await getTemporaryDirectory();
  final rand = Random().nextInt(10000);
  _CompressObject compressObject =
      _CompressObject(_imageFile, tempDir.path, rand);
  String filePath = await _compressImage(compressObject);
  File file = File(filePath);

  return file;
}

Future<String> _compressImage(_CompressObject object) async {
  return compute(_decodeImage, object);
}

String _decodeImage(_CompressObject object) {
  im.Image image = im.decodeImage(object.imageFile.readAsBytesSync())!;
  im.Image smallerImage = im.copyResize(image,
      height: image.height > MAX_IMAGE_HEIGHT
          ? MAX_IMAGE_HEIGHT
          : image
              .height); // choose the size here, it will maintain aspect ratio
  String fileExtension = path.extension(object.imageFile.path);

  var decodedImageFile =
      File(object.path + '/img_${object.rand}.$fileExtension');
  decodedImageFile
      .writeAsBytesSync(im.encodeJpg(smallerImage, quality: IMAGE_QUALITY));

  return decodedImageFile.path;
}

class _CompressObject {
  File imageFile;
  String path;
  int rand;

  _CompressObject(this.imageFile, this.path, this.rand);
}
