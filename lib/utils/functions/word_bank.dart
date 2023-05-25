import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';

import 'package:word_search_puzzle/models/hive/levels/main.dart';


Future<List<String>> loadJsonWordBankData(
    LevelModel level) async {
  if (level == LevelModel.easy) {
    String easyJson =
        await rootBundle.loadString('assets/json/easy_level.json');
    Map<String, dynamic> easyData = jsonDecode(easyJson);
    List<String> easyWords =
        getWordsFromJson(List<Object>.from(easyData['words']));
    if (kDebugMode) {
      // print('Easy words: $easyWords');
    }
    // return getRandomList(easyWords, count: 4);
    return getRandomListWithMaxLength(easyWords, count: 4);
  } else if (level == LevelModel.medium) {
    String mediumJson =
        await rootBundle.loadString('assets/json/medium_level.json');
    Map<String, dynamic> mediumData = jsonDecode(mediumJson);
    List<String> mediumWords =
        getWordsFromJson(List<Object>.from(mediumData['words']));
    if (kDebugMode) {
      // print('Medium words: $mediumWords');
    }
    // return getRandomList(mediumWords, count: 8);
    return getRandomListWithMaxLength(mediumWords, count: 5);
  } else {
    String difficultJson =
        await rootBundle.loadString('assets/json/difficult_level.json');
    Map<String, dynamic> difficultData = jsonDecode(difficultJson);
    List<String> difficultWords =
        getWordsFromJson(List<Object>.from(difficultData['words']));
    if (kDebugMode) {
      // print('Difficult words: $difficultWords');
    }
    // return getRandomList(difficultWords, count: 16);
    return getRandomListWithMaxLength(difficultWords, count: 6);
  }
}

List<String> getWordsFromJson(List<Object> objList) {
  List<String> words = [];

  // print({"objList-objList": objList});
  for (var obj in objList) {
    if (obj is Map<String, dynamic> && obj['word'] != null) {
      words.add(obj['word']);
    }
  }
  return words;
}

List<String> getRandomList(List<String> wordList, {int count = 4}) {
  // Generate x random indices
  Set<int> randomIndices = {};
  while (randomIndices.length < count) {
    int randomIndex = Random().nextInt(wordList.length);
    randomIndices.add(randomIndex);
  }

  // Retrieve the words at the random indices
  return randomIndices.map((index) => wordList[index]).toList();
}

// Define a function to search for a word and return its description
Future<String> getWordDescription(
    LevelModel level, String word) async {
  // Load the JSON data
  String jsonString;
  if (level == LevelModel.easy) {
    jsonString = await rootBundle.loadString('assets/json/easy_level.json');
  } else if (level == LevelModel.medium) {
    jsonString = await rootBundle.loadString('assets/json/medium_level.json');
  } else {
    jsonString =
        await rootBundle.loadString('assets/json/difficult_level.json');
  }

  // Decode the JSON data
  Map<String, dynamic> data = jsonDecode(jsonString);

  // Search for the word in the data
  dynamic wordData =
      data['words'].firstWhere((element) => element['word'] == word);

  // Return the description
  return wordData['description'];
}

List<Map<String, String>> filterWordsByLength(
    List<Map<String, String>> words, int maxLength) {
  return words.where((word) => word['word']!.length <= maxLength).toList();
}

List<String> getRandomListWithMaxLength(List<String> wordList,
    {int count = 4}) {
  int maxLength = 7;
  // Filter words by length
  final filteredWords =
      wordList.where((word) => word.length <= maxLength).toList();

  // Generate x random indices
  Set<int> randomIndices = {};
  while (randomIndices.length < count) {
    int randomIndex = Random().nextInt(filteredWords.length);
    randomIndices.add(randomIndex);
  }

  // Retrieve the words at the random indices
  return randomIndices.map((index) => filteredWords[index]).toList();
}
