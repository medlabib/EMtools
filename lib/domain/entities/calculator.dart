import 'package:flutter/material.dart';
import '../../core/l10n/localized.dart';

enum CalculatorCategory {
  trauma,
  cardiovascular,
  peDvt,
  neurology,
  sepsis,
  pediatric,
  gi,
  toxicology,
  msk,
  laboratory,
  other
}

enum CalculatorFieldType {
  select,
  number,
  checkbox,
  radio
}

class CalculatorOption {
  final LString label;
  final double value;
  final LString? description;

  const CalculatorOption({
    required this.label,
    required this.value,
    this.description,
  });
}

class CalculatorField {
  final String id;
  final LString label;
  final CalculatorFieldType type;
  final List<CalculatorOption>? options;
  final double? min;
  final double? max;
  final String? unit;
  final bool required;

  const CalculatorField({
    required this.id,
    required this.label,
    required this.type,
    this.options,
    this.min,
    this.max,
    this.unit,
    this.required = true,
  });
}

class ScoreInterpretation {
  final double min;
  final double max;
  final LString label;
  final LString description;
  final Color color;

  const ScoreInterpretation({
    required this.min,
    required this.max,
    required this.label,
    required this.description,
    required this.color,
  });
}

class Calculator {
  final String id;
  final LString name;
  final String shortName;
  final CalculatorCategory category;
  final LString description;
  final List<CalculatorField> fields;
  final double Function(Map<String, dynamic> values) calculate;
  final List<ScoreInterpretation> interpretations;
  final String source;
  final String? sourceUrl;

  const Calculator({
    required this.id,
    required this.name,
    required this.shortName,
    required this.category,
    required this.description,
    required this.fields,
    required this.calculate,
    required this.interpretations,
    required this.source,
    this.sourceUrl,
  });
}
