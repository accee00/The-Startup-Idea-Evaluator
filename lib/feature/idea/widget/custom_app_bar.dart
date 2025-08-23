import 'package:ai_voting_app/core/extension%20/build_context_extension.dart';
import 'package:ai_voting_app/core/theme/app_theme.dart';
import 'package:ai_voting_app/feature/idea/view/main_screen.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    required this.title,
    this.showBack = false,
    this.avatarText,
    this.onAvatarTap,
    super.key,
  });

  final String title;
  final bool showBack;
  final String? avatarText;
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBack
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppTheme.getTextPrimary(context),
              ),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const MainScreen()),
                    (_) => false,
                  );
                }
              },
            )
          : null,
      title: Text(
        title,
        style: context.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppTheme.getTextPrimary(context),
        ),
      ),
      centerTitle: false,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(color: context.colorScheme.onSurface.withAlpha(30)),
      ),
      actions: avatarText != null
          ? [
              GestureDetector(
                onTap: onAvatarTap,
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
                    avatarText ?? '',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ]
          : null,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
