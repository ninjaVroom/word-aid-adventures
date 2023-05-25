import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:word_search_puzzle/main.dart';

void main() {
  testWidgets('App title and theme test', (WidgetTester tester) async {
    await tester.pumpWidget(const WordAidAdventures());

    // Verify the initial app title
    expect(find.text('Crossword Puzzle'), findsOneWidget);

    // Verify the app theme
    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    final ThemeData? themeData = app.theme;
    expect(themeData?.primaryColor, Colors.red);
    expect(themeData?.secondaryHeaderColor, Colors.white);
    expect(app.theme?.appBarTheme.backgroundColor, Colors.white);
    expect(app.theme?.appBarTheme.foregroundColor, Colors.red);
  });
}
