// ignore_for_file: file_names
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'dart:math';

// enum EsayMediumDifficultLevels {
//   esay,
//   medium,
//   difficult,
// }

// Future<List<String>> loadJsonWordBankData(
//     EsayMediumDifficultLevels level) async {
//   if (level == EsayMediumDifficultLevels.esay) {
//     String easyJson =
//         await rootBundle.loadString('assets/json/easy_level.json');
//     Map<String, dynamic> easyData = jsonDecode(easyJson);
//     List<String> easyWords = List<String>.from(easyData['words']);
//     if (kDebugMode) {
//       print('Easy words: $easyWords');
//     }
//     return getRandomList(easyWords, count: 4);
//   } else if (level == EsayMediumDifficultLevels.medium) {
//     String mediumJson =
//         await rootBundle.loadString('assets/json/medium_level.json');
//     Map<String, dynamic> mediumData = jsonDecode(mediumJson);
//     List<String> mediumWords = List<String>.from(mediumData['words']);
//     if (kDebugMode) {
//       print('Medium words: $mediumWords');
//     }
//     return getRandomList(mediumWords, count: 8);
//   } else {
//     String difficultJson =
//         await rootBundle.loadString('assets/json/difficult_level.json');
//     Map<String, dynamic> difficultData = jsonDecode(difficultJson);
//     List<String> difficultWords = List<String>.from(difficultData['words']);
//     if (kDebugMode) {
//       print('Difficult words: $difficultWords');
//     }
//     return getRandomList(difficultWords, count: 16);
//   }
// }

// List<String> getRandomList(List<String> wordList, {int count = 4}) {
//   // Generate 4 random indices
//   List<int> randomIndices =
//       List.generate(count, (index) => Random().nextInt(wordList.length));

//   // Retrieve the words at the random indices
//   return randomIndices.map((index) => wordList[index]).toList();
// }
