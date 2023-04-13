import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImageFromGallery() async {
  File? image;
  try {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
  }
  return image;
}
