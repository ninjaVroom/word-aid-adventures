import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:word_search_puzzle/models/hive/levels/main.dart';
import 'package:word_search_puzzle/models/hive/users/main.dart';

class UpdateUserPopup extends StatefulWidget {
  final Function(String, LevelModel, int) onUserUpdated;
  final UserModel member;
  final int index;

  const UpdateUserPopup({
    super.key,
    required this.onUserUpdated,
    required this.member,
    required this.index,
  });

  @override
  State<UpdateUserPopup> createState() => _UpdateUserPopupState();
}

class _UpdateUserPopupState extends State<UpdateUserPopup> {
  final _nameController = List.generate(
    5,
    (index) => TextEditingController(),
  );
  // c = levelModelToMap(LevelModel.values);
  TextEditingController _levelController = TextEditingController();
  final _nameFocusNode = List.generate(
    5,
    (index) => FocusNode(),
  );

  @override
  void initState() {
    super.initState();
    
    _levelController = TextEditingController(text: widget.member.level!.name);

    List<String> userNameChars = widget.member.userName!.split('');

    try {
      for (var i = 0; i < userNameChars.length; i++) {
        _nameController[i].text = userNameChars[i];
      }
    } catch (e) {
      if (kDebugMode) {
        print({"e": e});
      }
    }
  }

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
    LevelModel level = getLevelModelEntry(_levelController.text).value;
    // print({"name-name": name, "level-level": level});

    if (name.isNotEmpty) {
      // print({"name": name, "level": level});
      widget.onUserUpdated(name.toUpperCase(), level, widget.member.userId!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update ${widget.member.userName}'),
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
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _levelController.text,
            onChanged: (value) {
              // print({"value-value": value});
              setState(() {
                _levelController.text = value!;
              });
            },
            items: LevelModel.values
                .map<DropdownMenuItem<String>>(( value) {
              return DropdownMenuItem<String>(
                value: value.name,
                child: Text(value.name.toUpperCase()),
              );
            }).toList(),
            decoration: const InputDecoration(
              labelText: 'Level',
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
