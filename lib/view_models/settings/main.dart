import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:word_search_puzzle/models/hive/settings/main.dart';

class SettingsViewModel extends ChangeNotifier {
  String boxName = "settings";
  late final Box<SettingsModel> _settingsBox = Hive.box<SettingsModel>(boxName);

  SettingsViewModel();

  void addSettings(SettingsModel settings) {
    if (_settingsBox.isEmpty) {
      _settingsBox.add(settings);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  void updateIsDarkTheme(bool isDarkTheme) {
    final settings = _settingsBox.values.first;
    settings.isDarkTheme = isDarkTheme;
    settings.save();
    notifyListeners();
  }

  void updateIsAudioOn(bool isAudioOn) {
    final settings = _settingsBox.values.first;
    settings.isAudioOn = isAudioOn;
    settings.save();
    notifyListeners();
  }

  SettingsModel? getSettings() {
    if (_settingsBox.isNotEmpty) {
      return _settingsBox.values.first;
    } else {
      addSettings(SettingsModel(isAudioOn: true, isDarkTheme: false));
    }
    return getSettings();
  }
}
