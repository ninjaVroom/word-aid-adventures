import 'package:flutter/material.dart';

class PuzzleResetButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PuzzleResetButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red, Colors.redAccent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        ),
        child: const Text(
          'Reset Puzzle',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
