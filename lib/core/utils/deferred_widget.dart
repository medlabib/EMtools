import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

typedef LibraryLoader = Future<void> Function();
typedef DeferredWidgetBuilder = Widget Function();

class DeferredWidget extends StatefulWidget {
  final LibraryLoader libraryLoader;
  final DeferredWidgetBuilder builder;
  final Widget? placeholder;

  const DeferredWidget({
    super.key,
    required this.libraryLoader,
    required this.builder,
    this.placeholder,
  });

  @override
  State<DeferredWidget> createState() => _DeferredWidgetState();
}

class _DeferredWidgetState extends State<DeferredWidget> {
  Future<void>? _libraryFuture;

  @override
  void initState() {
    super.initState();
    _libraryFuture = widget.libraryLoader();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _libraryFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return widget.builder();
        }
        return widget.placeholder ?? const _ToolSkeletonLoader();
      },
    );
  }
}

class _ToolSkeletonLoader extends StatefulWidget {
  const _ToolSkeletonLoader();

  @override
  State<_ToolSkeletonLoader> createState() => _ToolSkeletonLoaderState();
}

class _ToolSkeletonLoaderState extends State<_ToolSkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Widget _shimmerBox({double? width, double height = 16, BorderRadius? borderRadius, double flex = 0}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0);
    final highlightColor = isDark ? const Color(0xFF475569) : const Color(0xFFF1F5F9);

    Widget box = AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, _) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                baseColor,
                Color.lerp(baseColor, highlightColor, _pulseAnimation.value)!,
                baseColor,
              ],
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        );
      },
    );

    if (flex > 0 && width == null) return Expanded(flex: flex.toInt(), child: box);
    return box;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          // Skeleton header
          SliverToBoxAdapter(
            child: Container(
              height: 160,
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardDark : AppColors.cardLight,
                border: Border(
                  bottom: BorderSide(color: AppColors.getBorderColor(isDark)),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Rounded icon placeholder
                      _shimmerBox(
                        width: 44,
                        height: 44,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      const SizedBox(height: 12),
                      // Title placeholder
                      _shimmerBox(width: 200, height: 24, borderRadius: BorderRadius.circular(8)),
                      const SizedBox(height: 6),
                      // Subtitle placeholder
                      _shimmerBox(width: 150, height: 16, borderRadius: BorderRadius.circular(8)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Content skeleton
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section heading
                  _shimmerBox(width: 140, height: 20, borderRadius: BorderRadius.circular(6)),
                  const SizedBox(height: 16),
                  // Input field placeholders
                  ...List.generate(4, (_) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _shimmerBox(height: 52, borderRadius: BorderRadius.circular(14)),
                  )),
                  const SizedBox(height: 20),
                  // Chip row skeleton
                  Row(
                    children: List.generate(4, (i) => Padding(
                      padding: EdgeInsets.only(right: i < 3 ? 10 : 0),
                      child: _shimmerBox(width: 80, height: 36, borderRadius: BorderRadius.circular(18)),
                    )),
                  ),
                  const SizedBox(height: 24),
                  // Button placeholder
                  _shimmerBox(height: 52, borderRadius: BorderRadius.circular(14)),
                  const SizedBox(height: 16),
                  // Result card placeholder
                  _shimmerBox(height: 160, borderRadius: BorderRadius.circular(16)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
