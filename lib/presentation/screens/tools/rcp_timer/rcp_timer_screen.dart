import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/l10n/app_strings.dart';

/// RCP (Réanimation Cardio-Pulmonaire) Timer Screen
/// Updated: 2025 (AHA/ERC Guidelines 2020-2025)
/// Features:
/// - Total elapsed time
/// - Cycle counter (2 min cycles)
/// - Compression rate metronome (100-120/min)
/// - Adrenaline timer (every 3-5 min)
/// - Rhythm check reminder
/// - Event logging
class RcpTimerScreen extends StatefulWidget {
  const RcpTimerScreen({super.key});

  @override
  State<RcpTimerScreen> createState() => _RcpTimerScreenState();
}

class _RcpTimerScreenState extends State<RcpTimerScreen> with TickerProviderStateMixin {
  // Main timer
  Timer? _mainTimer;
  Duration _elapsedTime = Duration.zero;
  bool _isRunning = false;

  // Cycle tracking (2 min = 120 sec)
  int _cycleCount = 0;
  static const int _cycleDurationSeconds = 120;

  // Adrenaline timer (configurable 3-5 min)
  Timer? _adrenalineTimer;
  Duration _timeSinceLastAdrenaline = Duration.zero;
  int _adrenalineCount = 0;
  int _adrenalineIntervalMinutes = 3; // Default 3 minutes, configurable
  bool _adrenalineAlertShown = false;

  // Metronome for compressions (110 BPM = target between 100-120)
  Timer? _metronomeTimer;
  bool _metronomeEnabled = false;
  int _compressionRate = 110; // BPM
  bool _metronomeFlash = false;
  int _compressionCount = 0;
  late AnimationController _pulseController;
  
  // Settings
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  double _metronomeSize = 60.0; // Size of metronome visual indicator
  int _shockCount = 0;
  
  // Computed adrenaline interval in seconds
  int get _adrenalineIntervalSeconds => _adrenalineIntervalMinutes * 60;

  // Event log
  final List<_RcpEvent> _eventLog = [];

  // Rhythm type
  String _rhythmType = 'unknown';
  final List<String> _rhythmTypes = [
    'unknown',
    'vfPulselessVt',
    'asystole',
    'pea',
    'rosc',
  ];

