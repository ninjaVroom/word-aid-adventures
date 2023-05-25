import 'package:flutter/material.dart';

class PopUpModal extends StatelessWidget {
  final String word;

  const PopUpModal({
    Key? key,
    required this.word,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Word: $word",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              FutureBuilder(
                // future: getWordInfo(word),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      "Definition: ${snapshot.data}",
                      style: const TextStyle(fontSize: 16),
                    );
                  } else {
                    return const Text("Loading...");
                  }
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
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
