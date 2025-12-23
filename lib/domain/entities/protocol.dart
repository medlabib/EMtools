import 'package:flutter/material.dart';

enum ProtocolCategory {
  cardiology,
  respiratory,
  neurology,
  trauma,
  sepsis,
  toxicology,
  metabolic,
  pediatric,
  obstetric,
  analgesia,
  resuscitation,
}

extension ProtocolCategoryExtension on ProtocolCategory {
  String get displayName {
    switch (this) {
      case ProtocolCategory.cardiology:
        return 'Cardiologie';
      case ProtocolCategory.respiratory:
        return 'Respiratoire';
      case ProtocolCategory.neurology:
        return 'Neurologie';
      case ProtocolCategory.trauma:
        return 'Traumatologie';
      case ProtocolCategory.sepsis:
        return 'Sepsis / Infections';
      case ProtocolCategory.toxicology:
        return 'Toxicologie';
      case ProtocolCategory.metabolic:
        return 'Métabolique';
      case ProtocolCategory.pediatric:
        return 'Pédiatrie';
      case ProtocolCategory.obstetric:
        return 'Obstétrique';
      case ProtocolCategory.analgesia:
        return 'Analgésie / Sédation';
      case ProtocolCategory.resuscitation:
        return 'Réanimation';
    }
  }

  IconData get icon {
    switch (this) {
      case ProtocolCategory.cardiology:
        return Icons.favorite;
      case ProtocolCategory.respiratory:
        return Icons.air;
      case ProtocolCategory.neurology:
        return Icons.psychology;
      case ProtocolCategory.trauma:
        return Icons.personal_injury;
      case ProtocolCategory.sepsis:
        return Icons.coronavirus;
      case ProtocolCategory.toxicology:
        return Icons.science;
      case ProtocolCategory.metabolic:
        return Icons.water_drop;
      case ProtocolCategory.pediatric:
        return Icons.child_care;
      case ProtocolCategory.obstetric:
        return Icons.pregnant_woman;
      case ProtocolCategory.analgesia:
        return Icons.medication;
      case ProtocolCategory.resuscitation:
        return Icons.monitor_heart;
    }
  }

  Color get color {
    switch (this) {
      case ProtocolCategory.cardiology:
        return Colors.red;
      case ProtocolCategory.respiratory:
        return Colors.blue;
      case ProtocolCategory.neurology:
        return Colors.purple;
      case ProtocolCategory.trauma:
        return Colors.orange;
      case ProtocolCategory.sepsis:
        return Colors.green;
      case ProtocolCategory.toxicology:
        return Colors.amber;
      case ProtocolCategory.metabolic:
        return Colors.teal;
      case ProtocolCategory.pediatric:
        return Colors.pink;
      case ProtocolCategory.obstetric:
        return Colors.indigo;
      case ProtocolCategory.analgesia:
        return Colors.cyan;
      case ProtocolCategory.resuscitation:
        return Colors.deepOrange;
    }
  }
}

class ProtocolStep {
  final String title;
  final String content;
  final List<String>? bulletPoints;
  final String? warning;
  final String? tip;

  const ProtocolStep({
    required this.title,
    required this.content,
    this.bulletPoints,
    this.warning,
    this.tip,
  });
}

class Protocol {
  final String id;
  final String name;
  final ProtocolCategory category;
  final String description;
  final List<ProtocolStep> steps;
  final String? indication;
  final String? contraindication;
  final String? keyPoints;
  final String source;
  final String? sourceUrl;
  final int? lastUpdated;
  final bool isPediatric;

  const Protocol({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.steps,
    this.indication,
    this.contraindication,
    this.keyPoints,
    required this.source,
    this.sourceUrl,
    this.lastUpdated,
    this.isPediatric = false,
  });
}