  String _rhythmDisplayName(String key) {
    switch (key) {
      case 'unknown': return context.t('unknownRhythm');
      case 'vfPulselessVt': return context.t('vfPulselessVt');
      case 'asystole': return context.t('asystoleRhythm');
      case 'pea': return context.t('peaRhythm');
      case 'rosc': return context.t('roscRhythm');
      default: return key;
    }
  }

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    // Keep screen on
    WakelockPlus.enable();
  }

  @override
  void dispose() {
    _mainTimer?.cancel();
    _adrenalineTimer?.cancel();
    _metronomeTimer?.cancel();
    _pulseController.dispose();
    // Allow screen to turn off
    WakelockPlus.disable();
    super.dispose();
  }

  void _startTimer() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
    });

    _addEvent(context.t('cprStarted'));

    // Main timer - updates every second
    _mainTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime += const Duration(seconds: 1);
        _timeSinceLastAdrenaline += const Duration(seconds: 1);

        // Check for new cycle (every 2 min)
        if (_elapsedTime.inSeconds % _cycleDurationSeconds == 0 &&
            _elapsedTime.inSeconds > 0) {
          _cycleCount++;
          _showCycleAlert();
        }

        // Check for adrenaline reminder
        if (_timeSinceLastAdrenaline.inSeconds >= _adrenalineIntervalSeconds &&
            !_adrenalineAlertShown) {
          _adrenalineAlertShown = true;
          _showAdrenalineAlert();
        }
      });
    });

    // Start metronome if enabled
    if (_metronomeEnabled) {
      _startMetronome();
    }
  }

  void _pauseTimer() {
    if (!_isRunning) return;

    _mainTimer?.cancel();
    _metronomeTimer?.cancel();

    setState(() {
      _isRunning = false;
    });

    _addEvent(context.t('cprPaused'));
  }

  void _resetTimer() {
    _mainTimer?.cancel();
    _metronomeTimer?.cancel();

    setState(() {
      _isRunning = false;
      _elapsedTime = Duration.zero;
      _cycleCount = 0;
      _timeSinceLastAdrenaline = Duration.zero;
      _adrenalineCount = 0;
      _adrenalineAlertShown = false;
      _compressionCount = 0;
      _shockCount = 0;
      _rhythmType = 'unknown';
      _eventLog.clear();
    });
  }

  void _startMetronome() {
    _metronomeTimer?.cancel();
    final intervalMs = (60000 / _compressionRate).round();

    _metronomeTimer = Timer.periodic(Duration(milliseconds: intervalMs), (timer) {
      if (_isRunning) {
        setState(() {
          _metronomeFlash = true;
          _compressionCount++;
        });
        _pulseController.forward().then((_) => _pulseController.reverse());
        // Haptic feedback
        HapticFeedback.lightImpact();
        // Reset flash after short delay
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted) {
            setState(() {
              _metronomeFlash = false;
            });
          }
        });
      }
    });
  }

  void _toggleMetronome() {
    setState(() {
      _metronomeEnabled = !_metronomeEnabled;
    });

    if (_metronomeEnabled && _isRunning) {
      _startMetronome();
    } else {
      _metronomeTimer?.cancel();
    }
  }

  void _recordAdrenaline() {
    setState(() {
      _adrenalineCount++;
      _timeSinceLastAdrenaline = Duration.zero;
      _adrenalineAlertShown = false;
    });
    _addEvent(context.t('adrenalineAdministered').replaceAll('{0}', '$_adrenalineCount'));
    if (_vibrationEnabled) HapticFeedback.mediumImpact();
  }

  void _recordShock() {
    setState(() {
      _shockCount++;
    });
    _addEvent(context.t('shockDelivered').replaceAll('{0}', '$_shockCount'));
    if (_vibrationEnabled) HapticFeedback.heavyImpact();
  }

  void _recordAmiodarone() {
    _addEvent(context.t('amiodaroneAdministered'));
    if (_vibrationEnabled) HapticFeedback.lightImpact();
  }

  void _setRhythm(String rhythm) {
    setState(() {
      _rhythmType = rhythm;
    });
    _addEvent(context.t('rhythmRecorded').replaceAll('{0}', _rhythmDisplayName(rhythm)));
  }

  void _addEvent(String description) {
    setState(() {
      _eventLog.insert(0, _RcpEvent(
        time: _elapsedTime,
        description: description,
      ));
    });
  }

  void _showCycleAlert() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.refresh, color: Colors.white),
            const SizedBox(width: 8),
            Text(context.t('cycleCompleteMsg').replaceAll('{0}', '$_cycleCount')),
          ],
        ),
        backgroundColor: AppColors.warning,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
    HapticFeedback.heavyImpact();
  }

  void _showAdrenalineAlert() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.medication, color: Colors.white),
            const SizedBox(width: 8),
            Text(context.t('adrenalineNow')),
          ],
        ),
        backgroundColor: AppColors.error,
        duration: const Duration(seconds: 10),
        action: SnackBarAction(
          label: context.t('done'),
          textColor: Colors.white,
          onPressed: _recordAdrenaline,
        ),
      ),
    );
    if (_vibrationEnabled) HapticFeedback.heavyImpact();
  }

  void _showSettings(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                context.t('cprSettings'),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              
              // Adrenaline Interval
              Text(
                context.t('adrenalineInterval'),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [3, 4, 5].map((min) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text('$min min'),
                      selected: _adrenalineIntervalMinutes == min,
                      onSelected: (selected) {
                        if (selected) {
                          setModalState(() {});
                          setState(() => _adrenalineIntervalMinutes = min);
                        }
                      },
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: _adrenalineIntervalMinutes == min 
                          ? Colors.white 
                          : (isDark ? Colors.white70 : Colors.black87),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )).toList(),
              ),
              const SizedBox(height: 8),
              Text(
                context.t('recommendationRhythm'),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.getTextSecondary(isDark),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Metronome Size
              Text(
                context.t('metronomeSizeLabel'),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.circle, size: 20),
                  Expanded(
                    child: Slider(
                      value: _metronomeSize,
                      min: 40,
                      max: 120,
                      divisions: 4,
                      label: '${_metronomeSize.toInt()}',
                      onChanged: (value) {
                        setModalState(() {});
                        setState(() => _metronomeSize = value);
                      },
                    ),
                  ),
                  Icon(Icons.circle, size: 40, color: AppColors.error),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Sound & Vibration
              SwitchListTile(
                title: Text(context.t('vibrationLabel')),
                subtitle: Text(context.t('hapticFeedbackDesc')),
                value: _vibrationEnabled,
                onChanged: (value) {
                  setModalState(() {});
                  setState(() => _vibrationEnabled = value);
                },
                secondary: const Icon(Icons.vibration),
              ),
              
              SwitchListTile(
                title: Text(context.t('soundLabel')),
                subtitle: Text(context.t('soundAlertsDesc')),
                value: _soundEnabled,
                onChanged: (value) {
                  setModalState(() {});
                  setState(() => _soundEnabled = value);
                },
                secondary: const Icon(Icons.volume_up),
              ),
              
              const SizedBox(height: 16),
              
              // Close button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(context.t('close')),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String _formatDurationLong(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondsInCycle = _elapsedTime.inSeconds % _cycleDurationSeconds;
    final cycleProgress = secondsInCycle / _cycleDurationSeconds;
    final adrenalineProgress = _timeSinceLastAdrenaline.inSeconds / _adrenalineIntervalSeconds;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.t('cprTimerTitle')),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: context.t('settings'),
            onPressed: _isRunning ? null : () => _showSettings(context),
          ),
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: context.t('historyLabel'),
            onPressed: () => _showEventLog(context),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: context.t('reset'),
            onPressed: _isRunning ? null : _resetTimer,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Main timer display
              _buildMainTimer(theme),
              const SizedBox(height: 24),

              // Cycle and Adrenaline row
              Row(
                children: [
                  Expanded(child: _buildCycleCard(theme, cycleProgress)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildAdrenalineCard(theme, adrenalineProgress)),
                ],
              ),
              const SizedBox(height: 16),

              // Metronome card
              _buildMetronomeCard(theme),
              const SizedBox(height: 16),

              // Rhythm selector
              _buildRhythmSelector(theme),
              const SizedBox(height: 16),

              // Quick actions
              _buildQuickActions(theme),
              const SizedBox(height: 16),

              // Control buttons
              _buildControlButtons(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainTimer(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final running = _isRunning;
    final labelColor = running ? Colors.white70 : AppColors.getTextSecondary(isDark);
    final valueColor = running ? Colors.white : AppColors.getTextPrimary(isDark);
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: running ? AppColors.error : AppColors.getCardColor(isDark),
          border: running ? null : Border.all(color: AppColors.getBorderColor(isDark)),
        ),
        child: Column(
          children: [
            Text(
              context.t('totalTime'),
              style: theme.textTheme.titleMedium?.copyWith(
                color: labelColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _formatDurationLong(_elapsedTime),
              style: theme.textTheme.displayLarge?.copyWith(
                color: valueColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                fontSize: 64,
              ),
            ),
            if (_isRunning) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    context.t('cprInProgress'),
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCycleCard(ThemeData theme, double progress) {
    final secondsRemaining = _cycleDurationSeconds - (_elapsedTime.inSeconds % _cycleDurationSeconds);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.loop, color: AppColors.accentTeal, size: 20),
                const SizedBox(width: 8),
                Text(
                  context.t('cycleLabel'),
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${_cycleCount + 1}',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.accentTeal,
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.accentTeal.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation(AppColors.accentTeal),
            ),
            const SizedBox(height: 4),
            Text(
              context.t('secondsRemaining').replaceAll('{0}', '$secondsRemaining'),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdrenalineCard(ThemeData theme, double progress) {
    final secondsRemaining = _adrenalineIntervalSeconds - _timeSinceLastAdrenaline.inSeconds;
    final isOverdue = secondsRemaining <= 0;

    return Card(
      color: isOverdue ? AppColors.error.withValues(alpha: 0.1) : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.medication,
                  color: isOverdue ? AppColors.error : AppColors.warning,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  context.t('adrenalineLabel'),
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              isOverdue ? context.t('nowExcl') : _formatDuration(Duration(seconds: secondsRemaining)),
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isOverdue ? AppColors.error : AppColors.warning,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: AppColors.warning.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation(
                isOverdue ? AppColors.error : AppColors.warning,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              context.t('totalMg').replaceAll('{0}', '$_adrenalineCount'),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetronomeCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.t('metronomeCompressions'),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch(
                  value: _metronomeEnabled,
                  onChanged: (_) => _toggleMetronome(),
                  activeTrackColor: AppColors.error.withValues(alpha: 0.5),
                  thumbColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppColors.error;
                    }
                    return null;
                  }),
                ),
              ],
            ),
            if (_metronomeEnabled) ...[
              const SizedBox(height: 20),
              // Big metronome visual indicator
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 50),
                    width: _metronomeFlash ? _metronomeSize * 1.2 : _metronomeSize,
                    height: _metronomeFlash ? _metronomeSize * 1.2 : _metronomeSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _metronomeFlash
                          ? AppColors.error
                          : AppColors.error.withValues(alpha: 0.3),
                      boxShadow: _metronomeFlash
                          ? [
                              BoxShadow(
                                color: AppColors.error.withValues(alpha: 0.5),
                                blurRadius: 30,
                                spreadRadius: 10,
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: _metronomeSize * 0.5,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.filled(
                    icon: const Icon(Icons.remove),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.error.withValues(alpha: 0.2),
                    ),
                    onPressed: () {
                      if (_compressionRate > 100) {
                        setState(() => _compressionRate -= 5);
                        if (_isRunning) _startMetronome();
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    decoration: BoxDecoration(
                      color: _isCompressionRateOk()
                          ? AppColors.success.withValues(alpha: 0.2)
                          : AppColors.warning.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '$_compressionRate',
                          style: theme.textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: _isCompressionRateOk()
                                ? AppColors.success
                                : AppColors.warning,
                          ),
                        ),
                        Text(
                          context.t('bpm'),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton.filled(
                    icon: const Icon(Icons.add),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.error.withValues(alpha: 0.2),
                    ),
                    onPressed: () {
                      if (_compressionRate < 120) {
                        setState(() => _compressionRate += 5);
                        if (_isRunning) _startMetronome();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                context.t('targetRate'),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                context.t('compressionsCount').replaceAll('{0}', '$_compressionCount'),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  bool _isCompressionRateOk() => _compressionRate >= 100 && _compressionRate <= 120;

  Widget _buildRhythmSelector(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.t('cardiacRhythm'),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _rhythmTypes.map((rhythm) {
                final isSelected = _rhythmType == rhythm;
                final isShockable = rhythm == 'vfPulselessVt';
                final isRosc = rhythm == 'rosc';

                return ChoiceChip(
                  label: Text(_rhythmDisplayName(rhythm)),
                  selected: isSelected,
                  onSelected: (_) => _setRhythm(rhythm),
                  selectedColor: isRosc
                      ? AppColors.success
                      : (isShockable ? AppColors.error : AppColors.primaryBlue),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : null,
                    fontWeight: isSelected ? FontWeight.bold : null,
                  ),
                );
              }).toList(),
            ),
            if (_rhythmType == 'vfPulselessVt') ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.electric_bolt, color: AppColors.error, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      context.t('shockableRhythmMsg'),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (_rhythmType == 'rosc') ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.favorite, color: AppColors.success, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      context.t('roscPostArrest'),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.t('quickActions'),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_shockCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.electric_bolt, size: 16, color: AppColors.error),
                        const SizedBox(width: 4),
                        Text(
                          context.t('shocksCount').replaceAll('{0}', '$_shockCount'),
                          style: TextStyle(
                            color: AppColors.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildActionButton(
                  icon: Icons.medication,
                  label: context.t('adrenalineLabel'),
                  color: AppColors.warning,
                  onPressed: _recordAdrenaline,
                ),
                _buildActionButton(
                  icon: Icons.electric_bolt,
                  label: context.t('shockAction').replaceAll('{0}', '$_shockCount'),
                  color: AppColors.error,
                  onPressed: _recordShock,
                ),
                _buildActionButton(
                  icon: Icons.science,
                  label: context.t('amiodaroneLabel'),
                  color: AppColors.accentPurple,
                  onPressed: _recordAmiodarone,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: _isRunning ? onPressed : null,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildControlButtons(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _isRunning ? _pauseTimer : _startTimer,
            icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow, size: 32),
            label: Text(
              _isRunning ? context.t('pauseLabel') : context.t('startLabel'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _isRunning ? AppColors.warning : AppColors.success,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showEventLog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.t('eventHistory'),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: _eventLog.isEmpty
                        ? Center(
                            child: Text(
                              AppStrings.noEventsRecorded,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          )
                        : ListView.builder(
                            controller: scrollController,
                            itemCount: _eventLog.length,
                            itemBuilder: (context, index) {
                              final event = _eventLog[index];
                              return ListTile(
                                leading: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryBlue.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    _formatDurationLong(event.time),
                                    style: const TextStyle(
                                      fontFamily: 'monospace',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                title: Text(event.description),
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _RcpEvent {
  final Duration time;
  final String description;

  _RcpEvent({
    required this.time,
    required this.description,
  });
}
