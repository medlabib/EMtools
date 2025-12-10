// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:emtools/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('App launches without errors', (WidgetTester tester) async {
    // Mock SharedPreferences
    SharedPreferences.setMockInitialValues({});

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: EMToolsApp(),
      ),
    );
    
    // Wait for all animations to complete (AnimatedToolCard has timers)
    await tester.pumpAndSettle();
    
    // Verify the app builds without throwing
    expect(find.byType(EMToolsApp), findsOneWidget);
  });
}
