import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../data/datasources/protocols_data.dart';
import '../../../../domain/entities/protocol.dart';

// Pediatric pink color for highlighting pediatric protocols
const Color _pediatricPink = Color(0xFFEC4899);

class ProtocolDetailScreen extends StatelessWidget {
  final String protocolId;

  const ProtocolDetailScreen({
    super.key,
    required this.protocolId,
  });

  @override
  Widget build(BuildContext context) {
    final protocol = allProtocols.firstWhere(
      (p) => p.id == protocolId,
      orElse: () => throw Exception('Protocole non trouvé'),
    );

    return _ProtocolDetailContent(protocol: protocol);
  }
}

class _ProtocolDetailContent extends StatefulWidget {
  final Protocol protocol;

  const _ProtocolDetailContent({required this.protocol});

  @override
  State<_ProtocolDetailContent> createState() => _ProtocolDetailContentState();
}

class _ProtocolDetailContentState extends State<_ProtocolDetailContent> {
  final Set<int> _expandedSteps = {};

  @override
  void initState() {
    super.initState();
    // Expand first step by default
    if (widget.protocol.steps.isNotEmpty) {
      _expandedSteps.add(0);
    }
  }

  void _toggleStep(int index) {
    setState(() {
      if (_expandedSteps.contains(index)) {
        _expandedSteps.remove(index);
      } else {
        _expandedSteps.add(index);
      }
    });
  }

  void _expandAll() {
    setState(() {
      _expandedSteps.addAll(List.generate(widget.protocol.steps.length, (i) => i));
    });
  }

  void _collapseAll() {
    setState(() {
      _expandedSteps.clear();
    });
  }

  Future<void> _openSource() async {
    final sourceUrl = widget.protocol.sourceUrl;
    if (sourceUrl != null && sourceUrl.isNotEmpty) {
      final uri = Uri.parse(sourceUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }
  }

  bool get _hasSourceUrl {
    final url = widget.protocol.sourceUrl;
    return url != null && url.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final protocol = widget.protocol;
    final categoryColor = protocol.category.color;
    final indication = protocol.indication;
    final contraindication = protocol.contraindication;
    final keyPoints = protocol.keyPoints;
    final lastUpdated = protocol.lastUpdated;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with protocol info
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      categoryColor,
                      categoryColor.withValues(alpha: 0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    protocol.category.icon,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    protocol.category.displayName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (protocol.isPediatric) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _pediatricPink,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.child_care,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Pédiatrie',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          protocol.name,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          protocol.description,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  switch (value) {
                    case 'expand':
                      _expandAll();
                      break;
                    case 'collapse':
                      _collapseAll();
                      break;
                    case 'source':
                      _openSource();
                      break;
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'expand',
                    child: Row(
                      children: [
                        Icon(Icons.unfold_more),
                        SizedBox(width: 8),
                        Text('Tout déplier'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'collapse',
                    child: Row(
                      children: [
                        Icon(Icons.unfold_less),
                        SizedBox(width: 8),
                        Text('Tout replier'),
                      ],
                    ),
                  ),
                  if (_hasSourceUrl)
                    const PopupMenuItem(
                      value: 'source',
                      child: Row(
                        children: [
                          Icon(Icons.open_in_new),
                          SizedBox(width: 8),
                          Text('Voir la source'),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Indication card
                  if (indication != null && indication.isNotEmpty)
                    _buildInfoCard(
                      context,
                      title: 'Indications',
                      content: indication,
                      icon: Icons.check_circle_outline,
                      color: Colors.green,
                    ),

                  // Contraindication card
                  if (contraindication != null && contraindication.isNotEmpty)
                    _buildInfoCard(
                      context,
                      title: 'Contre-indications',
                      content: contraindication,
                      icon: Icons.cancel_outlined,
                      color: Colors.red,
                    ),

                  const SizedBox(height: 16),

                  // Steps section header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Étapes du protocole',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${protocol.steps.length} étapes',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),

          // Steps list
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final step = protocol.steps[index];
                final isExpanded = _expandedSteps.contains(index);

                return _buildStepCard(
                  context,
                  step: step,
                  index: index,
                  isExpanded: isExpanded,
                  onTap: () => _toggleStep(index),
                  categoryColor: categoryColor,
                );
              },
              childCount: protocol.steps.length,
            ),
          ),

          // Key points and source
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Key points
                  if (keyPoints != null && keyPoints.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildKeyPointsCard(context, keyPoints, categoryColor),
                  ],

                  // Source info
                  if (protocol.source.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildSourceCard(context, protocol),
                  ],

                  // Last updated
                  if (lastUpdated != null) ...[
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        'Dernière mise à jour: $lastUpdated',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required String content,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCard(
    BuildContext context, {
    required ProtocolStep step,
    required int index,
    required bool isExpanded,
    required VoidCallback onTap,
    required Color categoryColor,
  }) {
    final theme = Theme.of(context);
    final bulletPoints = step.bulletPoints;
    final warning = step.warning;
    final tip = step.tip;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            // Step header
            InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: categoryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        step.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),

            // Expanded content
            if (isExpanded) ...[
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main content
                    if (step.content.isNotEmpty)
                      Text(
                        step.content,
                        style: theme.textTheme.bodyMedium,
                      ),

                    // Bullet points
                    if (bulletPoints != null && bulletPoints.isNotEmpty) ...[
                      if (step.content.isNotEmpty) const SizedBox(height: 12),
                      ...bulletPoints.map((point) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  margin: const EdgeInsets.only(top: 6, right: 12),
                                  decoration: BoxDecoration(
                                    color: categoryColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    point,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],

                    // Warning box
                    if (warning != null && warning.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.red.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.warning_amber,
                              color: Colors.red,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                warning,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.red.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    // Tip box
                    if (tip != null && tip.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.blue.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.lightbulb_outline,
                              color: Colors.blue,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                tip,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildKeyPointsCard(BuildContext context, String keyPoints, Color categoryColor) {
    final theme = Theme.of(context);

    return Card(
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
                  child: Icon(Icons.star, color: categoryColor, size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  'Points clés',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              keyPoints,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceCard(BuildContext context, Protocol protocol) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: _hasSourceUrl ? _openSource : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.source, color: Colors.grey, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Source',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      protocol.source,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              if (_hasSourceUrl)
                const Icon(Icons.open_in_new, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
