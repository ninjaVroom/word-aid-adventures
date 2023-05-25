import 'dart:async';

import 'package:flutter/material.dart';
import 'package:word_search_puzzle/utils/functions/format_stopwatch_time.dart';

GlobalKey<StopwatchScreenState> stopwatchKey =
    GlobalKey<StopwatchScreenState>();

class StopwatchScreen extends StatefulWidget {
  final Function(int) onStopwatchStopped;

  const StopwatchScreen({super.key, required this.onStopwatchStopped});

  @override
  State<StopwatchScreen> createState() => StopwatchScreenState();
}

class StopwatchScreenState extends State<StopwatchScreen> {
  bool isRunning = false;
  int elapsedTime = 0;

  @override
  void dispose() {
    super.dispose();
  }

  void startStopwatch() {
    if (!isRunning) {
      isRunning = true;
      elapsedTime = 0;
      Timer.periodic(const Duration(milliseconds: 10), (timer) {
        if (!isRunning) {
          timer.cancel();
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              elapsedTime += 10;
            });
          });
        }
      });
    }
  }

  void stopStopwatch() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isRunning = false;
      });
    });

    widget.onStopwatchStopped(elapsedTime);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            formatTime(elapsedTime),
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          // const SizedBox(height: 20),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     ElevatedButton(
          //       onPressed: startStopwatch,
          //       child: const Text('Start'),
          //     ),
          //     const SizedBox(width: 20),
          //     ElevatedButton(
          //       onPressed: stopStopwatch,
          //       child: const Text('Stop'),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
