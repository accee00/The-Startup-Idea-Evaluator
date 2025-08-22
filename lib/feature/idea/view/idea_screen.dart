import 'package:ai_voting_app/core/extension%20/build_context_extension.dart';
import 'package:ai_voting_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class IdeaScreen extends StatelessWidget {
  const IdeaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryLinearGradient,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    spacing: 10,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Got a brilliant idea?'),
                          Text(
                            'Share it with the community and get AI feedback!',
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.getSurfaceColor(
                            context,
                          ).withAlpha(100),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.getCardColor(context),
                  boxShadow: AppTheme.cardShadow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///name
                                Text('AI-Powered Pet Translator'),

                                /// tag line
                                Text('TagLine'),
                              ],
                            ),
                          ),

                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_border_rounded,
                                    color: context.colorScheme.outlineVariant,
                                  ),
                                  Text('8.2'),
                                ],
                              ),
                              Text('AI Score'),
                            ],
                          ),
                        ],
                      ),

                      /// description
                      Text(
                        'An app that uses machine learning to translate pet sounds into human language, helping pet owners better understand their furry friends.',
                      ),
                      const Divider(),
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.getSurfaceColor(context),
                        ),
                        child: Icon(Icons.heart_broken_outlined),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
    bottom: PreferredSize(
      preferredSize: const Size(5, 5),
      child: Divider(color: context.colorScheme.onSurface.withAlpha(30)),
    ),
    title: Text('Startup Ideas', style: context.textTheme.displaySmall),
    actions: [
      GestureDetector(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: 40,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppTheme.primaryLinearGradient,
          ),
          child: Text(
            'H',
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ],
  );
}
