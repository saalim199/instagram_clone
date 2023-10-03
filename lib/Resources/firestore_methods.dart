import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/Resources/storage_methods.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadImage(String desc, String uid, Uint8List file,
      String profileImage, String username) async {
    String res = "";
    try {
      String photoUrl =
          await StorageMethod().uploadImagetoStorage('posts', file, true);
      var postId = const Uuid().v1();
      Post post = Post(
        desc: desc,
        postId: postId,
        postUrl: photoUrl,
        uid: uid,
        datePublished: DateTime.now(),
        profileImage: profileImage,
        likes: [],
        username: username,
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  Future<void> postComment(String postId, String text, String uid, String name,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'commentId': commentId,
          'text': text,
          'uid': uid,
          'name': name,
          'profilePic': profilePic,
          'datePosted': DateTime.now(),
        });
      } else {
        print('Text in empty');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
