import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../core/widgets/animated_widgets.dart';
import '../../../../data/datasources/calculators_data.dart';
import '../../../../domain/entities/calculator.dart';

class CalculatorDetailScreen extends StatefulWidget {
  final String calculatorId;

  const CalculatorDetailScreen({super.key, required this.calculatorId});

  @override
  State<CalculatorDetailScreen> createState() => _CalculatorDetailScreenState();
}

class _CalculatorDetailScreenState extends State<CalculatorDetailScreen>
    with SingleTickerProviderStateMixin {
  late Calculator _calculator;
  final Map<String, dynamic> _values = {};
  double? _result;
  ScoreInterpretation? _interpretation;
  bool _calculatorFound = false;
  late AnimationController _animationController;
  late Animation<double> _resultAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _resultAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );
    
    try {
      _calculator = allCalculators.firstWhere((c) => c.id == widget.calculatorId);
      _calculatorFound = true;
      _initializeValues();
    } catch (e) {
      _calculatorFound = false;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _initializeValues() {
    for (var field in _calculator.fields) {
      if (field.type == CalculatorFieldType.number) {
        _values[field.id] = field.min ?? 0.0;
      } else if (field.type == CalculatorFieldType.select && field.options != null && field.options!.isNotEmpty) {
        _values[field.id] = field.options!.first.value;
      } else if (field.type == CalculatorFieldType.checkbox) {
        _values[field.id] = 0.0;
      }
    }
  }

  void _calculate() {
    setState(() {
      _result = _calculator.calculate(_values);
      _interpretation = _calculator.interpretations.firstWhere(
        (i) => _result! >= i.min && _result! <= i.max,
        orElse: () => ScoreInterpretation(
          min: 0,
          max: 0,
          label: 'Non défini',
          description: 'Résultat hors plage',
          color: Colors.grey,
        ),
      );
    });
    _animationController.forward(from: 0);
  }

  void _resetCalculator() {
    setState(() {
      _result = null;
      _interpretation = null;
      _initializeValues();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!_calculatorFound) {
      return Scaffold(
        appBar: AppBar(title: const Text('Erreur')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: AppColors.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Calculateur non trouvé',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: _buildHeader(context, isDark),
          ),

          // Description
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            sliver: SliverToBoxAdapter(
              child: AnimatedListItem(
                index: 0,
                child: GlassContainer(
                  child: Text(
                    _calculator.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Fields
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final field = _calculator.fields[index];
                  return AnimatedListItem(
                    index: index + 1,
                    child: _buildField(context, field, isDark),
                  );
                },
                childCount: _calculator.fields.length,
              ),
            ),
          ),

          // Calculate Button
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            sliver: SliverToBoxAdapter(
              child: AnimatedListItem(
                index: _calculator.fields.length + 1,
                child: _buildCalculateButton(context),
              ),
            ),
          ),

          // Result
          if (_result != null)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              sliver: SliverToBoxAdapter(
                child: ScaleTransition(
                  scale: _resultAnimation,
                  child: _buildResultCard(context, isDark),
                ),
              ),
            ),

          // Source
          if (_calculator.sourceUrl != null)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
              sliver: SliverToBoxAdapter(
                child: _buildSourceLink(context, isDark),
              ),
            ),

          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 12,
        20,
        24,
      ),
      decoration: BoxDecoration(
        color: AppColors.getCardColor(isDark),
        border: Border(
          bottom: BorderSide(color: AppColors.getBorderColor(isDark)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button row
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _resetCalculator,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.refresh_rounded,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Calculator name
          Text(
            _calculator.shortName,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.getTextPrimary(isDark),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _calculator.name,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.getTextSecondary(isDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(BuildContext context, CalculatorField field, bool isDark) {
    switch (field.type) {
      case CalculatorFieldType.select:
        return _buildSelectField(context, field, isDark);
      case CalculatorFieldType.number:
        return _buildNumberField(context, field, isDark);
      case CalculatorFieldType.checkbox:
        return _buildCheckboxField(context, field, isDark);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildSelectField(BuildContext context, CalculatorField field, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            field.label,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : AppColors.cardLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.getBorderColor(isDark)),
            ),
            child: Column(
              children: field.options?.map((option) {
                final isSelected = _values[field.id] == option.value;
                return GestureDetector(
                  onTap: () => setState(() => _values[field.id] = option.value),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? AppColors.primaryBlue.withValues(alpha: 0.1)
                          : null,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected 
                                ? AppColors.primaryBlue 
                                : Colors.transparent,
                            border: Border.all(
                              color: isSelected 
                                  ? AppColors.primaryBlue 
                                  : (isDark ? Colors.grey[600]! : Colors.grey[400]!),
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? const Icon(Icons.check, size: 16, color: Colors.white)
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                option.label,
                                style: TextStyle(
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                              if (option.description != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  option.description!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Text(
                          '${option.value.toInt()}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isSelected 
                                ? AppColors.primaryBlue 
                                : (isDark ? Colors.grey[500] : Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList() ?? [],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberField(BuildContext context, CalculatorField field, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                field.label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (field.unit != null) ...[
                const Spacer(),
                StatusBadge(
                  label: field.unit!,
                  color: AppColors.primaryBlue,
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : AppColors.cardLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.getBorderColor(isDark)),
            ),
            child: TextFormField(
              initialValue: _values[field.id]?.toString() ?? '',
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                hintText: 'Entrer une valeur',
                hintStyle: TextStyle(
                  color: isDark ? Colors.grey[500] : Colors.grey[400],
                ),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
              ],
              onChanged: (value) {
                setState(() {
                  _values[field.id] = double.tryParse(value) ?? 0.0;
                });
              },
            ),
          ),
          if (field.min != null || field.max != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Plage: ${field.min?.toStringAsFixed(0) ?? '?'} - ${field.max?.toStringAsFixed(0) ?? '?'}',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.grey[500] : Colors.grey[600],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCheckboxField(BuildContext context, CalculatorField field, bool isDark) {
    final isChecked = (_values[field.id] ?? 0.0) > 0;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () => setState(() {
          _values[field.id] = isChecked ? 0.0 : 1.0;
        }),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.cardDark : AppColors.cardLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isChecked 
                  ? AppColors.primary 
                  : AppColors.getBorderColor(isDark),
              width: isChecked ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: isChecked 
                      ? AppColors.primaryBlue 
                      : Colors.transparent,
                  border: Border.all(
                    color: isChecked 
                        ? AppColors.primaryBlue 
                        : (isDark ? Colors.grey[600]! : Colors.grey[400]!),
                    width: 2,
                  ),
                ),
                child: isChecked
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  field.label,
                  style: TextStyle(
                    fontWeight: isChecked ? FontWeight.w600 : FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalculateButton(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _calculate,
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calculate_rounded, color: Colors.white),
                const SizedBox(width: 12),
                Text(
                  AppStrings.calculate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(BuildContext context, bool isDark) {
    final color = _interpretation?.color ?? AppColors.info;
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          // Result value
          Text(
            _result!.toStringAsFixed(_result! % 1 == 0 ? 0 : 1),
            style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          // Label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _interpretation?.label ?? '',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
          if (_interpretation?.description != null) ...[
            const SizedBox(height: 16),
            Text(
              _interpretation!.description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSourceLink(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () async {
        final url = _calculator.sourceUrl;
        if (url != null) {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Impossible d\'ouvrir le lien'),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : AppColors.cardLight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.link_rounded,
                color: AppColors.info,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.source,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    _calculator.source,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.open_in_new_rounded,
              size: 18,
              color: isDark ? Colors.grey[500] : Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
