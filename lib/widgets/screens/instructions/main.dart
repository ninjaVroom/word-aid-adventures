import 'package:flutter/material.dart';

class InstructionsScreen extends StatelessWidget {
  const InstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 500, minWidth: 450),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Instructions'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: const [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instructions:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '1. Select Difficulty Level:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '- Easy: Perfect for beginners. Earn 10 points for each word you find.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '- Medium: A moderate challenge. Earn 15 points for each word you find.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '- Difficult: For seasoned word adventurers. Earn 20 points for each word you find.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '2. Gameplay:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '- Tap/click on a letter to start forming a word.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '- Words can be found horizontally or vertically within the grid.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '- To submit a word, tap/click on the last letter of the word.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '- The word box displays a description of the word on tap/click, providing helpful hints.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '3. Level Progression:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '- Start at the easy level. Complete 10 games in each level to unlock the next one.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '- Currently, the difficult level is the final level, offering the most challenging puzzles.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '4. Timer and Scoring:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '- Each game has a time limit. Solve as many words as possible within the given time.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '- The faster you solve the puzzles, the more points you can earn.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '5. Resetting the Game:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '- To start fresh or try a different approach, you can reset the game.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '- The reset option will clear your progress and allow you to begin from the easy level again.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
