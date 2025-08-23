import 'package:ai_voting_app/core/constants/app_text.dart';
import 'package:ai_voting_app/core/routes/app_routes.dart';
import 'package:ai_voting_app/core/theme/app_theme.dart';
import 'package:ai_voting_app/feature/auth/cubit/auth_cubit.dart';
import 'package:ai_voting_app/feature/idea/cubit/idea_cubit.dart';
import 'package:ai_voting_app/feature/idea/widget/add_idea_card.dart';
import 'package:ai_voting_app/feature/idea/widget/custom_app_bar.dart';
import 'package:ai_voting_app/feature/idea/widget/startup_idea_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdeaScreen extends StatefulWidget {
  const IdeaScreen({super.key});

  @override
  State<IdeaScreen> createState() => _IdeaScreenState();
}

class _IdeaScreenState extends State<IdeaScreen> {
  String avatarText = '';

  @override
  void initState() {
    super.initState();
    context.read<IdeaCubit>().getStartupIdeas();
    final user = (context.read<AuthCubit>().state as AuthUserState).user;
    final name = user.userMetadata?['name'] ?? '';
    avatarText = name.isNotEmpty ? name[0].toUpperCase() : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getBackgroundColor(context),
      appBar: CustomAppBar(title: 'Startup Ideas', avatarText: avatarText),
      body: SafeArea(
        child: BlocBuilder<IdeaCubit, IdeaState>(
          buildWhen: (prev, curr) =>
              prev.runtimeType != curr.runtimeType || prev.ideas != curr.ideas,
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetStartupIdeasFailureState) {
              return Center(child: Text(state.errorMessage));
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ).copyWith(bottom: 100),
              itemCount: state.ideas.length + 1,

              itemBuilder: (context, index) {
                if (index == 0) {
                  return _addIdeaCard(context);
                }
                final idea = state.ideas[index - 1];
                return StartupIdeaCard(
                  idea: idea,
                  onVote: () {
                    context.read<IdeaCubit>().toggleVote(idea.id!);
                  },
                  onShare: () {},
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _addIdeaCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18, top: 10),
      child: AddIdeaCard(
        onTap: () => Navigator.pushNamed(context, AppRoutes.addIdea),
        heading: AppText.cardHeading,
        subHeading: AppText.cardSubheading,
      ),
    );
  }
}
