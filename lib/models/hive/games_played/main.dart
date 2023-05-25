import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:word_search_puzzle/models/hive/levels/main.dart';
import 'package:word_search_puzzle/models/hive/users/main.dart';

part 'main.g.dart';

@HiveType(typeId: 3)
class PlayedModel extends HiveObject {
  @HiveField(0)
  UserModel? user;

  @HiveField(1)
  LevelModel? level;

  @HiveField(2)
  int? numPlayed;

  PlayedModel({
    this.user,
    this.level,
    this.numPlayed,
  });
  Map<String, dynamic> toMap() {
    return {
      'user': user?.toMap(),
      'level': level!.name,
      'numPlayed': numPlayed,
    };
  }
}
