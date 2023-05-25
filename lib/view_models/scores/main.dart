import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:word_search_puzzle/models/hive/scores/main.dart';
import 'package:word_search_puzzle/models/hive/users/main.dart';

class ScoreViewModel extends ChangeNotifier {
  String boxName = "scores";
  late final Box<ScoreModel> _scoreBox = Hive.box<ScoreModel>(boxName);

  ScoreViewModel();

  Future<void> addScore(ScoreModel score) async {
    await _scoreBox.add(score);
  }


  // Future<void> removeScore(ScoreModel score) async {
  //   await score.delete();
  // }

  // Future<void> updateScore(ScoreModel score) async {
  //   await score.save();
  // }

  List<ScoreModel> getAllScores() {
    return _scoreBox.values.toList();
  }

  ScoreModel? getScore(int index) {
    if (index >= 0 && index < _scoreBox.length) {
      return _scoreBox.getAt(index);
    }
    return null;
  }

  List<ScoreModel>? getUserScore(UserModel user) {
  final scores = _scoreBox.values.where((score) => score.user?.userId == user.userId).toList();
  if (scores.isNotEmpty) {
    // Assuming you want to return the largest score for the user
    scores.sort((a, b) => (b.score ?? 0).compareTo(a.score ?? 0));
    return scores;
  }
  return null;
}


  List<ScoreModel> getAllScoresByHighestScore() {
    final List<ScoreModel> scores = getAllScores();
    if (kDebugMode) {
      print({"scores-scores": scores.map((e) => e.toMap())});
    }
    scores.sort((a, b) => (b.score ?? 0).compareTo(a.score ?? 0));
    return scores;
  }
}
