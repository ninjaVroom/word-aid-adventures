import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:word_search_puzzle/view_models/games_played/main.dart';
import 'package:word_search_puzzle/view_models/scores/main.dart';
import 'package:word_search_puzzle/view_models/settings/main.dart';
import 'package:word_search_puzzle/view_models/users/main.dart';

List<SingleChildWidget> notifierProvidersFunction() {
  return [
    ChangeNotifierProvider(
      create: (context) => UserViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => SettingsViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => ScoreViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => PlayedViewModel(),
    ),
  ];
}
