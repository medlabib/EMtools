import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/datasources/protocols_data.dart';
import '../../../../domain/entities/protocol.dart';

// Pediatric pink color for highlighting pediatric protocols
const Color _pediatricPink = Color(0xFFEC4899);

class ProtocolsScreen extends StatefulWidget {
  const ProtocolsScreen({super.key});

  @override
  State<ProtocolsScreen> createState() => _ProtocolsScreenState();
}

class _ProtocolsScreenState extends State<ProtocolsScreen> {
  String _searchQuery = '';
  ProtocolCategory? _selectedCategory;
  bool _showPediatricOnly = false;
  final _searchController = TextEditingController();
  Set<String> _favorites = {};
  static const String _favoritesKey = 'protocol_favorites';

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favorites = prefs.getStringList(_favoritesKey)?.toSet() ?? {};
    });
  }

  Future<void> _toggleFavorite(String protocolId) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_favorites.contains(protocolId)) {
        _favorites.remove(protocolId);
      } else {
        _favorites.add(protocolId);
      }
    });
    await prefs.setStringList(_favoritesKey, _favorites.toList());
  }

  List<Protocol> get _filteredProtocols {
    var protocols = allProtocols;

    // Filter by category
    if (_selectedCategory != null) {
      protocols = protocols.where((p) => p.category == _selectedCategory).toList();
    }

    // Filter pediatric only
    if (_showPediatricOnly) {
      protocols = protocols.where((p) => p.isPediatric).toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      protocols = protocols.where((p) {
        return p.name.toLowerCase().contains(query) ||
            p.description.toLowerCase().contains(query) ||
            p.category.displayName.toLowerCase().contains(query);
      }).toList();
    }

    // Sort favorites first, then alphabetically
    protocols.sort((a, b) {
      final aFav = _favorites.contains(a.id);
      final bFav = _favorites.contains(b.id);
      if (aFav && !bFav) return -1;
      if (!aFav && bFav) return 1;
      return a.name.compareTo(b.name);
    });

    return protocols;
  }

  int get _totalProtocolCount => allProtocols.length;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredProtocols = _filteredProtocols;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Protocoles'),
        actions: [
          IconButton(
            icon: Icon(
              _showPediatricOnly ? Icons.child_care : Icons.child_care_outlined,
              color: _showPediatricOnly ? _pediatricPink : null,
            ),
            tooltip: 'Pédiatrie uniquement',
            onPressed: () {
              setState(() {
                _showPediatricOnly = !_showPediatricOnly;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher un protocole...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Category chips
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildCategoryChip(null, 'Tous', Icons.all_inclusive),
                ...ProtocolCategory.values.map((category) =>
                    _buildCategoryChip(category, category.displayName, category.icon)),
              ],
            ),
          ),

          // Stats bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  '${filteredProtocols.length} protocole${filteredProtocols.length > 1 ? 's' : ''}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                if (_favorites.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Icon(Icons.star, size: 14, color: Colors.amber.shade600),
                  const SizedBox(width: 4),
                  Text(
                    '${_favorites.length} favori${_favorites.length > 1 ? 's' : ''}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                const Spacer(),
                Text(
                  'Total: $_totalProtocolCount',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // Protocols list
          Expanded(
            child: filteredProtocols.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Aucun protocole trouvé',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredProtocols.length,
                    itemBuilder: (context, index) {
                      final protocol = filteredProtocols[index];
                      return _buildProtocolCard(protocol, theme);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(ProtocolCategory? category, String label, IconData icon) {
    final isSelected = _selectedCategory == category;
    final color = category?.color ?? Colors.grey;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : color,
            ),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedCategory = selected ? category : null;
          });
        },
        selectedColor: color,
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : null,
        ),
      ),
    );
  }

  Widget _buildProtocolCard(Protocol protocol, ThemeData theme) {
    final isFavorite = _favorites.contains(protocol.id);
    final categoryColor = protocol.category.color;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          context.push('/tools/protocols/${protocol.id}');
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: categoryColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      protocol.category.icon,
                      color: categoryColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                protocol.name,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (protocol.isPediatric)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _pediatricPink.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.child_care,
                                      size: 12,
                                      color: _pediatricPink,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      'Pédia',
                                      style: theme.textTheme.labelSmall?.copyWith(
                                        color: _pediatricPink,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          protocol.category.displayName,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: categoryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: isFavorite ? Colors.amber.shade600 : null,
                    ),
                    onPressed: () => _toggleFavorite(protocol.id),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                protocol.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.format_list_numbered,
                    size: 14,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${protocol.steps.length} étapes',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (protocol.source.isNotEmpty) ...[
                    const SizedBox(width: 16),
                    Icon(
                      Icons.source,
                      size: 14,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        protocol.source,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
