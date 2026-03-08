import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:karmann/main.dart';

void main() {
  testWidgets('App loads and displays model list', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const KarmannApp());

    // Initially, a loading indicator should be visible.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the Future in fetchModels to complete and the widget to rebuild.
    // The pumpAndSettle will wait for all animations and futures to complete.
    await tester.pumpAndSettle();

    // After loading, the progress indicator should be gone.
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // And the list of models (a GridView) should be visible.
    expect(find.byType(GridView), findsOneWidget);

    // Check if at least one model card is displayed.
    expect(find.byType(Card), findsWidgets);
  });
}
