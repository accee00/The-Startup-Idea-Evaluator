import 'dart:ui';

import 'package:ai_voting_app/core/extension%20/build_context_extension.dart';
import 'package:ai_voting_app/core/theme/app_theme.dart';
import 'package:ai_voting_app/feature/idea/model/idea_model.dart';
import 'package:flutter/material.dart';

class StartupIdeaCard extends StatelessWidget {
  final StartupIdea idea;
  final bool showRanking;
  final int? rank;
  final VoidCallback? onVote;
  final VoidCallback? onComment;
  final VoidCallback? onShare;

  const StartupIdeaCard({
    super.key,
    required this.idea,
    this.showRanking = false,
    this.rank,
    this.onVote,
    this.onComment,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
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
                // Category Icon and Title
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
                              style: context.textTheme.labelLarge,
                            ),
                            const SizedBox(height: 4),

                            Wrap(
                              children: [
                                Text(
                                  idea.author,
                                  style: context.textTheme.bodySmall,
                                ),
                                Text(' • ', style: context.textTheme.bodySmall),
                                Text(
                                  _formatTimeAgo(idea.timestamp),
                                  style: context.textTheme.bodySmall,
                                ),

                                if (showRanking && rank != null) ...[
                                  const Text(
                                    ' • ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF6B7280), // gray-500
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.emoji_events,
                                        size: 12,
                                        color: Color(0xFFFBBF24), // yellow-400
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '#$rank',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF6B7280), // gray-500
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
                          size: 12,
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
                    Text('AI Score', style: context.textTheme.bodySmall),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // desc
            Text(idea.description, style: context.textTheme.bodyLarge),

            const SizedBox(height: 12),

            // Divider
            Divider(
              color: context.colorScheme.inverseSurface.withAlpha(100),
              height: 1,
            ),

            const SizedBox(height: 12),

            // Action Row
            Row(
              children: [
                // Vote Button
                Expanded(
                  child: Row(
                    children: [
                      _buildActionButton(
                        context: context,
                        icon: idea.hasVoted
                            ? Icons.favorite
                            : Icons.favorite_border,
                        label: idea.votes.toString(),
                        isActive: idea.hasVoted,
                        activeColor: AppTheme.error, // Use theme error color
                        onTap: onVote,
                      ),
                      const SizedBox(width: 16),

                      // Comment Button
                      _buildActionButton(
                        context: context,
                        icon: Icons.chat_bubble_outline,
                        label: idea.comments.toString(),
                        isActive: false,
                        onTap: onComment,
                      ),
                    ],
                  ),
                ),

                // Share Button
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
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? (activeColor ?? context.colorScheme.primary).withAlpha(100)
              : context.colorScheme.surface.withAlpha(100),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isActive
                  ? (activeColor ?? context.colorScheme.primary)
                  : context.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isActive
                    ? (activeColor ?? context.colorScheme.primary)
                    : context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareButton(BuildContext context) {
    return GestureDetector(
      onTap: onShare,
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
      return '${diff.inDays}d ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}h ago';
    } else {
      return 'Just now';
    }
  }
}
