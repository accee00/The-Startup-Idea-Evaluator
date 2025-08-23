import 'package:ai_voting_app/core/extension%20/build_context_extension.dart';
import 'package:ai_voting_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AddIdeaCard extends StatelessWidget {
  const AddIdeaCard({
    super.key,
    required this.heading,
    required this.subHeading,
    this.onTap,
  });
  final String heading;
  final String subHeading;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: AppTheme.primaryLinearGradient,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
        child: Row(
          spacing: 10,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subHeading,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withAlpha(200),
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.getSurfaceColor(context).withAlpha(100),
                ),
                child: Icon(Icons.add, color: Colors.white.withAlpha(200)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
