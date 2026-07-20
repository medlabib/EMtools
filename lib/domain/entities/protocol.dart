import 'package:flutter/material.dart';
import '../../core/l10n/localized.dart';

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
  LString get displayName {
    switch (this) {
      case ProtocolCategory.cardiology:
        return LString('Cardiologie', 'Cardiology');
      case ProtocolCategory.respiratory:
        return LString('Respiratoire', 'Respiratory');
      case ProtocolCategory.neurology:
        return LString('Neurologie', 'Neurology');
      case ProtocolCategory.trauma:
        return LString('Traumatologie', 'Traumatology');
      case ProtocolCategory.sepsis:
        return LString('Sepsis / Infections', 'Sepsis / Infections');
      case ProtocolCategory.toxicology:
        return LString('Toxicologie', 'Toxicology');
      case ProtocolCategory.metabolic:
        return LString('Métabolique', 'Metabolic');
      case ProtocolCategory.pediatric:
        return LString('Pédiatrie', 'Pediatrics');
      case ProtocolCategory.obstetric:
        return LString('Obstétrique', 'Obstetrics');
      case ProtocolCategory.analgesia:
        return LString('Analgésie / Sédation', 'Analgesia / Sedation');
      case ProtocolCategory.resuscitation:
        return LString('Réanimation', 'Resuscitation');
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
  final LString title;
  final LString content;
  final List<LString>? bulletPoints;
  final LString? warning;
  final LString? tip;

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
  final LString name;
  final ProtocolCategory category;
  final LString description;
  final List<ProtocolStep> steps;
  final LString? indication;
  final LString? contraindication;
  final LString? keyPoints;
  final LString source;
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
