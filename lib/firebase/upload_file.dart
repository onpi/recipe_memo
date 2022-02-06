import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart';

// Future<void> uploadFile(String sourcePath, String uploadFileName) async {
//   final FirebaseStorage storage = FirebaseStorage.instance;
//   Reference ref = storage.ref().child("images"); //保存するフォルダ

//   io.File file = io.File(sourcePath);
//   UploadTask task = ref.child(uploadFileName).putFile(file);

//   try {
//     var snapshot = await task;
//   } catch (FirebaseException) {
//     //エラー処理
//   }
// }

Future<void> uploadString(String sourcePath, String uploadFileName) async {
  const String putStringText =
      'This upload has been generated using the putString method! Check the metadata too!';

  // Create a Reference to the file
  try {
    Reference ref = await FirebaseStorage.instance
        .ref()
        .child('images')
        .child(uploadFileName);
  } catch (e) {
    print(e);
  }

  // Start upload of putString
  // return ref.putString(putStringText,
  //     metadata: firebase_storage.SettableMetadata(
  //         contentLanguage: 'en',
  //         customMetadata: <String, String>{'example': 'putString'}));
}

Future<void> uploadFile(String sourcePath, String uploadFileName) async {
  // if (sourcePath == null) {
  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     content: Text('No file was selected'),
  //   ));

  //   return null;
  // }

  UploadTask uploadTask;

  // Create a Reference to the file
  Reference ref = FirebaseStorage.instance
      .ref()
      .child('playground')
      .child('/some-image.jpg');

  final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': sourcePath});

  uploadTask = ref.putFile(io.File(sourcePath), metadata);

  return Future.value(uploadTask);
}
