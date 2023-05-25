import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_search_puzzle/utils/functions/click_sound.dart';
import 'package:word_search_puzzle/view_models/settings/main.dart';
import 'package:word_search_puzzle/widgets/buttons/sound_button.dart';
import 'package:word_search_puzzle/widgets/screens/instructions/main.dart';
import 'package:word_search_puzzle/widgets/screens/leader_board/main.dart';
import 'package:word_search_puzzle/widgets/screens/puzzle/play.dart';
import 'package:word_search_puzzle/widgets/screens/puzzle/user_select.dart';
import 'package:word_search_puzzle/widgets/screens/settings/main.dart';
import 'package:word_search_puzzle/widgets/screens/users/main.dart';

class PuzzleHomePage extends StatefulWidget {
  const PuzzleHomePage({
    super.key,
  });

  @override
  State<PuzzleHomePage> createState() => _PuzzleHomePageState();
}

class _PuzzleHomePageState extends State<PuzzleHomePage> {
  SettingsViewModel settingsViewModel = SettingsViewModel();
  bool backgroundMusicMethodCalled = false;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  void playBackgroundMusic() {
    if (kDebugMode) {
      print({
        "settingsViewModel.getSettings()!.isAudioOn!":
            settingsViewModel.getSettings()!.isAudioOn!
      });
    }
    if (settingsViewModel.getSettings()!.isAudioOn!) {
      setState(() {
        audioPlayer = playBackgroundAudioWithLoop();
      });
    } else {
      stopBackgroundAudioPlayer(audioPlayer);
    }
  }

  @override
  Widget build(BuildContext context) {
    settingsViewModel = Provider.of<SettingsViewModel>(context, listen: true);

    playBackgroundMusic();

    return Scaffold(
      appBar: AppBar(title: const Text("Word Aid Adventures")),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SoundButtonWidget(
                  onTap: () {
                    // Navigate to the play screen
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return UserSelectionPopup(
                          onSelectUser: (user) {
                            // Navigate to the PlayScreen with the selected user
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlayScreen(
                                  key: playScreenKey,
                                  selectedUser: user,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Card(
                    color: Colors.red[200],
                    child: const Center(
                      child: Text(
                        'Play',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SoundButtonWidget(
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
                  child: Card(
                    color: Colors.red[300],
                    child: const Center(
                      child: Text(
                        'Leaderboard',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SoundButtonWidget(
                  onTap: () {
                    // Navigate to the users screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UsersScreen(),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.red[400],
                    child: const Center(
                      child: Text(
                        'Users',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SoundButtonWidget(
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
                  child: Card(
                    color: Colors.red[500],
                    child: const Center(
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SoundButtonWidget(
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
                  child: Card(
                    color: Colors.red[600],
                    child: const Center(
                      child: Text(
                        'Instructions',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
