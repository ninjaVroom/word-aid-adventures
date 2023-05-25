import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_search_puzzle/utils/functions/click_sound.dart';
import 'package:word_search_puzzle/view_models/settings/main.dart';

class SoundButtonWidget extends StatefulWidget {
  final Widget child;
  final void Function()? onTap;
  final String? tooltip;

  const SoundButtonWidget(
      {super.key, required this.child, this.onTap, this.tooltip});

  @override
  State<SoundButtonWidget> createState() => _SoundButtonWidgetState();
}

class _SoundButtonWidgetState extends State<SoundButtonWidget> {
  SettingsViewModel settingsViewModel = SettingsViewModel();

  @override
  Widget build(BuildContext context) {
    settingsViewModel = Provider.of<SettingsViewModel>(context, listen: true);
    return GestureDetector(
      onTap: () {
        if (settingsViewModel.getSettings()!.isAudioOn!) {
          clickPlaySound();
        }
        widget.onTap!();
      },
      child: widget.tooltip == null
          ? widget.child
          : Tooltip(
              message: widget.tooltip,
              child: widget.child,
            ),
    );
  }
}
