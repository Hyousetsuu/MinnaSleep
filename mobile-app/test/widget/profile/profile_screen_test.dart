import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minna_sleep/features/profile/presentation/screens/profile_screen.dart';

void main() {
  testWidgets('ProfileScreen renders loading state initially', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: ProfileScreen(),
        ),
      ),
    );

    // Verify that the CircularProgressIndicator is displayed.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    
    // Pump and settle to let the mock data load
    await tester.pumpAndSettle();
    
    // Verify that the profile data is rendered (e.g., Avatar or Username)
    expect(find.text('@minna_sleeper'), findsOneWidget);
  });
}
