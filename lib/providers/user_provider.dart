// lib/providers/user_provider.dart
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _userName = '';
  String _userEmail = '';
  String _userAvatar = 'assets/img/Avatar.png'; // Default avatar path

  String get userName => _userName;
  String get userEmail => _userEmail;
  String get userAvatar => _userAvatar;

  // Set user data
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
