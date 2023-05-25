import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:word_search_puzzle/models/hive/crossword_answer/main.dart';
import 'package:word_search_puzzle/models/hive/games_played/main.dart';
import 'package:word_search_puzzle/models/hive/levels/main.dart';
import 'package:word_search_puzzle/models/hive/main.dart';
import 'package:word_search_puzzle/models/hive/scores/main.dart';
import 'package:word_search_puzzle/models/hive/settings/main.dart';
import 'package:word_search_puzzle/models/hive/users/main.dart';
import 'package:word_search_puzzle/splash_screen.dart';
import 'package:word_search_puzzle/view_models/main.dart';
import 'package:word_search_puzzle/view_models/settings/main.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!kIsWeb) {
    Directory applicationDocumentsDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    // Hive.init(applicationDocumentsDirectory.path);
    Hive
      ..init(applicationDocumentsDirectory.path)
      ..registerAdapter(LevelModelAdapter())
      ..registerAdapter(UserModelAdapter())
      ..registerAdapter(SettingsModelAdapter())
      ..registerAdapter(PlayedModelAdapter())
      ..registerAdapter(ScoreModelAdapter())
      ..registerAdapter(CrosswordAnswerModelAdapter());
  }

  await openHiveDbsFunction();

  runApp(
    MultiProvider(
      providers: notifierProvidersFunction(),
      child: const WordAidAdventures(),
    ),
  );
}

/// This is a crossword puzzle app.
class WordAidAdventures extends StatefulWidget {
  const WordAidAdventures({super.key, Key? key2});

  @override
  State<WordAidAdventures> createState() => _WordAidAdventuresState();
}

class _WordAidAdventuresState extends State<WordAidAdventures> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word Aid Adventures',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.red,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
          brightness: Brightness.dark,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).cardColor,
          foregroundColor: Colors.red,
        ),
      ),
      themeMode:
          Provider.of<SettingsViewModel>(context).getSettings()?.isDarkTheme ==
                  true
              ? ThemeMode.dark
              : ThemeMode.light,
      home: const SafeArea(child: SplashScreen()),
    );
  }
}
