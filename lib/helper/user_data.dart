import 'package:firebase_auth/firebase_auth.dart';

String currentUserId() {
  var currentUser = FirebaseAuth.instance.currentUser;
  return currentUser!.uid;
}

