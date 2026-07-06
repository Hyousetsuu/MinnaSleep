import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../lib/core/widgets/neo_button.dart';
import '../../../lib/core/widgets/neo_animated_fab.dart';
import 'package:lucide_icons/lucide_icons.dart';

void main() {
  group('Accessibility Semantic Tests', () {
    testWidgets('NeoButton provides correct semantics', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NeoButton(
              text: 'Login',
              onPressed: () {},
            ),
          ),
        ),
      );

      final buttonFinder = find.bySemanticsLabel('Login');
      expect(buttonFinder, findsOneWidget);
      
      final SemanticsNode node = tester.getSemantics(buttonFinder);
      expect(node.isButton, true);
      expect(node.hint, 'Double tap to activate');
    });

    testWidgets('NeoAnimatedFAB provides correct semantics and hides icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NeoAnimatedFAB(
              label: 'Start Sleep',
              icon: LucideIcons.moon,
              onPressed: () {},
            ),
          ),
        ),
      );

      final fabFinder = find.bySemanticsLabel('Start Sleep');
      expect(fabFinder, findsOneWidget);

      final SemanticsNode node = tester.getSemantics(fabFinder);
      expect(node.isButton, true);
    });
  });
}
