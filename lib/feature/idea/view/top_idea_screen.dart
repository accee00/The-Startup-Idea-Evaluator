import 'package:ai_voting_app/core/extension%20/build_context_extension.dart';
import 'package:ai_voting_app/core/theme/app_theme.dart';
import 'package:ai_voting_app/feature/idea/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class TopIdeaScreen extends StatelessWidget {
  const TopIdeaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ideas = [
      {
        "name": "EcoCart",
        "tagline": "Sustainable shopping made easy",
        "rating": 92,
        "votes": 120,
      },
      {
        "name": "FitAI",
        "tagline": "AI powered fitness coach",
        "rating": 88,
        "votes": 110,
      },
      {
        "name": "FoodShare",
        "tagline": "Donate food with a tap",
        "rating": 85,
        "votes": 95,
      },
      {
        "name": "StudySync",
        "tagline": "AI peer-to-peer learning",
        "rating": 82,
        "votes": 90,
      },
      {
        "name": "MediConnect",
        "tagline": "Smart healthcare access",
        "rating": 80,
        "votes": 85,
      },
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: "Top Ideas", showBack: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: ideas.length + 1, // +1 for header
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),

                      gradient: AppTheme.yellowOrangeLinearGradient,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.emoji_events_outlined,
                          color: context.colorScheme.onPrimary,
                          size: 28,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Leaderboard",
                              style: context.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.onPrimary,
                              ),
                            ),
                            Text(
                              'Most voted startup ideas',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }

                // Adjust index for ideas
                final idea = ideas[index - 1];
                final ideaIndex = index - 1;

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: ideaIndex == 0
                            ? [
                                Colors.amber.shade300,
                                Colors.amber.shade600,
                              ] // 🥇
                            : ideaIndex == 1
                            ? [Colors.grey.shade400, Colors.grey.shade700] // 🥈
                            : ideaIndex == 2
                            ? [
                                Colors.brown.shade400,
                                Colors.brown.shade700,
                              ] // 🥉
                            : [
                                Colors.blueGrey.shade200,
                                Colors.blueGrey.shade400,
                              ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              ideaIndex == 0
                                  ? "🥇"
                                  : ideaIndex == 1
                                  ? "🥈"
                                  : ideaIndex == 2
                                  ? "🥉"
                                  : "⭐",
                              style: const TextStyle(fontSize: 22),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                idea["name"]!.toString(),
                                style: context.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          idea["tagline"]!.toString(),
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "⭐ Rating: ${idea["rating"]}",
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "👍 Votes: ${idea["votes"]}",
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
