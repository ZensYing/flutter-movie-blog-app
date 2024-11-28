import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _userName = '';
  String _userEmail = '';
  String _userAvatar = 'assets/img/Avatar.png'; // Default avatar path

  // Getters
  String get userName => _userName;
  String get userEmail => _userEmail;
  String get userAvatar => _userAvatar;

  // Determine if the user is logged in
  bool get isLoggedIn => _userName.isNotEmpty && _userEmail.isNotEmpty;

  // Set user data (for login)
  void setUser(String name, String email, String avatar) {
    _userName = name;
    _userEmail = email;
    _userAvatar = avatar.isNotEmpty ? avatar : 'assets/img/Avatar.png';
    notifyListeners();
  }

  // Clear user data (for logout)
  void clearUser() {
    _userName = '';
    _userEmail = '';
    _userAvatar = 'assets/img/Avatar.png';
    notifyListeners();
  }
}
