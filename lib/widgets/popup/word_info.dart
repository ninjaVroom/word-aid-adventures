import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:word_search_puzzle/models/hive/levels/main.dart';
import 'package:word_search_puzzle/utils/functions/word_bank.dart';

class WordInfoModal extends StatefulWidget {
  final String word;
  final LevelModel level;

  const WordInfoModal({
    super.key,
    required this.word,
    required this.level,
  });

  @override
  State<WordInfoModal> createState() => _WordInfoModalState();
}

class _WordInfoModalState extends State<WordInfoModal> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.word,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            FutureBuilder<String>(
              future: getWordDescription(
                widget.level,
                widget.word,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // print({"snapshot.data": snapshot.data});
                  // return Text(snapshot.data.toString());
                  return Text(snapshot.data!);
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                } else {
                  return const Center(
                    child: SpinKitFadingCircle(
                      color: Colors.blue,
                      size: 50.0,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
