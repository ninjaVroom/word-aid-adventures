String formatTime(int milliseconds) {
  int minutes = (milliseconds / (1000 * 60)).floor();
  int seconds = ((milliseconds / 1000) % 60).floor();
  int millisecondsPart = (milliseconds % 1000) ~/ 10;

  String minutesStr = minutes.toString().padLeft(2, '0');
  String secondsStr = seconds.toString().padLeft(2, '0');
  String millisecondsStr = millisecondsPart.toString().padLeft(2, '0');

  return '$minutesStr:$secondsStr:$millisecondsStr';
}
