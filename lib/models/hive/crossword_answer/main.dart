import 'package:hive/hive.dart';
import 'package:word_search_puzzle/models/hive/crossword_answer/main_cw.dart';
import 'package:word_search_safety/word_search_safety.dart';

part 'main.g.dart';

@HiveType(typeId: 5)
class CrosswordAnswerModel extends HiveObject {
  @HiveField(0)
  bool done = false;

  @HiveField(1)
  int indexArray = 0;

  @HiveField(2)
  Map<String, dynamic> wordSearchLocation;

  @HiveField(3)
  List<int> answerLines = [];

  @HiveField(4)
  final int numBoxPerRow;

  CrosswordAnswerModel(this.wordSearchLocation, {required this.numBoxPerRow}) {
    WSLocation wordSearchLocationFm =
        wordSearchLocationFromMap(wordSearchLocation);
    indexArray = wordSearchLocationFm.y * numBoxPerRow + wordSearchLocationFm.x;

    generateAnswerLine(numBoxPerRow);
  }

  Map<String, dynamic> wordSearchLocationToMap(WSLocation wsLocation) {
    return wordSearchLocationToMap(wsLocation);
  }

  WSLocation wordSearchLocationFromMap(Map<String, dynamic> map) {
    return wordSearchLocationFromMap(map);
  }

  void generateAnswerLine(int numBoxPerRow) {
    answerLines = [];

    WSLocation wordSearchLocationFm =
        wordSearchLocationFromMap(wordSearchLocation);
    answerLines.addAll(
      List<int>.generate(
        wordSearchLocationFm.overlap,
        (index) => generateIndexBasedOnAxis(
          wordSearchLocationFm,
          index,
          numBoxPerRow,
        ),
      ),
    );
  }

  int generateIndexBasedOnAxis(
      WSLocation wordSearchLocation, int index, int numBoxPerRow) {
    int x = wordSearchLocation.x, y = wordSearchLocation.y;

    if (wordSearchLocation.orientation == WSOrientation.horizontal ||
        wordSearchLocation.orientation == WSOrientation.horizontalBack) {
      x = (wordSearchLocation.orientation == WSOrientation.horizontal)
          ? x + index
          : x - index;
    } else {
      y = (wordSearchLocation.orientation == WSOrientation.vertical)
          ? y + index
          : y - index;
    }

    return x + y * numBoxPerRow;
  }

  CrosswordAnswer toCrosswordAnswer() {
    WSLocation wsLocation = wordSearchLocationFromMap(wordSearchLocation);
    return CrosswordAnswer(wsLocation, numBoxPerRow: numBoxPerRow);
  }
}

Map<String, dynamic> wordSearchLocationToMap(WSLocation wsLocation) {
  return {
    'x': wsLocation.x,
    'y': wsLocation.y,
    'orientation': wsLocation.orientation.toString(),
    'overlap': wsLocation.overlap,
    'word': wsLocation.word,
  };
}

WSLocation wordSearchLocationFromMap(Map<String, dynamic> map) {
  return WSLocation(
    x: map['x'],
    y: map['y'],
    overlap: map['overlap'],
    word: map['word'],
    orientation: WSOrientation.values.firstWhere(
      (value) => value.toString() == map['orientation'],
    ),
  );
}
