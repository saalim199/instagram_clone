// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String desc;
  final String postId;
  final String postUrl;
  final String uid;
  final datePublished;
  final String profileImage;
  final likes;
  final String username;

  Post({
    required this.desc,
    required this.postId,
    required this.postUrl,
    required this.uid,
    required this.datePublished,
    required this.profileImage,
    required this.likes,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        'desc': desc,
        "uid": uid,
        "postId": postId,
        "postUrl": postUrl,
        "datePublished": datePublished,
        "profileImage": profileImage,
        "likes": likes,
        "username": username,
      };

  static Post fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return Post(
        desc: snap['desc'],
        uid: snap['uid'],
        postId: snap['postId'],
        postUrl: snap['postUrl'],
        datePublished: snap['datePublished'],
        profileImage: snap['profileImage'],
        likes: snap['likes'],
        username: snap['username']);
  }
}
