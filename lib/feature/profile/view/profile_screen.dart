import 'package:ai_voting_app/core/bloc/app_bloc.dart';
import 'package:ai_voting_app/core/extension%20/build_context_extension.dart';
import 'package:ai_voting_app/core/routes/app_routes.dart';

import 'package:ai_voting_app/core/theme/app_theme.dart';
import 'package:ai_voting_app/feature/auth/cubit/auth_cubit.dart';
import 'package:ai_voting_app/feature/idea/widget/custom_app_bar.dart';
import 'package:ai_voting_app/feature/profile/cubit/profile_cubit.dart';
import 'package:ai_voting_app/feature/profile/model/profile_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User currentUser;

  @override
  void initState() {
    currentUser = (context.read<AuthCubit>().state as AuthUserState).user;
    context.read<ProfileCubit>().fetchUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        onModeChange: () {
          context.read<AppBloc>().add(ToggleTheme());
        },
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final ProfileModel data = state.userProfile;
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildProfileHeader(context),
                  const SizedBox(height: 32),

                  _buildStatsList(context, data),
                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Ideas',
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),

                        data.myIdeas.isEmpty
                            ? _emptyState(context)
                            : _buildIdeasList(context, data),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIdeasList(BuildContext context, ProfileModel data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: data.myIdeas.length,
        itemBuilder: (context, index) {
          final idea = data.myIdeas[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 6,
            child: Container(
              decoration: BoxDecoration(
                gradient: AppTheme.getCategoryGradient(context, idea.category),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    idea.title,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (idea.tagline.isNotEmpty == true) ...[
                    const SizedBox(height: 4),
                    Text(
                      idea.tagline,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ],

                  const SizedBox(height: 6),
                  Text(
                    idea.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "⭐ Rating: ${idea.aiRating.toStringAsFixed(1)}",
                        style: context.textTheme.bodyMedium,
                      ),
                      Text(
                        "👍 Votes: ${idea.votes}",
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container _emptyState(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: Column(
        children: [
          Icon(
            Icons.lightbulb_outline,
            size: 48,
            color: context.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No ideas submitted yet',
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start sharing your brilliant ideas with the community!',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.addIdea),
            icon: const Icon(Icons.add),
            label: const Text('Submit Your First Idea'),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colorScheme.primary,
              foregroundColor: context.colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsList(BuildContext context, ProfileModel data) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colorScheme.outline.withAlpha(100)),
      ),
      child: Column(
        children: [
          _buildStatItem(
            context: context,
            icon: Icons.lightbulb,
            title: 'Ideas Submitted',
            value: data.ideadSubmitted,
            color: context.colorScheme.primary,
            backgroundColor: context.colorScheme.primaryContainer,
          ),
          Divider(height: 1, color: context.colorScheme.outline.withAlpha(100)),
          _buildStatItem(
            context: context,
            icon: Icons.thumb_up,
            title: 'Votes Given',
            value: data.votesGiven,
            color: context.colorScheme.secondary,
            backgroundColor: context.colorScheme.secondaryContainer,
          ),
          Divider(height: 1, color: context.colorScheme.outline.withAlpha(100)),
          _buildStatItem(
            context: context,
            icon: Icons.favorite,
            title: 'Votes Received',
            value: data.votesReceived,
            color: context.colorScheme.primary,
            backgroundColor: context.colorScheme.primaryContainer,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white60, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Total count',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final userName = currentUser.userMetadata?['name'] as String? ?? 'No Name';
    final userInitial = userName.isNotEmpty ? userName[0].toUpperCase() : '';

    return Column(
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppTheme.primaryLinearGradient,
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.primary.withAlpha(100),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Text(
              userInitial,
              style: context.textTheme.headlineLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 48,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        Text(
          userName,
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
