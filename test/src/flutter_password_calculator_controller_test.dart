import 'package:flutter_password_calculator/src/flutter_password_calculator_controller.dart';
import 'package:flutter_password_calculator/src/validation_rule.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FlutterPasswordCalculatorController passwordController;

  setUp(() {
    passwordController = FlutterPasswordCalculatorController();
  });

  test(
    'starts with empty ofending rules and areAllRulesValidated true',
    () {
      expect(passwordController.ofendingRules, isEmpty);
      expect(passwordController.areAllRulesValidated, true);
    },
  );

  test(
    'setRules should set the given rules',
    () {
      passwordController.setRules({
        UppercaseValidationRule(),
      });
      expect(passwordController.rules.first, isA<UppercaseValidationRule>());
    },
  );

  group(
    'onChange',
    () {
      test(
        'onChange should validate rules and result to no ofending rules',
        () {
          passwordController.setRules({
            UppercaseValidationRule(),
            LowercaseValidationRule(),
          });

          passwordController.onChange('Aa');

          expect(
            passwordController.ofendingRules,
            isEmpty,
          );
        },
      );

      test(
        'onChange should validate rules and result to a ofending rule',
        () {
          passwordController.setRules({
            UppercaseValidationRule(),
            LowercaseValidationRule(),
          });

          passwordController.onChange('A');

          expect(
            passwordController.ofendingRules.first,
            isA<LowercaseValidationRule>(),
          );
        },
      );
    },
  );
}
