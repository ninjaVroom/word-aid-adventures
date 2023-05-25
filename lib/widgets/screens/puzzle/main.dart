// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:word_search_puzzle/models/hive/crossword_answer/main_cw.dart';
import 'package:word_search_puzzle/models/hive/users/main.dart';
import 'package:word_search_puzzle/utils/class/current_drag_object.dart';
import 'package:word_search_puzzle/utils/functions/random_strings.dart';
import 'package:word_search_puzzle/widgets/buttons/reset_button.dart';
import 'package:word_search_puzzle/widgets/screens/puzzle/play.dart';
import 'package:word_search_puzzle/widgets/screens/puzzle/user_info.dart';
import 'package:word_search_puzzle/widgets/screens/puzzle/word_list.dart';
import 'package:word_search_puzzle/widgets/timer/main.dart';
import 'package:word_search_safety/word_search_safety.dart';

class CrossWordWidget extends StatefulWidget {
  final List<String> wordList;
  final UserModel selectedUser;

  const CrossWordWidget({
    super.key,
    required this.wordList,
    required this.selectedUser,
  });

  @override
  State<CrossWordWidget> createState() => _CrossWordWidgetState();
}

class _CrossWordWidgetState extends State<CrossWordWidget> {
  /// GENERATE CROSSWORD
  ///
  int numBoxPerRow = 8;
  double puzzlePadding = 5;
  Size dragSizeBox = Size.zero;

  late ValueNotifier<List<List<String>>> listChars;
  late ValueNotifier<List<CrosswordAnswer>> answerList;
  late ValueNotifier<CurrentDragObject> currentDragObject;
  late ValueNotifier<List<int>> charsDone;

