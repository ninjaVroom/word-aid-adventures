import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:word_search_puzzle/models/hive/levels/main.dart';

part 'main.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  int? userId;

  @HiveField(1)
  String? userName;

  @HiveField(2)
  LevelModel? level;

  UserModel({
    this.userId,
    this.userName,
    this.level,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'level': getLevelModelEntry(level!.name),
    };
  }

  Map<String, dynamic> toJson() => toMap();
}
