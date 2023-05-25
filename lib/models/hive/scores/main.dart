import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:word_search_puzzle/models/hive/users/main.dart';
// import 'package:word_search_puzzle/models/hive/crossword_answer/main.dart';

part 'main.g.dart';

@HiveType(typeId: 4)
class ScoreModel extends HiveObject {
  @HiveField(0)
  UserModel? user;

  @HiveField(1)
  List<List<String>>? listChars;

  @HiveField(2)
  List<String>? wordList;

  @HiveField(3)
  int? score;

  @HiveField(4)
  int? time;

  // @HiveField(5)
  // final List<CrosswordAnswerModel> answerList;

  ScoreModel({
    this.user,
    this.listChars,
    this.wordList,
    this.score,
    this.time,
    // required this.answerList,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user?.toMap(),
      'listChars': listChars,
      'wordList': wordList,
      'score': score,
      'time': time,
      // 'answerList': answerList,
    };
  }
}
