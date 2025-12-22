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

  final _categories = <String, String>{
    'all': 'Tous',
    'favorites': '⭐ Favoris',
    'calculators': 'Calculateurs',
    'emergency': 'Urgences',
    'icu': 'Réanimation',
    'tools': 'Outils',
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
        gradient: AppColors.medicalGradient,
        route: '/tools/medical-report',
        category: 'emergency',
        keywords: ['rapport', 'medical', 'abcde', 'urgence', 'evaluation'],
      ),
      _ToolData(
        title: AppStrings.calculators,
        subtitle: AppStrings.calculatorsDesc,
        icon: Icons.calculate_outlined,
        color: AppColors.success,
        route: '/tools/calculators',
        category: 'calculators',
        keywords: ['calcul', 'score', 'sofa', 'apache', 'wells', 'chads'],
      ),
      _ToolData(
        title: AppStrings.bloodGas,
        subtitle: AppStrings.bloodGasDesc,
        icon: Icons.air,
        color: AppColors.error,
        route: '/tools/blood-gas',
        category: 'icu',
        keywords: ['gaz', 'sang', 'ph', 'paco2', 'hco3', 'acidose', 'alcalose', 'ards'],
      ),
      _ToolData(
        title: AppStrings.vasoactive,
        subtitle: AppStrings.vasoactiveDesc,
        icon: Icons.favorite_outline,
        color: AppColors.warning,
        route: '/tools/vasoactive',
        category: 'icu',
        keywords: ['vasoactif', 'noradrenaline', 'adrenaline', 'dobutamine', 'dopamine'],
      ),
      _ToolData(
        title: AppStrings.sedation,
        subtitle: AppStrings.sedationDesc,
        icon: Icons.bed_outlined,
        color: AppColors.accentTeal,
        route: '/tools/sedation',
        category: 'icu',
        keywords: ['sedation', 'isr', 'intubation', 'propofol', 'ketamine', 'etomidate'],
      ),
      _ToolData(
        title: AppStrings.metabolic,
        subtitle: AppStrings.metabolicDesc,
        icon: Icons.water_drop_outlined,
        color: AppColors.primaryIndigo,
        route: '/tools/metabolic',
        category: 'icu',
        keywords: ['metabolique', 'sodium', 'potassium', 'calcium', 'dysnatremie', 'hypokaliemie'],
      ),
      _ToolData(
        title: AppStrings.antibiotics,
        subtitle: AppStrings.antibioticsDesc,
        icon: Icons.medication_outlined,
        gradient: AppColors.accentGradient,
        route: '/tools/antibiotics',
        category: 'tools',
        keywords: ['antibiotique', 'infection', 'amoxicilline', 'ceftriaxone', 'renal'],
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
        gradient: AppColors.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: _toggleSearch,
          ),
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(22),
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Rechercher un outil...',
                  hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  prefixIcon: Icon(Icons.search, color: Colors.white.withValues(alpha: 0.7)),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.white.withValues(alpha: 0.7)),
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
                        icon: const Icon(Icons.search_rounded, color: Colors.white),
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
                  '${tools.length} résultat${tools.length != 1 ? 's' : ''} pour "$_searchQuery"',
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
                          ? 'Aucun favori'
                          : 'Aucun outil trouvé',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _selectedCategory == 'favorites'
                          ? 'Appuyez sur ⭐ pour ajouter des favoris'
                          : 'Essayez une autre recherche',
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
                childAspectRatio: 1.1,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final tool = tools[index];
                  final isFav = _isFavorite(tool.route);
                  return Stack(
                    children: [
                      AnimatedToolCard(
                        title: tool.title,
                        subtitle: tool.subtitle,
                        icon: tool.icon,
                        iconColor: tool.color,
                        gradient: tool.gradient,
                        onTap: () => context.go(tool.route),
                        animationDelay: 100 + (index * 50),
                      ),
                      // Favorite button
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => _toggleFavorite(tool.route),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: (isDark ? Colors.black : Colors.white).withValues(alpha: 0.7),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isFav ? Icons.star_rounded : Icons.star_border_rounded,
                              size: 20,
                              color: isFav 
                                  ? Colors.amber 
                                  : (isDark ? Colors.grey[400] : Colors.grey[600]),
                            ),
                          ),
                        ),
                      ),
                    ],
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
  final Color? color;
  final Gradient? gradient;
  final String route;
  final String category;
  final List<String> keywords;

  const _ToolData({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.color,
    this.gradient,
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
            gradient: isSelected ? AppColors.primaryGradient : null,
            color: isSelected
                ? null
                : (isDark ? AppColors.cardDark : AppColors.cardLight),
            borderRadius: BorderRadius.circular(20),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primaryBlue.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : (isDark ? Colors.grey[300] : Colors.grey[700]),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
