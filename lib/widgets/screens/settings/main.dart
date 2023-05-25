import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_search_puzzle/view_models/settings/main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsViewModel settingsViewModel = SettingsViewModel();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    settingsViewModel = Provider.of<SettingsViewModel>(context, listen: true);
    bool isAudioOn = settingsViewModel.getSettings()!.isAudioOn!;
    bool isDarkTheme = settingsViewModel.getSettings()!.isDarkTheme!;
    return Container(
      constraints: const BoxConstraints(maxHeight: 250, minWidth: 450),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: const Text(
                      "Theme",
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: const Text("Toggle Dark/ Light Mode"),
                    trailing: IconButton(
                      onPressed: () {
                        settingsViewModel.updateIsDarkTheme(!isDarkTheme);
                      },
                      icon: Icon(
                        isDarkTheme
                            ? Icons.dark_mode_outlined
                            : Icons.light_mode_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  ListTile(
                    title: const Text(
                      "Sound",
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: const Text("On/ Off"),
                    trailing: IconButton(
                      onPressed: () {
                        settingsViewModel.updateIsAudioOn(!isAudioOn);
                      },
                      icon: Icon(
                        isAudioOn
                            ? Icons.music_note_outlined
                            : Icons.music_off_outlined,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
