import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_search_puzzle/models/hive/levels/main.dart';
import 'package:word_search_puzzle/models/hive/users/main.dart';
import 'package:word_search_puzzle/view_models/users/main.dart';
import 'package:word_search_puzzle/widgets/screens/users/add.dart';

class UserSelectionPopup extends StatefulWidget {
  final Function(UserModel) onSelectUser;

  const UserSelectionPopup({super.key, required this.onSelectUser});

  @override
  State<UserSelectionPopup> createState() => _UserSelectionPopupState();
}

class _UserSelectionPopupState extends State<UserSelectionPopup> {
  UserViewModel userViewModel = UserViewModel();

  void _playAsUser(UserModel user) {
    Navigator.pop(context);
    widget.onSelectUser(user);
  }

  @override
  Widget build(BuildContext context) {
    userViewModel = Provider.of<UserViewModel>(context, listen: true);

    void addUser(String name, LevelModel level) {
      if (kDebugMode) {
        print({"String name": name, "String level": level});
      }
      final user = UserModel(userName: name, level: level);
      userViewModel.addUser(user);
    }

    void showAddUserPopup() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddUserPopup(
            onUserAdded: addUser,
          );
        },
      );
    }

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300, maxHeight: 350),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Users"),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.person_add,
                  color: Theme.of(context).appBarTheme.foregroundColor,
                ),
                onPressed: () {
                  // Show the add member popup
                  showAddUserPopup();
                },
              ),
            ],
          ),
          body: Card(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              children: [
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
                            onTap: () => _playAsUser(user),
                          ),
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
    );
  }
}
