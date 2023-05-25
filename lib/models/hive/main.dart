import 'package:hive/hive.dart';
import 'package:word_search_puzzle/models/hive/games_played/main.dart';
import 'package:word_search_puzzle/models/hive/scores/main.dart';
import 'package:word_search_puzzle/models/hive/settings/main.dart';
import 'package:word_search_puzzle/models/hive/users/main.dart';
import 'package:word_search_puzzle/view_models/games_played/main.dart';
import 'package:word_search_puzzle/view_models/scores/main.dart';
import 'package:word_search_puzzle/view_models/settings/main.dart';
import 'package:word_search_puzzle/view_models/users/main.dart';

openHiveDbsFunction() async {
  await Hive.openBox<UserModel>(UserViewModel().boxName);
  await Hive.openBox<SettingsModel>(SettingsViewModel().boxName);
  await Hive.openBox<ScoreModel>(ScoreViewModel().boxName);
  await Hive.openBox<PlayedModel>(PlayedViewModel().boxName);
}
