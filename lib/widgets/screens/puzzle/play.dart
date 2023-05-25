import 'package:flutter/material.dart';
import 'package:word_search_puzzle/models/hive/levels/main.dart';
import 'package:word_search_puzzle/models/hive/users/main.dart';
import 'package:word_search_puzzle/utils/functions/word_bank.dart';
import 'package:word_search_puzzle/widgets/bottom_nav/main.dart';
import 'package:word_search_puzzle/widgets/buttons/back_sound_button.dart';
import 'package:word_search_puzzle/widgets/buttons/sound_button.dart';
import 'package:word_search_puzzle/widgets/screens/instructions/main.dart';
import 'package:word_search_puzzle/widgets/screens/leader_board/main.dart';
import 'package:word_search_puzzle/widgets/screens/puzzle/main.dart';
import 'package:word_search_puzzle/widgets/screens/settings/main.dart';
import 'package:word_search_puzzle/widgets/timer/main.dart';

GlobalKey<PlayScreenState> playScreenKey = GlobalKey<PlayScreenState>();

class PlayScreen extends StatefulWidget {
  final UserModel selectedUser;
  const PlayScreen({super.key, required this.selectedUser});

  @override
  State<PlayScreen> createState() => PlayScreenState();
}

class PlayScreenState extends State<PlayScreen> {
  late LevelModel level;
  Key puzzleKey = const Key("First");
  @override
  void initState() {
    super.initState();

    level = widget.selectedUser.level!;
  }

  @override
  void didUpdateWidget(covariant PlayScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // print({"widget.selectedUser.level": widget.selectedUser.level});
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder<List<String>>(
            future: loadJsonWordBankData(level),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // print({"snapshot.data": snapshot.data});
                // return Text(snapshot.data.toString());
                return CrossWordWidget(
                  key: puzzleKey,
                  wordList: snapshot.data!,
                  selectedUser: widget.selectedUser,
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: FancyBottomAppBar(
        backButton: BackSoundButton(onPressed: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            stopwatchKey.currentState!.stopStopwatch();
          });
        }),
        menuItems: [
          SoundButtonWidget(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      dialogBackgroundColor: Colors.white,
                      dialogTheme: DialogTheme(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: const LeaderBoardScreen(),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            tooltip: "Leaderboard",
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.leaderboard,
                color: Colors.red,
              ),
            ),
          ),
          SoundButtonWidget(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      dialogBackgroundColor: Colors.white,
                      dialogTheme: DialogTheme(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: const SettingsScreen(),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            tooltip: "Settings",
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.settings,
                color: Colors.red,
              ),
            ),
          ),
          SoundButtonWidget(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      dialogBackgroundColor: Colors.white,
                      dialogTheme: DialogTheme(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: const InstructionsScreen(),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            tooltip: "Instructions",
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.help,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
