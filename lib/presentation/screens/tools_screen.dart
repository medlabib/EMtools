import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme/app_theme.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/widgets/animated_widgets.dart';

class ToolsScreen extends StatefulWidget {
  const ToolsScreen({super.key});

  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'all';
  bool _isSearching = false;
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();
  Set<String> _favorites = {};
  static const String _favoritesKey = 'tool_favorites';

  Map<String, String> get _categories => {
    'all': AppStrings.all,
    'favorites': AppStrings.favoritesCategory,
    'calculators': AppStrings.calculatorsCategory,
    'emergency': AppStrings.emergencyCategory,
    'icu': AppStrings.icuCategory,
    'tools': AppStrings.toolsCategory,
  };

  late final List<_ToolData> _allTools;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _allTools = [
      _ToolData(
        title: AppStrings.medicalReport,
        subtitle: AppStrings.medicalReportDesc,
        icon: Icons.assignment_outlined,
        route: '/tools/medical-report',
        category: 'emergency',
        keywords: ['rapport', 'medical', 'abcde', 'urgence', 'evaluation'],
      ),
      _ToolData(
        title: AppStrings.calculators,
        subtitle: AppStrings.calculatorsDesc,
        icon: Icons.calculate_outlined,
        route: '/tools/calculators',
        category: 'calculators',
        keywords: ['calcul', 'score', 'sofa', 'apache', 'wells', 'chads'],
      ),
      _ToolData(
        title: AppStrings.bloodGas,
        subtitle: AppStrings.bloodGasDesc,
        icon: Icons.air,
        route: '/tools/blood-gas',
        category: 'icu',
        keywords: ['gaz', 'sang', 'ph', 'paco2', 'hco3', 'acidose', 'alcalose', 'ards'],
      ),
      _ToolData(
        title: AppStrings.vasoactive,
        subtitle: AppStrings.vasoactiveDesc,
        icon: Icons.favorite_outline,
        route: '/tools/vasoactive',
        category: 'icu',
        keywords: ['vasoactif', 'noradrenaline', 'adrenaline', 'dobutamine', 'dopamine'],
      ),
      _ToolData(
        title: AppStrings.sedation,
        subtitle: AppStrings.sedationDesc,
        icon: Icons.bed_outlined,
        route: '/tools/sedation',
        category: 'icu',
        keywords: ['sedation', 'isr', 'intubation', 'propofol', 'ketamine', 'etomidate'],
      ),
      _ToolData(
        title: AppStrings.metabolic,
        subtitle: AppStrings.metabolicDesc,
        icon: Icons.water_drop_outlined,
        route: '/tools/metabolic',
        category: 'icu',
        keywords: ['metabolique', 'sodium', 'potassium', 'calcium', 'dysnatremie', 'hypokaliemie'],
      ),
      _ToolData(
        title: AppStrings.antibiotics,
        subtitle: AppStrings.antibioticsDesc,
        icon: Icons.medication_outlined,
        route: '/tools/antibiotics',
        category: 'tools',
        keywords: ['antibiotique', 'infection', 'amoxicilline', 'ceftriaxone', 'renal'],
      ),
      _ToolData(
        title: AppStrings.protocols,
        subtitle: AppStrings.protocolsDesc,
        icon: Icons.format_list_numbered,
        route: '/tools/protocols',
        category: 'emergency',
        keywords: ['protocole', 'acr', 'avc', 'sepsis', 'trauma', 'pediatrie', 'urgence', 'reanimation'],
      ),
      _ToolData(
        title: AppStrings.rcpTimer,
        subtitle: AppStrings.rcpTimerDesc,
        icon: Icons.timer,
        route: '/tools/rcp-timer',
        category: 'emergency',
        keywords: ['rcp', 'reanimation', 'acr', 'massage', 'compression', 'adrenaline', 'chronometre', 'timer'],
      ),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favorites = prefs.getStringList(_favoritesKey)?.toSet() ?? {};
    });
  }

  Future<void> _toggleFavorite(String route) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_favorites.contains(route)) {
        _favorites.remove(route);
      } else {
        _favorites.add(route);
      }
    });
    await prefs.setStringList(_favoritesKey, _favorites.toList());
  }

  bool _isFavorite(String route) => _favorites.contains(route);

  List<_ToolData> get _filteredTools {
    var tools = _allTools;
    
    // Filter by favorites
    if (_selectedCategory == 'favorites') {
      tools = tools.where((t) => _favorites.contains(t.route)).toList();
    }
    // Filter by category
    else if (_selectedCategory != 'all') {
      tools = tools.where((t) => t.category == _selectedCategory).toList();
    }
    
    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      tools = tools.where((t) {
        return t.title.toLowerCase().contains(query) ||
            t.subtitle.toLowerCase().contains(query) ||
            t.keywords.any((k) => k.toLowerCase().contains(query));
      }).toList();
    }
    
    // Sort favorites first when showing all
    if (_selectedCategory == 'all') {
      tools.sort((a, b) {
        final aFav = _favorites.contains(a.route) ? 0 : 1;
        final bFav = _favorites.contains(b.route) ? 0 : 1;
        return aFav.compareTo(bFav);
      });
    }
    
    return tools;
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchQuery = '';
        _searchController.clear();
      } else {
        // Focus on search field when opening
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _searchFocusNode.requestFocus();
        });
      }
    });
  }

  Widget _buildSearchHeader(bool isDark) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;
    final topPadding = isDesktop ? 20.0 : MediaQuery.of(context).padding.top + 16;
    
    return Container(
      padding: EdgeInsets.only(
        top: topPadding,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.getCardColor(isDark),
        border: Border(
          bottom: BorderSide(color: AppColors.getBorderColor(isDark)),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_rounded, color: AppColors.getTextPrimary(isDark)),
            onPressed: _toggleSearch,
          ),
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.getBackgroundColor(isDark),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.getBorderColor(isDark)),
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                style: TextStyle(color: AppColors.getTextPrimary(isDark), fontSize: 16),
                decoration: InputDecoration(
                  hintText: AppStrings.searchTool,
                  hintStyle: TextStyle(color: AppColors.getTextHint(isDark)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  prefixIcon: Icon(Icons.search, color: AppColors.getTextSecondary(isDark)),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: AppColors.getTextSecondary(isDark)),
                          onPressed: () {
                            setState(() {
                              _searchQuery = '';
                              _searchController.clear();
                            });
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final crossAxisCount = isTablet ? 3 : 2;
    final tools = _filteredTools;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with gradient or search bar
          SliverToBoxAdapter(
            child: _isSearching
                ? _buildSearchHeader(isDark)
                : GradientHeader(
                    title: AppStrings.toolsTitle,
                    subtitle: AppStrings.toolsSubtitle,
                    icon: Icons.medical_services_outlined,
                    height: 180,
                    actions: [
                      IconButton(
                        icon: Icon(Icons.search_rounded, color: AppColors.primary),
                        onPressed: _toggleSearch,
                      ),
                    ],
                  ),
          ),

          // Search results count when searching
          if (_isSearching && _searchQuery.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  AppStrings.toolsCount.replaceAll('{0}', '${tools.length}').replaceAll('{1}', tools.length != 1 ? 's' : '').replaceAll('{2}', _searchQuery),
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ),
            ),

          // Categories chips
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            sliver: SliverToBoxAdapter(
              child: AnimatedListItem(
                index: 0,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categories.entries.map((entry) {
                      return _CategoryChip(
                        label: entry.value,
                        isSelected: _selectedCategory == entry.key,
                        onTap: () {
                          setState(() {
                            _selectedCategory = entry.key;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),

          // Empty state when no results
          if (tools.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _selectedCategory == 'favorites' 
                          ? Icons.star_border_rounded 
                          : Icons.search_off_rounded,
                      size: 64,
                      color: isDark ? Colors.grey[600] : Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _selectedCategory == 'favorites'
                          ? AppStrings.noFavorites
                          : AppStrings.noToolFound,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _selectedCategory == 'favorites'
                          ? AppStrings.addFavoritesHint
                          : AppStrings.tryAnotherSearch,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.grey[500] : Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Tools Grid
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final tool = tools[index];
                  final isFav = _isFavorite(tool.route);
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      clipBehavior: Clip.hardEdge,
                      children: [
                        AnimatedToolCard(
                          title: tool.title,
                          subtitle: tool.subtitle,
                          icon: tool.icon,
                          onTap: () => context.go(tool.route),
                        ),
                        // Favorite button
                        Positioned(
                          top: 6,
                          right: 6,
                          child: GestureDetector(
                            onTap: () => _toggleFavorite(tool.route),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: (isDark ? Colors.black : Colors.white).withValues(alpha: 0.8),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isFav ? Icons.star_rounded : Icons.star_border_rounded,
                                size: 18,
                                color: isFav 
                                    ? Colors.amber 
                                    : (isDark ? Colors.grey[400] : Colors.grey[600]),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: tools.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolData {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
  final String category;
  final List<String> keywords;

  const _ToolData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
    required this.category,
    required this.keywords,
  });
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary
                : (isDark ? AppColors.cardDark : AppColors.cardLight),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.getBorderColor(isDark),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : AppColors.getTextSecondary(isDark),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
