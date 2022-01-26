import 'package:flutter_password_calculator/flutter_password_calculator.dart';
import 'package:flutter_password_calculator/src/commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> loadWidget(
    WidgetTester tester, {
    required Widget widget,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );
  }

  testWidgets(
    'should build without exploding',
    (tester) async {
      await loadWidget(
        tester,
        widget: FlutterPasswordCalculator(
          key: UniqueKey(),
        ),
      );

      expect(find.byType(FlutterPasswordCalculator), findsOneWidget);
    },
  );

  testWidgets(
    'pressing DefaultShowHidePasswordButton should show password',
    (tester) async {
      await loadWidget(
        tester,
        widget: const FlutterPasswordCalculator(),
      );

      final showHideButton = find.byType(DefaultShowHidePasswordButton);
      await tester.tap(showHideButton);
      await tester.pumpAndSettle();

      final passwordField = find.byType(TextFormField);
      await tester.enterText(passwordField, 'test');
      await tester.pumpAndSettle();

      expect(find.text('test'), findsOneWidget);
    },
  );

  testWidgets(
    'should thrigger onChange if not null',
    (tester) async {
      await loadWidget(
        tester,
        widget: FlutterPasswordCalculator(
          onChanged: (value) {
            expect(value, 'test');
          },
        ),
      );

      final passwordField = find.byType(TextFormField);
      await tester.enterText(passwordField, 'test');
      await tester.pumpAndSettle();
    },
  );

  testWidgets(
    'should thrigger onSaved and validator of form if not null',
    (tester) async {
      final _formKey = GlobalKey<FormState>();
      await loadWidget(
        tester,
        widget: Form(
          key: _formKey,
          child: Column(
            children: [
              FlutterPasswordCalculator(
                onSaved: (value) {
                  expect(value, 'test');
                },
                validator: (value) {
                  expect(value, 'test');
                },
              ),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.validate();
                  _formKey.currentState!.save();
                },
                child: const Text('Form'),
              ),
            ],
          ),
        ),
      );

      final passwordField = find.byType(TextFormField);
      await tester.enterText(passwordField, 'test');
      await tester.pumpAndSettle();

      final button = find.byType(ElevatedButton);
      await tester.tap(button);
      await tester.pumpAndSettle();
    },
  );

  testWidgets(
    'should show ValidationRulesWidget if rules is not empty',
    (tester) async {
      await loadWidget(
        tester,
        widget: FlutterPasswordCalculator(
          validationRules: {
            UppercaseValidationRule(),
            LowercaseValidationRule(),
          },
        ),
      );

      expect(find.byType(ValidationRulesWidget), findsOneWidget);
    },
  );
}
