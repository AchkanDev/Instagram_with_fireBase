import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? xFile = await imagePicker.pickImage(source: source);

  if (xFile != null) {
    return xFile.readAsBytes();
  }
  print("image not selected");
}

Future<File> getImageFileFromAssets(String path) async {
  // Directory dir = await getApplicationDocumentsDirectory();
  // String pathName = '/storage/emulated/0/Download/$filename';
  // return File(pathName);
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.create(recursive: true);
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}
