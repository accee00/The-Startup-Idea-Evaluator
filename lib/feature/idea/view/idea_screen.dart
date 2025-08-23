import 'package:ai_voting_app/core/constants/app_text.dart';

import 'package:ai_voting_app/feature/idea/model/idea_model.dart';
import 'package:ai_voting_app/feature/idea/view/add_idea.dart';

import 'package:ai_voting_app/feature/idea/widget/add_idea_card.dart';
import 'package:ai_voting_app/feature/idea/widget/custom_app_bar.dart';
import 'package:ai_voting_app/feature/idea/widget/startup_idea_card.dart';

import 'package:flutter/material.dart';

class IdeaScreen extends StatelessWidget {
  const IdeaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final idea = StartupIdea(
      id: 1,
      title: "AI-Powered Pet Translator",
      description:
          "An app that uses machine learning to translate pet sounds into human language, helping pet owners better understand their furry friends.",
      category: "AI/ML",
      author: "Sarah J.",
      aiRating: 8.2,
      votes: 234,
      comments: 45,
      hasVoted: false,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    );
    return Scaffold(
      appBar: const CustomAppBar(title: 'Startup Ideas', avatarText: 'H'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SafeArea(
          child: Column(
            children: [
              AddIdeaCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddIdeaScreen()),
                  );
                },
                heading: AppText.cardHeading,
                subHeading: AppText.cardSubheading,
              ),
              const SizedBox(height: 15),
              StartupIdeaCard(onVote: () {}, idea: idea),
            ],
          ),
        ),
      ),
    );
  }
}
