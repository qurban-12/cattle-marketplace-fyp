import 'package:flutter/material.dart';

class UserProfile {
  String name;
  String role;
  // ... other fields

  UserProfile({required this.name, required this.role});
}

class UserProvider with ChangeNotifier {
  UserProfile _currentUser;

  UserProvider(this._currentUser);

  UserProfile get currentUser => _currentUser;

  void setRole(String newRole) {
    _currentUser.role = newRole;
    notifyListeners();
  }

  void setUser(UserProfile user) {
    _currentUser = user;
    notifyListeners();
  }
}
