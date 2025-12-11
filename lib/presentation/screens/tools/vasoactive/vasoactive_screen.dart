import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../core/widgets/animated_widgets.dart';
import '../../../../domain/entities/vasoactive.dart';
import '../../../../data/datasources/vasoactive_data.dart';

class VasoactiveScreen extends StatefulWidget {
  const VasoactiveScreen({super.key});

  @override
  State<VasoactiveScreen> createState() => _VasoactiveScreenState();
}

class _VasoactiveScreenState extends State<VasoactiveScreen>
    with SingleTickerProviderStateMixin {
  VasoactiveDrug? _selectedDrug;
  double _weight = 70;
  int _selectedConcentrationIndex = 0;
  double _currentDose = 0;
  int _syringeVolume = 50;

  final TextEditingController _weightController = TextEditingController(text: '70');
  final TextEditingController _doseController = TextEditingController();

  @override
  void dispose() {
    _weightController.dispose();
    _doseController.dispose();
    super.dispose();
  }

  void _selectDrug(VasoactiveDrug drug) {
    setState(() {
      _selectedDrug = drug;
      _selectedConcentrationIndex = drug.defaultConcentrationIndex;
      _currentDose = drug.doseRange.typical;
      _doseController.text = _currentDose.toString();
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedDrug = null;
    });
  }

  void _onWeightChanged(String value) {
    final w = double.tryParse(value);
    if (w != null) {
      setState(() {
        _weight = w;
      });
    }
  }

  void _onDoseChanged(double value) {
    setState(() {
      _currentDose = value;
      _doseController.text = value.toStringAsFixed(2);
    });
  }

  double _calculateFlowRate() {
    if (_selectedDrug == null) return 0;
    
    final concentration = _selectedDrug!.concentrations[_selectedConcentrationIndex];
    final mgPerMl = concentration.mgPerMl;
    
    double mcgPerMin = 0;
    
    switch (_selectedDrug!.doseUnit) {
      case 'mcg/kg/min':
        mcgPerMin = _currentDose * _weight;
        break;
      case 'mcg/min':
        mcgPerMin = _currentDose;
        break;
      case 'mg/h':
        mcgPerMin = (_currentDose * 1000) / 60;
        break;
      case 'UI/min':
        return (_currentDose / mgPerMl) * 60;
      default:
        mcgPerMin = _currentDose;
    }
    
    final mgPerMin = mcgPerMin / 1000;
    final mlPerMin = mgPerMin / mgPerMl;
    return mlPerMin * 60;
  }

  Color _getCategoryColor(VasoactiveCategory category) {
    switch (category) {
      case VasoactiveCategory.vasopressor:
        return AppColors.error;
      case VasoactiveCategory.inotrope:
        return AppColors.primaryBlue;
      case VasoactiveCategory.vasodilator:
        return AppColors.success;
      case VasoactiveCategory.mixed:
        return AppColors.primaryPurple;
    }
  }

  IconData _getCategoryIcon(VasoactiveCategory category) {
    switch (category) {
      case VasoactiveCategory.vasopressor:
        return Icons.trending_up_rounded;
      case VasoactiveCategory.inotrope:
        return Icons.favorite_rounded;
      case VasoactiveCategory.vasodilator:
        return Icons.trending_down_rounded;
      case VasoactiveCategory.mixed:
        return Icons.sync_alt_rounded;
    }
  }

  String _getCategoryName(VasoactiveCategory category) {
    switch (category) {
      case VasoactiveCategory.vasopressor:
        return 'Vasopresseurs';
      case VasoactiveCategory.inotrope:
        return 'Inotropes';
      case VasoactiveCategory.vasodilator:
        return 'Vasodilatateurs';
      case VasoactiveCategory.mixed:
        return 'Mixtes';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: _selectedDrug == null 
          ? _buildDrugList(context, isDark) 
          : _buildCalculator(context, isDark),
    );
  }

  Widget _buildDrugList(BuildContext context, bool isDark) {
    final Map<VasoactiveCategory, List<VasoactiveDrug>> grouped = {};
    for (var drug in VasoactiveData.allDrugs) {
      if (!grouped.containsKey(drug.category)) {
        grouped[drug.category] = [];
      }
      grouped[drug.category]!.add(drug);
    }

    return CustomScrollView(
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: _buildHeader(context, null),
        ),

        // Category sections
        ...VasoactiveCategory.values.expand((category) {
          final drugs = grouped[category];
          if (drugs == null || drugs.isEmpty) return <Widget>[];
          
          return [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(category).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _getCategoryIcon(category),
                        color: _getCategoryColor(category),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _getCategoryName(category),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    StatusBadge(
                      label: '${drugs.length}',
                      color: _getCategoryColor(category),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final drug = drugs[index];
                    return AnimatedListItem(
                      index: index,
                      child: _DrugCard(
                        drug: drug,
                        color: _getCategoryColor(category),
                        onTap: () => _selectDrug(drug),
                        isDark: isDark,
                      ),
                    );
                  },
                  childCount: drugs.length,
                ),
              ),
            ),
          ];
        }),

        const SliverToBoxAdapter(
          child: SizedBox(height: 100),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, VasoactiveDrug? drug) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 12,
        20,
        24,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: drug != null 
              ? [_getCategoryColor(drug.category), _getCategoryColor(drug.category).withValues(alpha: 0.8)]
              : [const Color(0xFFEC4899), const Color(0xFFBE185D), const Color(0xFF9D174D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => drug != null ? _clearSelection() : Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  drug != null ? _getCategoryIcon(drug.category) : Icons.favorite_outline,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      drug?.name ?? AppStrings.vasoactiveTitle,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      drug?.genericName ?? AppStrings.vasoactiveDesc,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalculator(BuildContext context, bool isDark) {
    final drug = _selectedDrug!;
    final flowRate = _calculateFlowRate();
    final duration = flowRate > 0 ? _syringeVolume / flowRate : 0.0;
    final color = _getCategoryColor(drug.category);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _buildHeader(context, drug),
        ),

        // Description
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          sliver: SliverToBoxAdapter(
            child: GlassContainer(
              child: Text(
                drug.description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.5,
                ),
              ),
            ),
          ),
        ),

        // Results Card
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          sliver: SliverToBoxAdapter(
            child: _buildResultsCard(flowRate, duration, color, isDark),
          ),
        ),

        // Calculator Inputs
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          sliver: SliverToBoxAdapter(
            child: _buildCalculatorInputs(drug, color, isDark),
          ),
        ),

        // Receptor Effects
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          sliver: SliverToBoxAdapter(
            child: _buildReceptorEffects(drug, isDark),
          ),
        ),

        // Info Sections
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          sliver: SliverToBoxAdapter(
            child: _buildInfoSection('Indications', drug.indications, Icons.check_circle_outline, AppColors.success, isDark),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          sliver: SliverToBoxAdapter(
            child: _buildInfoSection('Effets indésirables', drug.sideEffects, Icons.warning_amber_rounded, AppColors.warning, isDark),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          sliver: SliverToBoxAdapter(
            child: _buildInfoSection('Contre-indications', drug.contraindications, Icons.block_rounded, AppColors.error, isDark),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
          sliver: SliverToBoxAdapter(
            child: _buildInfoSection('Notes', drug.notes, Icons.info_outline_rounded, AppColors.info, isDark),
          ),
        ),
      ],
    );
  }

  Widget _buildResultsCard(double flowRate, double duration, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildResultItem(
            'Débit PSE',
            flowRate.toStringAsFixed(1),
            'mL/h',
            Icons.speed_rounded,
          ),
          Container(
            width: 1,
            height: 60,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          _buildResultItem(
            'Durée',
            duration >= 1 
                ? duration.toStringAsFixed(1) 
                : (duration * 60).toStringAsFixed(0),
            duration >= 1 ? 'h' : 'min',
            Icons.timer_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildResultItem(String label, String value, String unit, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.8), size: 24),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4, left: 4),
              child: Text(
                unit,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCalculatorInputs(VasoactiveDrug drug, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.calculate_rounded, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Calculateur PSE',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Weight
          _buildInputField(
            label: 'Poids du patient',
            unit: 'kg',
            controller: _weightController,
            onChanged: _onWeightChanged,
            isDark: isDark,
          ),
          const SizedBox(height: 16),

          // Concentration
          _buildConcentrationSelector(drug, isDark),
          const SizedBox(height: 20),

          // Dose Slider
          _buildDoseSlider(drug, color, isDark),
          const SizedBox(height: 16),

          // Syringe Volume
          _buildSyringeSelector(isDark),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String unit,
    required TextEditingController controller,
    required Function(String) onChanged,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            const Spacer(),
            StatusBadge(label: unit, color: AppColors.primaryBlue),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: isDark 
                ? Colors.black.withValues(alpha: 0.2) 
                : Colors.grey.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
            ],
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: isDark ? Colors.white : Colors.black87,
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildConcentrationSelector(VasoactiveDrug drug, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Concentration / Préparation',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: isDark 
                ? Colors.black.withValues(alpha: 0.2) 
                : Colors.grey.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<int>(
            initialValue: _selectedConcentrationIndex,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            items: List.generate(drug.concentrations.length, (index) {
              return DropdownMenuItem(
                value: index,
                child: Text(
                  drug.concentrations[index].label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              );
            }),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedConcentrationIndex = value;
                });
              }
            },
            isExpanded: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: AppColors.info),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  drug.concentrations[_selectedConcentrationIndex].commonPrep,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.info,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDoseSlider(VasoactiveDrug drug, Color color, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dose',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_currentDose.toStringAsFixed(2)} ${drug.doseUnit}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: color,
            inactiveTrackColor: color.withValues(alpha: 0.2),
            thumbColor: color,
            overlayColor: color.withValues(alpha: 0.2),
          ),
          child: Slider(
            value: _currentDose,
            min: drug.doseRange.min,
            max: drug.doseRange.max,
            divisions: ((drug.doseRange.max - drug.doseRange.min) / drug.doseRange.step).round(),
            onChanged: _onDoseChanged,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${drug.doseRange.min}',
              style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[500] : Colors.grey[600]),
            ),
            Text(
              'Typique: ${drug.doseRange.typical}',
              style: TextStyle(fontSize: 12, color: color),
            ),
            Text(
              '${drug.doseRange.max}',
              style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[500] : Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSyringeSelector(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Volume seringue',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [10, 20, 50].map((volume) {
            final isSelected = _syringeVolume == volume;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _syringeVolume = volume),
                child: Container(
                  margin: EdgeInsets.only(right: volume != 50 ? 8 : 0),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? AppColors.primaryBlue 
                        : (isDark ? Colors.black.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      '$volume mL',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isSelected 
                            ? Colors.white 
                            : (isDark ? Colors.grey[400] : Colors.grey[700]),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildReceptorEffects(VasoactiveDrug drug, bool isDark) {
    if (drug.effects.alpha == 'none' && drug.effects.beta1 == 'none' && 
        drug.effects.beta2 == 'none' && drug.effects.dopaminergic == 'none' && 
        drug.effects.vasopressin == 'none') {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.science_rounded, color: AppColors.primaryPurple, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Effets récepteurs',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildEffectItem('α', drug.effects.alpha, isDark),
              _buildEffectItem('β₁', drug.effects.beta1, isDark),
              _buildEffectItem('β₂', drug.effects.beta2, isDark),
              _buildEffectItem('DA', drug.effects.dopaminergic, isDark),
              _buildEffectItem('V1', drug.effects.vasopressin, isDark),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEffectItem(String label, String level, bool isDark) {
    if (level == 'none') {
      return Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '—',
            style: TextStyle(
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
          ),
        ],
      );
    }

    int bars = 0;
    Color color = Colors.grey;
    
    switch (level) {
      case 'low': bars = 1; color = AppColors.success; break;
      case 'moderate': bars = 2; color = AppColors.warning; break;
      case 'high': bars = 3; color = AppColors.error; break;
    }

    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            return Container(
              width: 10,
              height: 20,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: index < bars ? color : (isDark ? Colors.grey[700] : Colors.grey[300]),
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildInfoSection(String title, List<String> items, IconData icon, Color color, bool isDark) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 6, right: 12),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      height: 1.4,
                      color: isDark ? Colors.grey[300] : Colors.grey[800],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _DrugCard extends StatefulWidget {
  final VasoactiveDrug drug;
  final Color color;
  final VoidCallback onTap;
  final bool isDark;

  const _DrugCard({
    required this.drug,
    required this.color,
    required this.onTap,
    required this.isDark,
  });

  @override
  State<_DrugCard> createState() => _DrugCardState();
}

class _DrugCardState extends State<_DrugCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: widget.isDark ? AppColors.cardDark : AppColors.cardLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.color.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: widget.isDark ? 0.2 : 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.drug.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: widget.isDark ? Colors.white : Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.drug.genericName,
                    style: TextStyle(
                      fontSize: 12,
                      color: widget.isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${widget.drug.doseRange.min}-${widget.drug.doseRange.max} ${widget.drug.doseUnit}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: widget.color,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
