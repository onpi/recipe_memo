import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class image_picker {
  File? _image;
  final imagePicker = ImagePicker();
  Future getImageFromCamera() async {
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.camera);
    // setState(() {
    //   if (pickedFile != null) {
    //     _image = File(pickedFile.path);
    //   }
    // });
  }

  Future<dynamic> get getImageFromGallery async {
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      return _image;
    } else {
      return false;
    }
    // setState(() {
    //   if (pickedFile != null) {
    //     _image = File(pickedFile.path);
    //   }
    // });
  }
}
