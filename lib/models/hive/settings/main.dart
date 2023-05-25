import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'main.g.dart';

@HiveType(typeId: 2)
class SettingsModel extends HiveObject {
  @HiveField(0)
  bool? isDarkTheme;
  
  @HiveField(1)
  bool? isAudioOn;

  SettingsModel({
    this.isDarkTheme,
    this.isAudioOn,
  });

  Map<String, dynamic> toMap() {
    return {
      'isDarkTheme': isDarkTheme,
      'isAudioOn': isAudioOn,
    };
  }

  Map<String, dynamic> toJson() => toMap();
}

