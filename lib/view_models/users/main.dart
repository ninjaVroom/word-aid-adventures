import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:word_search_puzzle/models/hive/levels/main.dart';
import 'package:word_search_puzzle/models/hive/users/main.dart';

class UserViewModel extends ChangeNotifier {
  String boxName = "users";
  late final Box<UserModel> _userBox = Hive.box<UserModel>(boxName);

  UserViewModel();

  // List<UserModel> _users = [];

  void addUser(UserModel user) {
    if (_userBox.isEmpty) {
      // No user created yet
      user.userId = 1;
    } else {
      // Get userId of last saved user
      final lastSavedUser = _userBox.values.last;
      // Set new userId to last saved userId + 1
      user.userId = lastSavedUser.userId! + 1;
    }

    _userBox.add(user);
    notifyListeners();
  }

  void removeUser(int userId) {
    _userBox.values
        .where((user) => user.userId == userId)
        .forEach((user) => user.delete());
    notifyListeners();
  }

  void updateUser(int userId, {String? userName, LevelModel? level}) {
    final user = _userBox.values.firstWhere((user) => user.userId == userId);
    if (userName != null) {
      user.userName = userName;
    }
    if (level != null) {
      user.level = level;
    }
    user.save();
    notifyListeners();
  }

  List<UserModel> getAllUsers() {
    return _userBox.values.toList();
  }

  UserModel? getUserById(int userId) {
    return _userBox.values
        .firstWhere((user) => user.userId == userId, orElse: () => UserModel());
  }
}