  int elapsedStopwatchTime = 0;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print({"puzzle starting": "Started"});
    }

    listChars = ValueNotifier<List<List<String>>>([]);
    answerList = ValueNotifier<List<CrosswordAnswer>>([]);
    currentDragObject = ValueNotifier<CurrentDragObject>(CurrentDragObject());
    charsDone = ValueNotifier<List<int>>([]);

    generateRandomWords();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // print({"stopwatchKey.currentState": stopwatchKey.currentState});
      stopwatchKey.currentState!.startStopwatch();
    });
  }

  @override
  Widget build(BuildContext context) {
    // print({"this.wordList": widget.wordList});
    /** GET SIZE */
    Size size = MediaQuery.of(context).size;
    double maxSize = 500.00;
    return ListView(
      children: [
        Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: maxSize,
              child: ArcadeWidget(
                name: widget.selectedUser.userName!.toUpperCase(),
                level: widget.selectedUser.level!.name.toUpperCase(),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: maxSize,
              decoration: BoxDecoration(
                color: Colors.red.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              height: (size.width < maxSize ? size.width : maxSize),
              padding: EdgeInsets.all(puzzlePadding),
              margin: EdgeInsets.all(puzzlePadding + 5),
              child: drawCrosswordBox(),
            ),
            Container(
              alignment: Alignment.topLeft,
              width: maxSize,
              padding: EdgeInsets.all(puzzlePadding),
              margin: EdgeInsets.all(puzzlePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                    ),
                    width: (size.width < maxSize ? size.width : maxSize) / 2.0,
                    // height: 200,
                    child: Column(
                      children: [
                        StopwatchScreen(
                          key: stopwatchKey,
                          onStopwatchStopped: (p0) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() => elapsedStopwatchTime = p0);
                            });
                          },
                        ),
                        PuzzleResetButton(onPressed: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            playScreenKey.currentState!.setState(() {
                              playScreenKey.currentState!.level =
                                  widget.selectedUser.level!;
                              playScreenKey.currentState!.puzzleKey =
                                  Key(generateRandomString(10).toString());
                            });
                            setState(() => elapsedStopwatchTime = 0);
                            stopwatchKey.currentState!.setState(() {
                              stopwatchKey.currentState!.elapsedTime = 0;
                            });
                          });
                        }),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                    ),
                    width: (size.width < maxSize ? size.width : maxSize) / 2.6,
                    child: drawAnswerList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  onDragEnd(PointerUpEvent? event) {
    if (kDebugMode) {
      // print({"PointerUpEvent": event});
    }

    // if (currentDragObject.value.currentDragLine == null) return;

    currentDragObject.value.currentDragLine.clear();
    currentDragObject.notifyListeners();
  }

  onDragUpdate(PointerMoveEvent event) {
    if (kDebugMode) {
      // print({"PointerMoveEvent": event});
    }

    generateLineOnDrag(event);

    // get index on drag

    int indexFound = answerList.value.indexWhere((answer) {
      return answer.answerLines.join("-") ==
          currentDragObject.value.currentDragLine.join("-");
    });

    if (indexFound >= 0) {
      answerList.value[indexFound].done = true;

      charsDone.value.addAll(answerList.value[indexFound].answerLines);
      charsDone.notifyListeners();
      answerList.notifyListeners();
      onDragEnd(null);
    }
  }

  onDragStart(int indexArray) {
    try {
      List<CrosswordAnswer> indexSelectedList = answerList.value
          .where((answer) => answer.indexArray == indexArray)
          .toList();

      if (indexSelectedList.isEmpty) return;

      if (kDebugMode) {
        // print({"onDragStart": indexArray});
      }

      currentDragObject.value.indexArrayOnTouch = indexArray;
      currentDragObject.notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print({"onDragStart-try--error-catch": e});
      }
    }
  }

  int calculateIndexBaseLocalPosition(Offset localPosition) {
    double maxSizeBox =
        ((dragSizeBox.width - (numBoxPerRow - 1) * puzzlePadding) /
            numBoxPerRow);

    if (localPosition.dy > dragSizeBox.width ||
        localPosition.dx > dragSizeBox.width) return -1;

    int x = 0, y = 0;
    double yAxis = 0, xAxis = 0;
    double yAxisStart = 0, xAxisStart = 0;

    for (var i = 0; i < numBoxPerRow; i++) {
      xAxisStart = xAxis;
      xAxis += maxSizeBox +
          (i == 0 || i == (numBoxPerRow - 1)
              ? puzzlePadding / 2
              : puzzlePadding);

      if (xAxisStart < localPosition.dx && xAxis > localPosition.dx) {
        x = i;
        break;
      }
    }

    for (var i = 0; i < numBoxPerRow; i++) {
      yAxisStart = yAxis;
      yAxis += maxSizeBox +
          (i == 0 || i == (numBoxPerRow - 1)
              ? puzzlePadding / 2
              : puzzlePadding);

      if (yAxisStart < localPosition.dy && yAxis > localPosition.dy) {
        y = i;
        break;
      }
    }

    return y * numBoxPerRow + x;
  }

  void generateLineOnDrag(PointerMoveEvent event) {
    // currentDragObject.value.currentDragLine ??= [];

    int indexBase = calculateIndexBaseLocalPosition(event.localPosition);

    if (indexBase >= 0) {
      // check if drag line has already passed 2 boxes
      if (currentDragObject.value.currentDragLine.length >= 2) {
        // check if drag line is a straight line
        WSOrientation wsOrientation;

        if (currentDragObject.value.currentDragLine[0] % numBoxPerRow ==
            currentDragObject.value.currentDragLine[1] % numBoxPerRow) {
          wsOrientation = WSOrientation.vertical;
        } else {
          if (currentDragObject.value.currentDragLine[0] ~/ numBoxPerRow ==
              currentDragObject.value.currentDragLine[1] ~/ numBoxPerRow) {
            wsOrientation = WSOrientation.horizontal;
          } else {
            wsOrientation = WSOrientation.diagonal;
          }
        }

        if (wsOrientation == WSOrientation.horizontal) {
          if (indexBase ~/ numBoxPerRow !=
              currentDragObject.value.currentDragLine[1] ~/ numBoxPerRow) {
            onDragEnd(null);
          }
        } else {
          if (wsOrientation == WSOrientation.vertical) {
            if (indexBase % numBoxPerRow !=
                currentDragObject.value.currentDragLine[1] % numBoxPerRow) {
              onDragEnd(null);
            }
          } else {
            onDragEnd(null);
          }
        }
      }
    }

    if (!currentDragObject.value.currentDragLine.contains(indexBase)) {
      currentDragObject.value.currentDragLine.add(indexBase);
    } else {
      if (currentDragObject.value.currentDragLine.length >= 2) {
        if (currentDragObject.value.currentDragLine[
                currentDragObject.value.currentDragLine.length - 2] ==
            indexBase) {
          onDragEnd(null);
        }
      }
    }

    currentDragObject.notifyListeners();
  }

  Widget drawCrosswordBox() {
    return Listener(
      onPointerUp: (event) => onDragEnd(event),
      onPointerMove: (event) => onDragUpdate(event),
      child: LayoutBuilder(
        builder: (context, constraints) {
          dragSizeBox = Size(constraints.maxWidth, constraints.maxWidth);
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              crossAxisCount: numBoxPerRow,
              crossAxisSpacing: puzzlePadding / 1.6,
              mainAxisSpacing: puzzlePadding / 1.6,
            ),
            itemCount: numBoxPerRow * numBoxPerRow,
            itemBuilder: (context, index) {
              String char =
                  listChars.value.expand((element) => element).toList()[index];
              if (kDebugMode) {
                // print({"char-$index": char});
              }
              return Listener(
                onPointerDown: (event) => onDragStart(index),
                child: ValueListenableBuilder(
                  valueListenable: currentDragObject,
                  builder: (context, value, child) {
                    Color color = Theme.of(context).cardColor;

                    if (value.currentDragLine.contains(index)) {
                      color = Colors.yellowAccent.shade100;
                    } else {
                      if (charsDone.value.contains((index))) {
                        color = Colors.redAccent.shade100;
                      }
                    }
                    return Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        char.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget drawAnswerList() {
    return ValueListenableBuilder(
      valueListenable: answerList,
      builder: (context, List<CrosswordAnswer> value, child) {
        return PuzzleWordList(
          answerList: value,
          listChars: listChars.value,
          selectedUser: widget.selectedUser,
          elapsedStopwatchTime: elapsedStopwatchTime,
          stopwatchKey: stopwatchKey,
        );
      },
    );
  }

  void generateRandomWords() {
    // cross-word generator
    // List<String> wordList = [
    //   'hello',
    //   'who',
    //   'john',
    //   'you',
    //   'what',
    //   'are',
    //   'Mary',
    //   'here',
    //   'forever'
    // ];
    final List<String> wordList = widget.wordList;
    // print({"wordList---wordList": wordList});

    // Puzzle Settings Object
    final WSSettings wordSearchSettings = WSSettings(
      width: numBoxPerRow,
      height: numBoxPerRow,
      orientations: List.from([
        WSOrientation.horizontal,
        WSOrientation.horizontalBack,
        WSOrientation.vertical,
        WSOrientation.verticalUp,
        // WSOrientation.diagonal,
        // WSOrientation.diagonalUp,
        // WSOrientation.diagonalBack,
        // WSOrientation.diagonalUpBack,
      ]),
    );

    // Create new instance of the WordSearch class
    final WordSearchSafety wordSearch = WordSearchSafety();

    // Create a new puzzle
    final WSNewPuzzle newPuzzle =
        wordSearch.newPuzzle(wordList, wordSearchSettings);

    /// Check if there are errors generated while creating the puzzle
    if (newPuzzle.errors!.isEmpty) {
      // The puzzle output
      if (kDebugMode) {
        // print(newPuzzle.toString());
      }

      listChars.value = newPuzzle.puzzle!;
      if (kDebugMode) {
        // print({"listChars.value": listChars.value.toString()});
      }

      final WSSolved solved = wordSearch.solvePuzzle(listChars.value, wordList);
      answerList.value = solved.found!
          .map((solve) => CrosswordAnswer(solve, numBoxPerRow: numBoxPerRow))
          .toList();
    }
  }
}
