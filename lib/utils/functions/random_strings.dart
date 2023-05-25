import 'dart:math';

String generateRandomString(int length) {
  final random = Random();
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';

  String result = '';
  for (int i = 0; i < length; i++) {
    final randomIndex = random.nextInt(chars.length);
    result += chars[randomIndex];
  }

  return result;
}
