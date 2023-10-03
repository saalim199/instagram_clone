import 'package:flutter/material.dart';
import 'package:instagram_clone/Resources/auth_methods.dart';
import 'package:instagram_clone/models/user.dart';

class Userprovider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();
  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserdetails();
    _user = user;
    notifyListeners();
  }
}
