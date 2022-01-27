import 'package:flutter_password_calculator/src/validation_rule.dart';
import 'package:flutter_password_calculator/src/commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> loadWidget(
    WidgetTester tester, {
    required String value,
    required List<Color> colors,
    required Set<ValidationRule> rules,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DefaultValidationRulesWidget(
            value: value,
            colors: colors,
            validationRules: rules,
          ),
        ),
      ),
    );
  }

  testWidgets(
    'should build without exploding',
    (tester) async {
      await loadWidget(
        tester,
        value: 'test',
        colors: [Colors.red, Colors.green],
        rules: {},
      );

      expect(find.byType(DefaultValidationRulesWidget), findsOneWidget);
    },
  );

  testWidgets(
    'should show DefaultRulePassedWidget when rule passes',
    (tester) async {
      await loadWidget(
        tester,
        value: 'Test',
        colors: [Colors.red, Colors.green],
        rules: {
          UppercaseValidationRule(),
        },
      );

      expect(find.byType(DefaultRulePassedWidget), findsOneWidget);
    },
  );

  testWidgets(
    'should show DefaultRuleNotPassedWidget when rule does not pass',
    (tester) async {
      await loadWidget(
        tester,
        value: 'test',
        colors: [Colors.red, Colors.green],
        rules: {
          UppercaseValidationRule(),
        },
      );

      expect(find.byType(DefaultRuleNotPassedWidget), findsOneWidget);
    },
  );
}
