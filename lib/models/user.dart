import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String email;
  final String photoUrl;
  final String uid;
  final String bio;
  final List following;
  final List followers;

  const User({
    required this.username,
    required this.email,
    required this.photoUrl,
    required this.uid,
    required this.bio,
    required this.following,
    required this.followers,
  });
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "bio": bio,
        "followers": followers,
        "following": following,
        "photoUrl": photoUrl,
      };

  static User fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return User(
        username: snap['username'],
        email: snap['email'],
        photoUrl: snap['photoUrl'],
        uid: snap['uid'],
        bio: snap['bio'],
        following: snap['following'],
        followers: snap['followers']);
  }
}
