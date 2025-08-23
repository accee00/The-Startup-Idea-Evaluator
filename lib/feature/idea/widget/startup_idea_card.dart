import 'dart:ui';

import 'package:ai_voting_app/core/di/init_di_imports.dart';
import 'package:ai_voting_app/core/extension%20/build_context_extension.dart';
import 'package:ai_voting_app/core/theme/app_theme.dart';
import 'package:ai_voting_app/feature/idea/model/startup_idea_model.dart';
import 'package:ai_voting_app/service/idea_service.dart';
import 'package:flutter/material.dart';

class StartupIdeaCard extends StatefulWidget {
  final StartupIdeaModel idea;
  final bool showRanking;
  final int? rank;
  final VoidCallback? onVote;
  final VoidCallback? onShare;

  const StartupIdeaCard({
    super.key,
    required this.idea,
    this.showRanking = false,
    this.rank,
    this.onVote,
    this.onShare,
  });

  @override
  State<StartupIdeaCard> createState() => _StartupIdeaCardState();
}

class _StartupIdeaCardState extends State<StartupIdeaCard> {
  bool _expanded = false;
  bool? _hasVoted;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkVoteStatus();
  }

  // Check vote status asynchronously
  Future<void> _checkVoteStatus() async {
    try {
      final hasVoted = await servicelocator<IdeaService>().hasUserVoted(
        ideaId: widget.idea.id!,
      );
      if (mounted) {
        setState(() {
          _hasVoted = hasVoted;
        });
      }
    } catch (e) {
      // Handle error - fallback to idea.hasVoted
      if (mounted) {
        setState(() {
          _hasVoted = widget.idea.hasVoted;
        });
      }
    }
  }

  // Handle vote tap with loading state
  Future<void> _onVoteTap() async {
    if (_isLoading) return; // Prevent multiple taps

    setState(() {
      _isLoading = true;
    });

    try {
      // Call the parent callback
      widget.onVote?.call();

      // Update local state optimistically
      setState(() {
        _hasVoted = !(_hasVoted ?? false);
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final idea = widget.idea;
    final isVoted = _hasVoted ?? idea.hasVoted;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.getBorderColor(context)),
        color: AppTheme.getBackgroundColor(context),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Icon
                      Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: Text(
                          _getCategoryIcon(idea.category),
                          style: const TextStyle(fontSize: 32),
                        ),
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              idea.title,
                              style: context.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),

                            Wrap(
                              children: [
                                Text(
                                  idea.authorName ?? 'Anonymous',
                                  style: context.textTheme.bodyMedium,
                                ),
                                Text(' • ', style: context.textTheme.bodySmall),
                                Text(
                                  _formatTimeAgo(idea.createdAt),
                                  style: context.textTheme.bodyMedium,
                                ),

                                if (widget.showRanking &&
                                    widget.rank != null) ...[
                                  Text(
                                    ' • ',
                                    style: context.textTheme.bodyMedium,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.emoji_events,
                                        size: 12,
                                        color: Color(0xFFFBBF24),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '#${widget.rank}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF6B7280),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          size: 24,
                          color: context.colorScheme.tertiary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          idea.aiRating.toStringAsFixed(1),
                          style: context.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text('AI Score', style: context.textTheme.bodyMedium),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // desc with show more
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  idea.description,
                  style: context.textTheme.bodyLarge?.copyWith(
                    height: 1.4,
                    fontSize: 16,
                  ),
                  maxLines: _expanded ? null : 5,
                  overflow: _expanded
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                ),
                if (idea.description.length > 150)
                  GestureDetector(
                    onTap: () => setState(() => _expanded = !_expanded),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        _expanded ? 'Show less' : 'Show more',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // Divider
            Divider(
              color: context.colorScheme.inverseSurface.withAlpha(100),
              height: 1,
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      _buildActionButton(
                        context: context,
                        icon: isVoted ? Icons.favorite : Icons.favorite_border,
                        label: idea.votes.toString(),
                        isActive: isVoted,
                        activeColor: AppTheme.error,
                        onTap: _onVoteTap,
                        isLoading: _isLoading,
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                ),

                _buildShareButton(context),
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
    required bool isActive,
    Color? activeColor,
    VoidCallback? onTap,
    required BuildContext context,
    bool isLoading = false,
  }) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? (activeColor ?? AppTheme.error).withAlpha(30)
              : context.colorScheme.surface.withAlpha(100),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive
                ? (activeColor ?? AppTheme.error).withAlpha(100)
                : Colors.transparent,
            width: 1,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: (activeColor ?? AppTheme.error).withAlpha(50),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading)
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isActive
                        ? (activeColor ?? AppTheme.error)
                        : context.colorScheme.onSurfaceVariant,
                  ),
                ),
              )
            else
              AnimatedScale(
                scale: isActive ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  icon,
                  size: 16,
                  color: isActive
                      ? (activeColor ?? AppTheme.error)
                      : context.colorScheme.onSurfaceVariant,
                ),
              ),
            const SizedBox(width: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive
                    ? (activeColor ?? AppTheme.error)
                    : context.colorScheme.onSurfaceVariant,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareButton(BuildContext context) {
    return GestureDetector(
      onTap: widget.onShare,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          Icons.share_outlined,
          size: 16,
          color: context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  String _getCategoryIcon(String category) {
    const icons = {
      'AI/ML': '🤖',
      'Tech': '💻',
      'Health & Wellness': '🏥',
      'Sustainability': '🌱',
      'Blockchain': '⛓️',
      'Education': '📚',
      'Finance': '💰',
      'Social': '👥',
    };
    return icons[category] ?? '💡';
  }

  String _formatTimeAgo(DateTime timestamp) {
    final diff = DateTime.now().difference(timestamp);

    if (diff.inDays > 0) {
      final hours = diff.inHours % 24;
      return '${diff.inDays}d ${hours}h ago';
    } else if (diff.inHours > 0) {
      final minutes = diff.inMinutes % 60;
      return '${diff.inHours}h ${minutes}m ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
