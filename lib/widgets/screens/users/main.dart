import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:word_search_puzzle/models/hive/levels/main.dart';
import 'package:word_search_puzzle/models/hive/users/main.dart';
import 'package:word_search_puzzle/view_models/users/main.dart';
import 'package:word_search_puzzle/widgets/bottom_nav/main.dart';
import 'package:word_search_puzzle/widgets/buttons/back_sound_button.dart';
import 'package:word_search_puzzle/widgets/screens/users/add.dart';
import 'package:word_search_puzzle/widgets/screens/users/update.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  UserViewModel userViewModel = UserViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userViewModel = Provider.of<UserViewModel>(context, listen: true);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                children: [
                  const Center(
                    child: Card(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                        child: Text(
                          "Users",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: userViewModel.getAllUsers().length,
                      itemBuilder: (context, index) {
                        final user = userViewModel.getAllUsers()[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(user.userName!.toUpperCase()),
                              subtitle: Row(
                                children: [
                                  const Text(
                                    "Level: ",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(user.level!.name.toUpperCase())
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      // Remove user from the list
                                      userViewModel.removeUser(user.userId!);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      // Show the update user popup
                                      _showUpdateUserPopup(user, index);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            if (index + 1 == userViewModel.getAllUsers().length)
                              const SizedBox(height: 8),
                            const Divider(),
                            const SizedBox(height: 8),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: FancyBottomAppBar(
        backButton: const BackSoundButton(),
        menuItems: [
          IconButton(
            icon: Icon(
              Icons.person_add,
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
            onPressed: () {
              // Show the add member popup
              _showAddUserPopup();
            },
          ),
        ],
      ),
    );
  }

  void _addUser(String name, LevelModel level) {
    if (kDebugMode) {
      print({"String name": name, "String level": level});
    }
    final user = UserModel(userName: name, level: level);
    userViewModel.addUser(user);
  }

  void _showAddUserPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddUserPopup(
          onUserAdded: _addUser,
        );
      },
    );
  }

  void _updateUser(String name, LevelModel level, int index) {
    if (kDebugMode) {
      print({"String name": name, "String level": level});
    }
    userViewModel.updateUser(index, userName: name, level: level);
  }

  void _showUpdateUserPopup(UserModel member, int index) {
    if (kDebugMode) {
      print({"member": member.toMap()});
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return UpdateUserPopup(
          onUserUpdated: _updateUser,
          index: index,
          member: member,
        );
      },
    );
  }
}
