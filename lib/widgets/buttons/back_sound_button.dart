import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_search_puzzle/utils/functions/click_sound.dart';
import 'package:word_search_puzzle/view_models/settings/main.dart';

class BackSoundButton extends StatefulWidget {
  final void Function()? onPressed;
  const BackSoundButton({super.key, this.onPressed});

  @override
  State<BackSoundButton> createState() => _BackSoundButtonState();
}

class _BackSoundButtonState extends State<BackSoundButton> {
  SettingsViewModel settingsViewModel = SettingsViewModel();
  @override
  Widget build(BuildContext context) {
    settingsViewModel = Provider.of<SettingsViewModel>(context, listen: true);
    return BackButton(
      color: Theme.of(context).appBarTheme.foregroundColor,
      onPressed: () {
        if (settingsViewModel.getSettings()!.isAudioOn!) {
          clickPlaySound();
        }
        if (widget.onPressed != null) {
        widget.onPressed!();
        }

        Navigator.of(context).pop();
      },
    );
  }
}
