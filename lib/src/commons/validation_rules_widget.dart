import 'package:flutter/material.dart';

import '../validation_rule.dart';
import 'commons.dart';

typedef ValidationRulesBuilder = Widget Function(
  Set<ValidationRule> rules,
  String value,
);

class ValidationRulesWidget extends StatelessWidget {
  const ValidationRulesWidget({
    super.key,
    required String password,
    required Set<ValidationRule> validationRules,
    ValidationRulesBuilder? validationRuleBuilder,
  })  : _password = password,
        _validationRules = validationRules,
        _validationRuleBuilder = validationRuleBuilder;

  final String _password;
  final Set<ValidationRule> _validationRules;
  final ValidationRulesBuilder? _validationRuleBuilder;

  @override
  Widget build(BuildContext context) {
    return _validationRuleBuilder != null
        ? _validationRuleBuilder!(
            _validationRules,
            _password,
          )
        : DefaultValidationRulesWidget(
            validationRules: _validationRules,
            value: _password,
          );
  }
}
