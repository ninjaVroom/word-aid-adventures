import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_search_puzzle/models/hive/crossword_answer/main_cw.dart';
import 'package:word_search_puzzle/models/hive/games_played/main.dart';
import 'package:word_search_puzzle/models/hive/levels/main.dart';
import 'package:word_search_puzzle/models/hive/scores/main.dart';
import 'package:word_search_puzzle/models/hive/users/main.dart';
import 'package:word_search_puzzle/utils/functions/click_sound.dart';
import 'package:word_search_puzzle/utils/functions/random_strings.dart';
import 'package:word_search_puzzle/view_models/games_played/main.dart';
import 'package:word_search_puzzle/view_models/scores/main.dart';
import 'package:word_search_puzzle/view_models/users/main.dart';
import 'package:word_search_puzzle/widgets/buttons/sound_button.dart';
import 'package:word_search_puzzle/widgets/popup/word_info.dart';
import 'package:word_search_puzzle/widgets/screens/puzzle/congratulations.dart';
import 'package:word_search_puzzle/widgets/screens/puzzle/play.dart';
import 'package:word_search_puzzle/widgets/timer/main.dart';

class PuzzleWordList extends StatefulWidget {
  final List<CrosswordAnswer> answerList;
  final List<List<String>> listChars;
  final UserModel selectedUser;
  final int elapsedStopwatchTime;
  final GlobalKey<StopwatchScreenState> stopwatchKey;

  const PuzzleWordList({
    super.key,
    required this.answerList,
    required this.selectedUser,
    this.elapsedStopwatchTime = 0,
    required this.stopwatchKey,
    required this.listChars,
  });

  @override
  State<PuzzleWordList> createState() => _PuzzleWordListState();
}

class _PuzzleWordListState extends State<PuzzleWordList> {
  bool puzzledSolvedSuccess = false;
  UserViewModel userViewModel = UserViewModel();
  ScoreViewModel scoreViewModel = ScoreViewModel();
  PlayedViewModel playedViewModel = PlayedViewModel();

  @override
  Widget build(BuildContext context) {
    userViewModel = Provider.of<UserViewModel>(context, listen: false);
    scoreViewModel = Provider.of<ScoreViewModel>(context, listen: false);
    playedViewModel = Provider.of<PlayedViewModel>(context, listen: false);
    // for (var answer in widget.answerList) {
    //   if (kDebugMode) {
    //     print({
    //       "answer.done": answer.done,
    //       "answer": answer.wordSearchLocation.word,
    //     });
    //   }
    // }
    if (!puzzledSolvedSuccess) {
      puzzledSolved();
    }
    int totalColsPerRow = 1;
    List<Widget> list = List.generate(
      (widget.answerList.length ~/ totalColsPerRow) +
          ((widget.answerList.length % totalColsPerRow) > 0 ? 1 : 0),
      (int index) {
        int maxColumn = (index + 1) * totalColsPerRow;
        return Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
                maxColumn > widget.answerList.length
                    ? maxColumn - widget.answerList.length
                    : totalColsPerRow, ((indexChild) {
              int indexArray = (index) * totalColsPerRow + indexChild;

              bool indexExists = indexArray < widget.answerList.length;
              return indexExists
                  ? SoundButtonWidget(
                      onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return WordInfoModal(
                            word: widget
                                .answerList[indexArray].wordSearchLocation.word,
                            level: widget.selectedUser.level!,
                          );
                        },
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 250, 243, 243),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        width: double.maxFinite,
                        child: Text(
                          widget.answerList[indexArray].wordSearchLocation.word,
                          style: TextStyle(
                            fontSize: 15,
                            color: widget.answerList[indexArray].done
                                ? Colors.green
                                : Colors.black,
                            decoration: widget.answerList[indexArray].done
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                    )
                  : Container();
            })),
          ),
        );
      },
    );
    return Column(children: list);
  }

  void puzzledSolved() {
    int puzzleLength = widget.answerList.length;
    int solvedLength = 0;
    for (var word in widget.answerList) {
      if (word.done) solvedLength += 1;
    }
    if (solvedLength == puzzleLength) {
      // if (solvedLength > 0) {
      widget.stopwatchKey.currentState!.stopStopwatch();
      savePuzzleSolved(widget.stopwatchKey.currentState!.elapsedTime);
      playYaySound();

      if (kDebugMode) {
        print({
          "puzzle :": "Solved",
          "widget.elapsedStopwatchTime": widget.elapsedStopwatchTime,
          "widget.stopwatchKey.currentState!.elapsedTime":
              widget.stopwatchKey.currentState!.elapsedTime
        });
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          puzzledSolvedSuccess = true;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CongratulationsPopup(
              userName: widget.selectedUser.userName!,
              onPlayAgain: () {
                Navigator.of(context).pop();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  playScreenKey.currentState!.setState(() {
                    playScreenKey.currentState!.level =
                        widget.selectedUser.level!;
                    playScreenKey.currentState!.puzzleKey =
                        Key(generateRandomString(10).toString());
                  });
                });
              },
            );
          },
        );
      });
    }
  }

  savePuzzleSolved(int time) {
    int score = scoreGenerator(
      widget.selectedUser.level!,
      widget.answerList.length,
    );

    if (kDebugMode) {
      // print({"score-score": score});
    }
    ScoreModel scoreModel = ScoreModel(
      // answerList:
      //     widget.answerList.map((e) => e.toCrosswordAnswerModel()).toList(),
      listChars: widget.listChars,
      score: score,
      time: time,
      user: widget.selectedUser,
      wordList: widget.answerList.map((e) {
        return e.wordSearchLocation.word;
      }).toList(),
    );
    if (kDebugMode) {
      print({'scoreModel-scoreModel': scoreModel.toMap()});
    }
    scoreViewModel.addScore(scoreModel);

    updateGamesPlayed();
  }

  int scoreGenerator(LevelModel level, int wordCount) {
    int perWordScore = 0;
    if (level == LevelModel.easy) {
      perWordScore = 10;
    } else if (level == LevelModel.medium) {
      perWordScore = 15;
    } else {
      perWordScore = 20;
    }

    ScoreModel? lastScore;
    List<ScoreModel>? lastScores =
        scoreViewModel.getUserScore(widget.selectedUser);
    if (lastScores != null && lastScores.isNotEmpty) {
      lastScore = lastScores.first;
    }
    if (lastScore == null) {
      return perWordScore * wordCount;
    } else {
      return (perWordScore * wordCount) + lastScore.score!;
    }
  }

  void updateGamesPlayed() {
    PlayedModel? userPlayed = playedViewModel.getPlayed(widget.selectedUser);
    // print({"userPlayed": userPlayed});
    if (userPlayed == null) {
      playedViewModel.addPlayed(PlayedModel(
        user: widget.selectedUser,
        level: widget.selectedUser.level,
        numPlayed: 1,
      ));
    } else {
      userPlayed.numPlayed = userPlayed.numPlayed! + 1;
      playedViewModel.updatePlayed(userPlayed);
      updateUserLevel(userPlayed.numPlayed);
    }
  }

  void updateUserLevel(numPlayed) {
    LevelModel level = widget.selectedUser.level!;
    if (numPlayed > 10 && numPlayed < 20) {
      level = LevelModel.medium;
    } else if (numPlayed > 20) {
      level = LevelModel.difficult;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      userViewModel.updateUser(
        widget.selectedUser.userId!,
        userName: widget.selectedUser.userName,
        level: level,
      );
    });
  }
}
