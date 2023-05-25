import 'package:flutter/material.dart';

class CurrentDragObject {
  Offset currentDragPosition = const Offset(0, 0);
  Offset currentTouch = const Offset(0, 0);
  int indexArrayOnTouch = 0;
  List<int> currentDragLine = [];

  CurrentDragObject({
    this.indexArrayOnTouch = 0,
    this.currentTouch = const Offset(0, 0),
  });
}
