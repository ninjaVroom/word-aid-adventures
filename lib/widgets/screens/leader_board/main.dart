import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_search_puzzle/models/hive/scores/main.dart';
import 'package:word_search_puzzle/models/hive/users/main.dart';
import 'package:word_search_puzzle/utils/functions/format_stopwatch_time.dart';
import 'package:word_search_puzzle/view_models/scores/main.dart';

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScoreViewModel>(
      builder: (context, scoreViewModel, _) {
        final List<ScoreModel> scores =
            scoreViewModel.getAllScoresByHighestScore();
        return Container(
          constraints: const BoxConstraints(maxHeight: 550, minWidth: 400),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Leaderboard'),
            ),
            body: Container(
              decoration: BoxDecoration(
                color:
                    Theme.of(context).cardColor, // Set a solid background color
                borderRadius:
                    BorderRadius.circular(10.0), // Apply rounded corners
                boxShadow: const [
                  BoxShadow(
                    color: Colors.red, // Set a green shadow color
                    blurRadius: 5.0, // Apply a blur effect to the shadow
                    offset: Offset(2, 2), // Offset the shadow's position
                  ),
                ],
              ),
              child: ListView.builder(
                itemCount: scores.length,
                itemBuilder: (context, index) {
                  final ScoreModel score = scores[index];
                  if (kDebugMode) {
                    print({"score": score.toMap()});
                  }
                  final UserModel? user = score.user;
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).canvasColor,
                          child: Text(
                            user?.userName![0].toUpperCase() ?? '-',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        title: Text(user?.userName!.toUpperCase() ?? '-'),
                        subtitle: Text(
                            'Time: ${formatTime(score.time ?? 0)}'.toUpperCase()),
                        trailing: Text('Score: ${score.score ?? 0}'.toUpperCase()),
                      ),
                          if (index + 1 == scores.length)
                            const SizedBox(height: 8),
                          const Divider(),
                          const SizedBox(height: 8),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
