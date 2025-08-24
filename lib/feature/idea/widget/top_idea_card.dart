import 'package:ai_voting_app/core/extension%20/build_context_extension.dart';
import 'package:ai_voting_app/core/theme/app_theme.dart';
import 'package:ai_voting_app/feature/idea/model/startup_idea_model.dart';
import 'package:flutter/material.dart';

class TopIdeaCard extends StatefulWidget {
  final StartupIdeaModel idea;
  final int rank;

  const TopIdeaCard({super.key, required this.idea, required this.rank});

  @override
  State<TopIdeaCard> createState() => _TopIdeaCardState();
}

class _TopIdeaCardState extends State<TopIdeaCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 6,
      child: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.getCategoryGradient(context, widget.idea.category),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.rank == 1
                      ? "🥇"
                      : widget.rank == 2
                      ? "🥈"
                      : widget.rank == 3
                      ? "🥉"
                      : "⭐",
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.idea.title,
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      if (widget.idea.tagline.isNotEmpty == true) ...[
                        const SizedBox(height: 4),
                        Text(
                          widget.idea.tagline,
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.idea.description,
                  style: context.textTheme.bodyLarge?.copyWith(
                    height: 1.4,
                    fontSize: 16,
                  ),
                  maxLines: _expanded ? null : 3,
                  overflow: _expanded
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                ),
                if (widget.idea.description.length > 150)
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rating: ${widget.idea.aiRating.toStringAsFixed(1)}",
                  style: context.textTheme.bodyMedium,
                ),
                Text(
                  "Votes: ${widget.idea.votes}",
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
