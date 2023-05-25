import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:word_search_puzzle/models/hive/levels/main.dart';

class AddUserPopup extends StatefulWidget {
  final Function(String, LevelModel) onUserAdded;

  const AddUserPopup({super.key, required this.onUserAdded});

  @override
  State<AddUserPopup> createState() => _AddUserPopupState();
}

class _AddUserPopupState extends State<AddUserPopup> {
  final _nameController = List.generate(
    5,
    (index) => TextEditingController(),
  );
  final _levelController = TextEditingController(text: "Easy");
  final _nameFocusNode = List.generate(
    5,
    (index) => FocusNode(),
  );

  @override
  void dispose() {
    _nameController.map((i) => i.dispose());
    _levelController.dispose();
    for (var node in _nameFocusNode) {
      node.dispose();
    }

    super.dispose();
  }

  void _submitForm() {
    final name = _nameController.map((field) => field.text).join("");
    LevelModel level = LevelModel.easy;
    // print({"name-name": name, "level-level": level});

    if (name.isNotEmpty) {
      // print({"name": name, "level": level});
      widget.onUserAdded(name.toUpperCase(), level);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New User'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              5,
              (index) => RawKeyboardListener(
                focusNode: _nameFocusNode[index],
                onKey: (event) {
                  if (event.logicalKey == LogicalKeyboardKey.backspace &&
                      _nameController[index].text.isEmpty &&
                      index > 0) {
                    FocusScope.of(context).previousFocus();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red[600]!,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    controller: _nameController[index],
                    autofocus: index == 0,
                    maxLength: 1,
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 4) {
                        FocusScope.of(context).nextFocus();
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    decoration: const InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Close the dialog
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
