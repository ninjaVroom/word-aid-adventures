import 'package:hive/hive.dart';

part 'main.g.dart';

@HiveType(typeId: 0)
enum LevelModel {
  @HiveField(0)
  easy,
  
  @HiveField(1)
  medium,

  @HiveField(2)
  difficult,
  
}

Map<String, LevelModel> levelModelToMap() {
  return {for (var value in LevelModel.values) value.toString().split('.')[1]: value};
}

MapEntry<String, LevelModel> getLevelModelEntry(String key) {
  final map = {for (var value in LevelModel.values) value.toString().split('.')[1]: value};
  return map.entries.firstWhere((entry) => entry.key == key);
}