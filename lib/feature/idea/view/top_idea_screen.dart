import 'package:ai_voting_app/core/extension%20/build_context_extension.dart';
import 'package:ai_voting_app/core/theme/app_theme.dart';
import 'package:ai_voting_app/feature/idea/cubit/idea_cubit.dart';
import 'package:ai_voting_app/feature/idea/widget/custom_app_bar.dart';
import 'package:ai_voting_app/feature/idea/widget/top_idea_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopIdeaScreen extends StatefulWidget {
  const TopIdeaScreen({super.key});

  @override
  State<TopIdeaScreen> createState() => _TopIdeaScreenState();
}

class _TopIdeaScreenState extends State<TopIdeaScreen> {
  @override
  void initState() {
    context.read<IdeaCubit>().fetchLeaderBoardd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getBackgroundColor(context),
      appBar: const CustomAppBar(title: "Top Ideas", showBack: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<IdeaCubit, IdeaState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchLeaderBoardFailureState) {
                return Center(child: Text(state.errorMessage));
              }
              if (state is FetchLeaderBoardSuccessState &&
                  state.leaderBoard.isEmpty) {
                return Column(
                  children: [
                    Text(
                      "No ideas found.",
                      style: context.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildLeaderboardCard(context),
                  ],
                );
              }
              if (state is FetchLeaderBoardSuccessState) {
                final topIdeas = state.leaderBoard.take(5).toList();
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ).copyWith(bottom: 100),
                    itemCount: topIdeas.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return _buildLeaderboardCard(context);
                      }

                      final idea = topIdeas[index - 1];

                      return TopIdeaCard(idea: idea, rank: index);
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Container _buildLeaderboardCard(BuildContext context) {
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
}
