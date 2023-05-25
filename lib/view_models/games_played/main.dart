import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:word_search_puzzle/models/hive/games_played/main.dart';
import 'package:word_search_puzzle/models/hive/users/main.dart';

class PlayedViewModel extends ChangeNotifier {
  String boxName = "games_played";
  late final Box<PlayedModel> _playedBox = Hive.box<PlayedModel>(boxName);

  PlayedViewModel();

  Future<void> addPlayed(PlayedModel played) async {
    final existingIndex = _playedBox.values
        .toList()
        .indexWhere((item) => item.user?.userId == played.user?.userId);
    if (existingIndex != -1) {
      await _playedBox.putAt(existingIndex, played);
    } else {
      await _playedBox.add(played);
    }
  }

  Future<void> removePlayed(PlayedModel played) async {
    await played.delete();
  }

  Future<void> updatePlayed(PlayedModel played) async {
    final existingIndex = _playedBox.values
        .toList()
        .indexWhere((item) => item.user?.userId == played.user?.userId);
    if (existingIndex != -1) {
      await _playedBox.putAt(existingIndex, played);
    }
  }

  List<PlayedModel> getAllPlayed() {
    return _playedBox.values.toList();
  }

  PlayedModel? getPlayed(UserModel user) {
    List<PlayedModel> allPlayed = getAllPlayed();
    // print({"allPlayed": allPlayed.map((e) => e.toMap())});
    if (allPlayed.isEmpty) {
      return null;
    } else {
      PlayedModel? played;
      for (var playedItem in allPlayed) {
        if (playedItem.user?.userId == user.userId) {
          played =playedItem;
        }
      }
      return played;
    }
  }
}
