import 'package:word_search_puzzle/models/hive/crossword_answer/main.dart';
import 'package:word_search_safety/word_search_safety.dart';

class CrosswordAnswer {
  bool done = false;
  int indexArray = 0;
  WSLocation wordSearchLocation;
  List<int> answerLines = [];
  final int numBoxPerRow;

  CrosswordAnswer(this.wordSearchLocation, {required this.numBoxPerRow}) {
    indexArray = wordSearchLocation.y * numBoxPerRow + wordSearchLocation.x;

    generateAnswerLine(numBoxPerRow);
  }

  void generateAnswerLine(int numBoxPerRow) {
    answerLines = [];

    answerLines.addAll(
      List<int>.generate(
        wordSearchLocation.overlap,
        (index) => generateIndexBasedOnAxis(
          wordSearchLocation,
          index,
          numBoxPerRow,
        ),
      ),
    );
  }

  generateIndexBasedOnAxis(
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

  CrosswordAnswerModel toCrosswordAnswerModel() {
    Map<String, dynamic> wsLocationMap =
        wordSearchLocationToMap(wordSearchLocation);
    return CrosswordAnswerModel(wsLocationMap, numBoxPerRow: numBoxPerRow);
  }
}
