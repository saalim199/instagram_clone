import 'dart:typed_data';
import 'package:instagram_clone/Resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserdetails() async {
    DocumentSnapshot snapshot =
        await _firestore.collection("users").doc(_auth.currentUser!.uid).get();

    return model.User.fromSnapshot(snapshot);
  }

  Future<String> Signupuser({
    required String username,
    required String email,
    required String password,
    required String confirmpassword,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "";
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          password == confirmpassword &&
          bio.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String photoUrl = await StorageMethod()
            .uploadImagetoStorage("profilepic", file, false);

        model.User user = model.User(
            username: username,
            email: email,
            photoUrl: photoUrl,
            uid: cred.user!.uid,
            bio: bio,
            following: [],
            followers: []);

        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "success";
      } else {
        res = "Fill all the details correctly";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> LoginUser(
      {required String email, required String password}) async {
    String res = "";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Fill Correctly";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
