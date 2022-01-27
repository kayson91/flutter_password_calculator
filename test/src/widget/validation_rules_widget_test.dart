import 'package:flutter_password_calculator/src/validation_rule.dart';
import 'package:flutter_password_calculator/src/commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> loadWidget(
    WidgetTester tester, {
    required ValidationRulesBuilder? builder,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ValidationRulesWidget(
            password: 'password',
            colors: const [Colors.red, Colors.green],
            validationRules: const <ValidationRule>{},
            validationRuleBuilder: builder,
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
        builder: null,
      );

      expect(find.byType(ValidationRulesWidget), findsOneWidget);
    },
  );

  testWidgets(
    'should show DefaultValidationRulesWidget if builder is null',
    (tester) async {
      await loadWidget(
        tester,
        builder: null,
      );

      expect(find.byType(DefaultValidationRulesWidget), findsOneWidget);
    },
  );

  testWidgets(
    'should execute validationRuleBuilder if one is provided',
    (tester) async {
      await loadWidget(
        tester,
        builder: (colors, rules, value) => Container(
          key: const ValueKey('widget-from-builder'),
        ),
      );

      expect(find.byKey(const ValueKey('widget-from-builder')), findsOneWidget);
    },
  );
}
